import 'package:cabs/constants/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_constants.dart';
import '../../../services/cabs_api_service.dart';
import '../../../services/comFuncService.dart';
import '../../../widgets/custom_text_field.dart';
import '../../main_container.dart';
import 'cancel_booking_model.dart';
import 'my_booking_list_model.dart';

class UserMyBookings extends StatefulWidget {
  @override
  _userMyBookingsState createState() => _userMyBookingsState();
}

class _userMyBookingsState extends State<UserMyBookings> {
  final CabsApiService apiService = CabsApiService();
  String? _selectedReason;
  final TextEditingController _descriptionController = TextEditingController();
  String? formattedDate;

  @override
  void initState() {
    getbookingList();

    super.initState();
  }

  bool isLoading = false;
  List<BookingList>? bookingList;
  List<BookingList>? bookingListtAll;

  List<BookingList>? upcomingBookings;
  List<BookingList>? completedBookings;

  Future getbookingList() async {
    await apiService.getBearerToken();
    var result = await apiService.getbookingList();
    var response = bookingListDataFromJson(result);
    if (response.status.toString() == 'SUCCESS') {
      setState(() {
        bookingList = response.list;
        // bookingListtAll = bookingList;
        upcomingBookings = bookingList!
            .where((booking) =>
                booking.bookingStatus.trim().toUpperCase() != 'COMPLETED' &&
                booking.bookingStatus.trim().toUpperCase() != 'CANCELLED')
            .toList();

        completedBookings = bookingList!
            .where((booking) =>
                booking.bookingStatus.trim().toUpperCase() == 'COMPLETED')
            .toList();

        bookingList!.forEach((booking) {});
        isLoading = false;
      });
    } else {
      setState(() {
        bookingList = [];
        bookingListtAll = [];
        isLoading = false;
      });
      showInSnackBar(context, response.message.toString());
    }
    setState(() {});
  }

  Future updatecancelbooking(int cancleid) async {
    await apiService.getBearerToken();

    Map<String, dynamic> postData = {
      "booking_id": cancleid,
      "cancel_reason": _descriptionController.text,
    };

    var result = await apiService.updatecancelbooking(postData);
    CancelAddModel response = cancelAddModelFromJson(result);

    if (response.status.toString() == 'SUCCESS') {
      showInSnackBar(context, response.message.toString());
      // Navigator.pop(context, {'add': true});
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MainContainer(),
        ),
      );
    } else {
      print(response.message.toString());
      showInSnackBar(context, response.message.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "My Bookings",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color(0xFF06234C),
          automaticallyImplyLeading: false,
        ),
        body: DefaultTabController(
            length: 2,
            child: Column(children: [
              Container(
                  child: TabBar(
                dividerColor: Colors.transparent,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.black26,
                tabs: [
                  Tab(text: "Upcoming"),
                  Tab(text: "Completed"),
                ],
              )),
              Expanded(
                  child: TabBarView(children: [
                SingleChildScrollView(
                    child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      isLoading
                          ? Center(child: CircularProgressIndicator())
                          : Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // CustomeTextField(
                                    //   width: MediaQuery.of(context).size.width -
                                    //       10.0,
                                    //   hint: 'Search Bookings',
                                    //   suffixIcon: Icon(
                                    //     Icons.search,
                                    //     color: AppColors.lightGrey3,
                                    //     size: 20.0,
                                    //   ),
                                    //   labelColor: AppColors.primary,
                                    //   // borderColor: AppColors.primary2,
                                    //   focusBorderColor: AppColors.primary,
                                    //   borderRadius: BorderRadius.all(
                                    //       Radius.circular(20.0)),
                                    //   borderColor: AppColors.lightGrey3,
                                    //   onChanged: (value) {
                                    //     if (value != '') {
                                    //       print('value $value');
                                    //       value =
                                    //           value.toString().toLowerCase();
                                    //       bookingList = upcomingBookings!
                                    //           .where((BookingList e) =>
                                    //               e.pickupLocation
                                    //                   .toString()
                                    //                   .toLowerCase()
                                    //                   .contains(value) ||
                                    //               e.dropLocation
                                    //                   .toString()
                                    //                   .toLowerCase()
                                    //                   .contains(value) ||
                                    //               // e['item_price'].toString().contains(value) ||
                                    //               e.bookingCharges
                                    //                   .toString()
                                    //                   .toLowerCase()
                                    //                   .contains(value))
                                    //           .toList();
                                    //     } else {
                                    //       bookingList = upcomingBookings;
                                    //     }
                                    //     setState(() {});
                                    //   },
                                    // ),
                                    if (upcomingBookings != null)
                                      ...upcomingBookings!
                                          .map((BookingList e) => Container(
                                                padding: EdgeInsets.all(10.0),
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 5.0),
                                                decoration: BoxDecoration(
                                                  color: AppColors.light,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          7.0),
                                                  border: Border.all(
                                                    color: AppColors.lightGrey,
                                                    width: 1.0,
                                                  ),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        e.imageUrl != null
                                                            ? ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                child: Image
                                                                    .network(
                                                                  AppConstants
                                                                          .imgBaseUrl +
                                                                      e.imageUrl!,
                                                                  width: double
                                                                      .infinity,
                                                                  fit: BoxFit
                                                                      .contain,
                                                                  height: 60.0,
                                                                  // height: 100.0,
                                                                  errorBuilder: (BuildContext
                                                                          context,
                                                                      Object
                                                                          exception,
                                                                      StackTrace?
                                                                          stackTrace) {
                                                                    return Image.asset(
                                                                        AppAssets
                                                                            .logo,
                                                                        width:
                                                                            50.0,
                                                                        height:
                                                                            50.0,
                                                                        fit: BoxFit
                                                                            .cover);
                                                                  },
                                                                ))
                                                            : Image.asset(
                                                                AppAssets.logo,
                                                                width: 50.0,
                                                                height: 50.0,
                                                                fit: BoxFit
                                                                    .cover),
                                                        SizedBox(width: 10),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                                e.brand.toString() ==
                                                                        "null"
                                                                    ? ''
                                                                    : e.brand
                                                                        .toString(),
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        16)),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            Text(
                                                                e.modal.toString() ==
                                                                        "null"
                                                                    ? ''
                                                                    : e.modal
                                                                        .toString(),
                                                                style: TextStyle(
                                                                    color: Colors
                                                                            .grey[
                                                                        600])),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            Text(
                                                                e.vehicleNumber
                                                                            .toString() ==
                                                                        "null"
                                                                    ? ''
                                                                    : e
                                                                        .vehicleNumber
                                                                        // e.vehicleNumber
                                                                        .toString(),
                                                                style: TextStyle(
                                                                    color: Colors
                                                                            .grey[
                                                                        600])),
                                                          ],
                                                        ),
                                                        // Spacer(),
                                                        // Text(status,
                                                        //     style: TextStyle(
                                                        //         color: Color(0xFF06234C), fontWeight: FontWeight.bold)),
                                                      ],
                                                    ),
                                                    Divider(
                                                      color: Colors.grey,
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text('From: '),
                                                          Icon(Icons
                                                              .compare_arrows),
                                                          Text('To: '),
                                                        ]),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Flexible(
                                                          child: Text(
                                                            e.pickupLocation,
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xFF06234C),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                            softWrap:
                                                                true, // Enable soft wrapping
                                                            maxLines: 4,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                            width:
                                                                10), // Optional: Add spacing between the two texts
                                                        Flexible(
                                                          child: Text(
                                                            e.dropLocation,
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xFF06234C),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                            softWrap:
                                                                true, // Enable soft wrapping
                                                            maxLines: 4,
                                                          ),
                                                        ),
                                                      ],
                                                    ),

                                                    // Row(
                                                    //     mainAxisAlignment:
                                                    //         MainAxisAlignment
                                                    //             .spaceBetween,
                                                    //     children: [
                                                    //       Text(
                                                    //         e.pickupLocation,
                                                    //         style: TextStyle(
                                                    //             color: Color(
                                                    //                 0xFF06234C),
                                                    //             fontWeight:
                                                    //                 FontWeight
                                                    //                     .bold),
                                                    //       ),
                                                    //       // SizedBox(
                                                    //       //   width: 150,
                                                    //       // ),
                                                    //       Text(
                                                    //         e.dropLocation,
                                                    //         style: TextStyle(
                                                    //             color: Color(
                                                    //                 0xFF06234C),
                                                    //             fontWeight:
                                                    //                 FontWeight
                                                    //                     .bold),
                                                    //       ),
                                                    //     ]),
                                                    Divider(
                                                      color: Colors.grey,
                                                    ),
                                                    Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Column(children: [
                                                            Text('Price'),
                                                            Text(
                                                              e.bookingCharges
                                                                          .toString() ==
                                                                      "null"
                                                                  ? ''
                                                                  : e.bookingCharges,
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xFF06234C),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ]),
                                                          Column(children: [
                                                            Text('From Date'),
                                                            Text(
                                                              formattedDate =
                                                                  DateFormat(
                                                                          'dd-MM-yyyy')
                                                                      .format(e
                                                                          .fromDatetime),
                                                              // e.createdDate
                                                              // .toString(),
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xFF06234C),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ]),
                                                          Column(children: [
                                                            Text('To Date'),
                                                            Text(
                                                              formattedDate =
                                                                  DateFormat(
                                                                          'dd-MM-yyyy')
                                                                      .format(e
                                                                          .toDatetime),
                                                              // e.createdDate
                                                              // .toString(),
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xFF06234C),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ]),
                                                          Column(children: [
                                                            Text('Vehicle No.'),
                                                            Text(
                                                              e.vehicleNumber
                                                                          .toString() ==
                                                                      "null"
                                                                  ? ''
                                                                  : e.vehicleNumber
                                                                      .toString(),
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xFF06234C),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ]),
                                                        ]),
                                                    // Row(
                                                    //     mainAxisAlignment:
                                                    //         MainAxisAlignment
                                                    //             .spaceBetween,
                                                    //     children: [
                                                    //       Text(
                                                    //         e.bookingCharges
                                                    //                     .toString() ==
                                                    //                 "null"
                                                    //             ? ''
                                                    //             : e.bookingCharges,
                                                    //         style: TextStyle(
                                                    //             color: Color(
                                                    //                 0xFF06234C),
                                                    //             fontWeight:
                                                    //                 FontWeight
                                                    //                     .bold),
                                                    //       ),
                                                    //       Text(
                                                    //         formattedDate = DateFormat(
                                                    //                 'dd-MM-yyyy')
                                                    //             .format(e
                                                    //                 .fromDatetime),
                                                    //         // e.createdDate
                                                    //         // .toString(),
                                                    //         style: TextStyle(
                                                    //             color: Color(
                                                    //                 0xFF06234C),
                                                    //             fontWeight:
                                                    //                 FontWeight
                                                    //                     .bold),
                                                    //       ),
                                                    //       Text(
                                                    //         formattedDate = DateFormat(
                                                    //                 'dd-MM-yyyy')
                                                    //             .format(e
                                                    //                 .toDatetime),
                                                    //         // e.createdDate
                                                    //         // .toString(),
                                                    //         style: TextStyle(
                                                    //             color: Color(
                                                    //                 0xFF06234C),
                                                    //             fontWeight:
                                                    //                 FontWeight
                                                    //                     .bold),
                                                    //       ),
                                                    //       Text(
                                                    //         e.vehicleNumber
                                                    //                     .toString() ==
                                                    //                 "null"
                                                    //             ? ''
                                                    //             : e.vehicleNumber
                                                    //                 .toString(),
                                                    //         style: TextStyle(
                                                    //             color: Color(
                                                    //                 0xFF06234C),
                                                    //             fontWeight:
                                                    //                 FontWeight
                                                    //                     .bold),
                                                    //       ),
                                                    //     ]),
                                                    SizedBox(height: 20),
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        e.id;
                                                        showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return StatefulBuilder(
                                                              builder: (context,
                                                                  setState) {
                                                                return AlertDialog(
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(10.0)),
                                                                  ),
                                                                  content:
                                                                      SingleChildScrollView(
                                                                    child:
                                                                        Container(
                                                                      width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width,
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              2),
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            16.0),
                                                                        child:
                                                                            Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            SizedBox(height: 16),
                                                                            Text(
                                                                              "Please Select the Reason for Cancellation",
                                                                              style: TextStyle(fontSize: 16),
                                                                            ),
                                                                            // SizedBox(height: 16),

                                                                            // // Radio buttons for cancellation reasons
                                                                            // RadioListTile<String>(
                                                                            //   title: const Text('Change Plan'),
                                                                            //   value: 'Change Plan',
                                                                            //   groupValue: _selectedReason,
                                                                            //   onChanged: (value) {
                                                                            //     setState(() {
                                                                            //       _selectedReason = value;
                                                                            //       print(value); // Update selection
                                                                            //     });
                                                                            //   },
                                                                            // ),
                                                                            // RadioListTile<String>(
                                                                            //   title: const Text('Weather condition'),
                                                                            //   value: 'Weather condition',
                                                                            //   groupValue: _selectedReason,
                                                                            //   onChanged: (value) {
                                                                            //     setState(() {
                                                                            //       _selectedReason = value;
                                                                            //       print(value);
                                                                            //     });
                                                                            //   },
                                                                            // ),
                                                                            // RadioListTile<String>(
                                                                            //   title: const Text('Schedule conflict'),
                                                                            //   value: 'Schedule conflict',
                                                                            //   groupValue: _selectedReason,
                                                                            //   onChanged: (value) {
                                                                            //     setState(() {
                                                                            //       _selectedReason = value;
                                                                            //       print(value);
                                                                            //     });
                                                                            //   },
                                                                            // ),
                                                                            // RadioListTile<String>(
                                                                            //   title: const Text('Booking Error'),
                                                                            //   value: 'Booking Error',
                                                                            //   groupValue: _selectedReason,
                                                                            //   onChanged: (value) {
                                                                            //     setState(() {
                                                                            //       _selectedReason = value;
                                                                            //       print(value);
                                                                            //     });
                                                                            //   },
                                                                            // ),
                                                                            // RadioListTile<String>(
                                                                            //   title: const Text('Other'),
                                                                            //   value: 'Other',
                                                                            //   groupValue: _selectedReason,
                                                                            //   onChanged: (value) {
                                                                            //     setState(() {
                                                                            //       _selectedReason = value;
                                                                            //     });
                                                                            //   },
                                                                            // ),
                                                                            SizedBox(height: 16),

                                                                            // Description text field
                                                                            CustomeTextField(
                                                                              control: _descriptionController,
                                                                              lines: 4,
                                                                              hint: "Description",
                                                                              // decoration: InputDecoration(
                                                                              //   hintText: "Description",
                                                                              //   border: OutlineInputBorder(
                                                                              //     borderRadius: BorderRadius.circular(12),
                                                                              //     borderSide: BorderSide(color: Colors.grey),
                                                                              //   ),
                                                                              // ),
                                                                            ),
                                                                            SizedBox(height: 30),

                                                                            // Submit button
                                                                            SizedBox(
                                                                              width: double.infinity,
                                                                              height: 50,
                                                                              child: ElevatedButton(
                                                                                style: ElevatedButton.styleFrom(
                                                                                  backgroundColor: Colors.blue[900], // Color for button
                                                                                  shape: RoundedRectangleBorder(
                                                                                    borderRadius: BorderRadius.circular(8),
                                                                                  ),
                                                                                ),
                                                                                onPressed: () {
                                                                                  print(e.id);

                                                                                  updatecancelbooking(e.id);
                                                                                },
                                                                                child: Text(
                                                                                  'Submit',
                                                                                  style: TextStyle(fontSize: 16),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                            );
                                                          },
                                                        );
                                                      },
                                                      child: Text(
                                                          'Cancel Booking'),
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        textStyle: TextStyle(
                                                            color:
                                                                Colors.white),
                                                        backgroundColor:
                                                            Color(0xFF06234C),
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 16),
                                                        minimumSize: Size(
                                                            double.infinity,
                                                            50),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ))
                                  ]))
                    ])),
                SingleChildScrollView(
                    child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      isLoading
                          ? Center(child: CircularProgressIndicator())
                          : Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // CustomeTextField(
                                    //   width: MediaQuery.of(context).size.width -
                                    //       10.0,
                                    //   hint: 'Search Cars',
                                    //   suffixIcon: Icon(
                                    //     Icons.search,
                                    //     color: AppColors.lightGrey3,
                                    //     size: 20.0,
                                    //   ),
                                    //   labelColor: AppColors.primary,
                                    //   // borderColor: AppColors.primary2,
                                    //   focusBorderColor: AppColors.primary,
                                    //   borderRadius: BorderRadius.all(
                                    //       Radius.circular(20.0)),
                                    //   borderColor: AppColors.lightGrey3,
                                    //   onChanged: (value) {
                                    //     if (value != '') {
                                    //       print('value $value');
                                    //       value =
                                    //           value.toString().toLowerCase();
                                    //       bookingList = completedBookings!
                                    //           .where((BookingList e) =>
                                    //               e.id
                                    //                   .toString()
                                    //                   .toLowerCase()
                                    //                   .contains(value) ||
                                    //               e.pickupLocation
                                    //                   .toString()
                                    //                   .toLowerCase()
                                    //                   .contains(value) ||
                                    //               // e['item_price'].toString().contains(value) ||
                                    //               e.bookingCharges
                                    //                   .toString()
                                    //                   .toLowerCase()
                                    //                   .contains(value))
                                    //           .toList();
                                    //     } else {
                                    //       bookingList = completedBookings;
                                    //     }
                                    //     setState(() {});
                                    //   },
                                    // ),
                                    if (completedBookings != null)
                                      ...completedBookings!.map((BookingList
                                              e) =>
                                          Container(
                                            padding: EdgeInsets.all(10.0),
                                            margin: EdgeInsets.symmetric(
                                                vertical: 5.0),
                                            decoration: BoxDecoration(
                                              color: AppColors.light,
                                              borderRadius:
                                                  BorderRadius.circular(7.0),
                                              border: Border.all(
                                                color: AppColors.lightGrey,
                                                width: 1.0,
                                              ),
                                            ),
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      if (e.imageUrl != null)
                                                        if (e.imageUrl != null)
                                                          ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              child:
                                                                  Image.network(
                                                                AppConstants
                                                                        .imgBaseUrl +
                                                                    e.imageUrl!,
                                                                width: double
                                                                    .infinity,
                                                                fit: BoxFit
                                                                    .contain,
                                                                height: 60.0,
                                                                // height: 100.0,
                                                                errorBuilder: (BuildContext
                                                                        context,
                                                                    Object
                                                                        exception,
                                                                    StackTrace?
                                                                        stackTrace) {
                                                                  return Image.asset(
                                                                      AppAssets
                                                                          .logo,
                                                                      width:
                                                                          50.0,
                                                                      height:
                                                                          50.0,
                                                                      fit: BoxFit
                                                                          .cover);
                                                                },
                                                              )),
                                                      SizedBox(width: 10),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                              e.brand.toString() ==
                                                                      "null"
                                                                  ? ''
                                                                  : e.brand
                                                                      .toString(),
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      16)),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Text(
                                                              e.modal.toString() ==
                                                                      "null"
                                                                  ? ''
                                                                  : e.modal
                                                                      .toString(),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                          .grey[
                                                                      600])),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Text(
                                                              e.vehicleNumber
                                                                          .toString() ==
                                                                      "null"
                                                                  ? ''
                                                                  : e.vehicleNumber
                                                                      .toString(),
                                                              // e.vehicleNumber
                                                              //     .toString(),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                          .grey[
                                                                      600])),
                                                        ],
                                                      ),
                                                      Spacer(),
                                                      Container(
                                                          height: 20,
                                                          width: 80,
                                                          color:
                                                              Color(0xFFF3F8FF),
                                                          child: Text(
                                                              "ID: 1234",
                                                              style: TextStyle(
                                                                color: Color(
                                                                    0xFF06234C),
                                                              ))),
                                                    ],
                                                  ),
                                                  Divider(),
                                                  // Trip Details
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                          height: 30,
                                                          color:
                                                              Color(0xFFF3F8FF),
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Text(
                                                              "    Trip Details",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold))),
                                                      SizedBox(height: 8),
                                                      Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      16.0),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Flexible(
                                                                  flex: 1,
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                          "From"),
                                                                      Text(e.pickupLocation,
                                                                          softWrap:
                                                                              true,
                                                                          maxLines:
                                                                              4,
                                                                          style:
                                                                              TextStyle(fontWeight: FontWeight.bold)),
                                                                      Text(
                                                                        formattedDate =
                                                                            DateFormat('dd-MM-yyyy').format(e.fromDatetime),

                                                                        // "25-Aug-2024"
                                                                      ),
                                                                    ],
                                                                  )),
                                                              Icon(
                                                                  Icons
                                                                      .swap_horiz,
                                                                  color: Colors
                                                                      .grey),
                                                              Flexible(
                                                                  flex: 1,
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                          "To"),
                                                                      Text(
                                                                          e
                                                                              .dropLocation,
                                                                          softWrap:
                                                                              true,
                                                                          maxLines:
                                                                              4,
                                                                          //   "Kaniyakumari",
                                                                          style:
                                                                              TextStyle(fontWeight: FontWeight.bold)),
                                                                      Text(
                                                                        formattedDate =
                                                                            DateFormat('dd-MM-yyyy').format(e.toDatetime),

                                                                        //  "02-Sept-2024"
                                                                      ),
                                                                    ],
                                                                  )),
                                                            ],
                                                          )),
                                                      SizedBox(height: 16),
                                                    ],
                                                  ),

                                                  Divider(),
                                                  // Driver Details
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                          height: 30,
                                                          color:
                                                              Color(0xFFF3F8FF),
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Text(
                                                              "    Driver Details",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold))),
                                                      SizedBox(height: 8),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal:
                                                                    16.0),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text("Name: "),
                                                                Text(
                                                                    "Mobile number: "),
                                                              ],
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(
                                                                    // e
                                                                    //     .driverId, // name
                                                                    "Shiva Kumar",
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.bold)),
                                                                Text(
                                                                    // e
                                                                    //     .driverId,
                                                                    "+91 856325241",
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.bold)),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Divider(),
                                                      Container(
                                                          height: 40,
                                                          color:
                                                              Color(0xFFF3F8FF),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        16.0),
                                                            child: Column(
                                                              children: [
                                                                Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Text(
                                                                          'Total Amount:',
                                                                          style: TextStyle(
                                                                              color: Color(0xFF06234C),
                                                                              fontWeight: FontWeight.bold)),
                                                                      // SizedBox(
                                                                      //   width: 170,
                                                                      // ),
                                                                      Text(
                                                                          e.bookingCharges.toString() == "null"
                                                                              ? ''
                                                                              : e
                                                                                  .bookingCharges,
                                                                          // '5000',
                                                                          style: TextStyle(
                                                                              color: Color(0xFF06234C),
                                                                              fontWeight: FontWeight.bold)),
                                                                    ]),
                                                                // Row(children: [
                                                                //   Text(
                                                                //     'For 5 Days',
                                                                //   )
                                                                // ]),
                                                              ],
                                                            ),
                                                          ))
                                                    ],
                                                  ),
                                                ]),
                                          ))
                                  ]))
                    ]))
              ]))
            ])));
  }
}








// import 'package:cabs/constants/app_assets.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// import '../../../constants/app_colors.dart';
// import '../../../constants/app_constants.dart';
// import '../../../services/cabs_api_service.dart';
// import '../../../services/comFuncService.dart';
// import '../../../widgets/custom_text_field.dart';
// import 'my_booking_list_model.dart';

// class UserMyBookings extends StatefulWidget {
//   @override
//   _userMyBookingsState createState() => _userMyBookingsState();
// }

// class _userMyBookingsState extends State<UserMyBookings> {
//   final CabsApiService apiService = CabsApiService();

//   String? formattedDate;

//   @override
//   void initState() {
//     getbookingList();

//     super.initState();
//   }

//   bool isLoading = false;
//   List<BookingList>? bookingList;
//   List<BookingList>? bookingListtAll;

//   List<BookingList>? upcomingBookings;
//   List<BookingList>? completedBookings;

//   Future getbookingList() async {
//     await apiService.getBearerToken();
//     var result = await apiService.getbookingList();
//     var response = bookingListDataFromJson(result);
//     if (response.status.toString() == 'SUCCESS') {
//       setState(() {
//         bookingList = response.list;
//         // bookingListtAll = bookingList;
//         upcomingBookings = bookingList!
//     .where((booking) =>
//         booking.status.trim().toUpperCase() != 'COMPLETED')
//     .toList();

// completedBookings = bookingList!
//     .where((booking) =>
//         booking.status.trim().toUpperCase() == 'COMPLETED')
//     .toList();
//         // upcomingBookings = bookingList!
//         //     .where((booking) => booking.bookingStatus != 'COMPLETED')
//         //     .toList();
//         // completedBookings = bookingList!
//         //     .where((booking) => booking.bookingStatus == 'COMPLETED')
//         //     .toList();
//         isLoading = false;
//       });
//     } else {
//       setState(() {
//         bookingList = [];
//         bookingListtAll = [];
//         isLoading = false;
//       });
//       showInSnackBar(context, response.message.toString());
//     }
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text(
//             "My Bookings",
//             style: TextStyle(color: Colors.white),
//           ),
//           backgroundColor: Color(0xFF06234C),
//           automaticallyImplyLeading: false,
//         ),
//         body: DefaultTabController(
//             length: 2,
//             child: Column(children: [
//               Container(
//                   child: TabBar(
//                 dividerColor: Colors.transparent,
//                 labelColor: Colors.black,
//                 unselectedLabelColor: Colors.black26,
//                 tabs: [
//                   Tab(text: "Upcoming"),
//                   Tab(text: "Completed"),
//                 ],
//               )),
//               Expanded(
//                   child: TabBarView(children: [
//                 SingleChildScrollView(
//                     child: Column(
//                         // crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                       isLoading
//                           ? Center(child: CircularProgressIndicator())
//                           : Padding(
//                               padding: const EdgeInsets.all(15.0),
//                               child: Column(
//                                   // crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     CustomeTextField(
//                                       width: MediaQuery.of(context).size.width -
//                                           10.0,
//                                       hint: 'Search Cars',
//                                       suffixIcon: Icon(
//                                         Icons.search,
//                                         color: AppColors.lightGrey3,
//                                         size: 20.0,
//                                       ),
//                                       labelColor: AppColors.primary,
//                                       // borderColor: AppColors.primary2,
//                                       focusBorderColor: AppColors.primary,
//                                       borderRadius: BorderRadius.all(
//                                           Radius.circular(20.0)),
//                                       borderColor: AppColors.lightGrey3,
//                                       onChanged: (value) {
//                                         if (value != '') {
//                                           print('value $value');
//                                           value =
//                                               value.toString().toLowerCase();
//                                           bookingList = upcomingBookings!
//                                               .where((BookingList e) =>
//                                                   e.id
//                                                       .toString()
//                                                       .toLowerCase()
//                                                       .contains(value) ||
//                                                   e.pickupLocation
//                                                       .toString()
//                                                       .toLowerCase()
//                                                       .contains(value) ||
//                                                   // e['item_price'].toString().contains(value) ||
//                                                   e.bookingCharges
//                                                       .toString()
//                                                       .toLowerCase()
//                                                       .contains(value))
//                                               .toList();
//                                         } else {
//                                           bookingList = upcomingBookings;
//                                         }
//                                         setState(() {});
//                                       },
//                                     ),
//                                     if (bookingList != null)
//                                       ...bookingList!.map((BookingList e) =>
//                                           Container(
//                                             padding: EdgeInsets.all(10.0),
//                                             margin: EdgeInsets.symmetric(
//                                                 vertical: 5.0),
//                                             decoration: BoxDecoration(
//                                               color: AppColors.light,
//                                               borderRadius:
//                                                   BorderRadius.circular(7.0),
//                                               border: Border.all(
//                                                 color: AppColors.lightGrey,
//                                                 width: 1.0,
//                                               ),
//                                             ),
//                                             child: Column(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               children: [
//                                                 Row(
//                                                   children: [
//                                                     if (e.imageUrl != null)
//                                                       ClipRRect(
//                                                           borderRadius:
//                                                               BorderRadius
//                                                                   .circular(10),
//                                                           child: Image.network(
//                                                             AppConstants
//                                                                     .imgBaseUrl +
//                                                                 e.imageUrl!,
//                                                             width:
//                                                                 double.infinity,
//                                                             fit: BoxFit.contain,
//                                                             height: 60.0,
//                                                             // height: 100.0,
//                                                             errorBuilder:
//                                                                 (BuildContext
//                                                                         context,
//                                                                     Object
//                                                                         exception,
//                                                                     StackTrace?
//                                                                         stackTrace) {
//                                                               return Image.asset(
//                                                                   AppAssets
//                                                                       .logo,
//                                                                   width: 50.0,
//                                                                   height: 50.0,
//                                                                   fit: BoxFit
//                                                                       .cover);
//                                                             },
//                                                           )),
//                                                     SizedBox(width: 10),
//                                                     Column(
//                                                       crossAxisAlignment:
//                                                           CrossAxisAlignment
//                                                               .start,
//                                                       children: [
//                                                         Text(
//                                                             e.brand.toString() ==
//                                                                     "null"
//                                                                 ? ''
//                                                                 : e.brand
//                                                                     .toString(),
//                                                             style: TextStyle(
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .bold,
//                                                                 fontSize: 16)),
//                                                         SizedBox(
//                                                           height: 5,
//                                                         ),
//                                                         Text(
//                                                             e.modal.toString() ==
//                                                                     "null"
//                                                                 ? ''
//                                                                 : e.modal
//                                                                     .toString(),
//                                                             style: TextStyle(
//                                                                 color:
//                                                                     Colors.grey[
//                                                                         600])),
//                                                         SizedBox(
//                                                           height: 5,
//                                                         ),
//                                                         Text(
//                                                             e.vehicleNumber
//                                                                 .toString(),
//                                                             style: TextStyle(
//                                                                 color:
//                                                                     Colors.grey[
//                                                                         600])),
//                                                       ],
//                                                     ),
//                                                     // Spacer(),
//                                                     // Text(status,
//                                                     //     style: TextStyle(
//                                                     //         color: Color(0xFF06234C), fontWeight: FontWeight.bold)),
//                                                   ],
//                                                 ),
//                                                 Divider(
//                                                   color: Colors.grey,
//                                                 ),
//                                                 SizedBox(
//                                                   height: 10,
//                                                 ),
//                                                 Row(
//                                                     mainAxisAlignment:
//                                                         MainAxisAlignment
//                                                             .spaceBetween,
//                                                     children: [
//                                                       Text('From: '),
//                                                       Icon(
//                                                           Icons.compare_arrows),
//                                                       Text('To: '),
//                                                     ]),
//                                                 Row(
//                                                     mainAxisAlignment:
//                                                         MainAxisAlignment
//                                                             .spaceBetween,
//                                                     children: [
//                                                       Text(
//                                                         e.pickupLocation,
//                                                         style: TextStyle(
//                                                             color: Color(
//                                                                 0xFF06234C),
//                                                             fontWeight:
//                                                                 FontWeight
//                                                                     .bold),
//                                                       ),
//                                                       // SizedBox(
//                                                       //   width: 150,
//                                                       // ),
//                                                       Text(
//                                                         e.dropLocation,
//                                                         style: TextStyle(
//                                                             color: Color(
//                                                                 0xFF06234C),
//                                                             fontWeight:
//                                                                 FontWeight
//                                                                     .bold),
//                                                       ),
//                                                     ]),
//                                                 Divider(
//                                                   color: Colors.grey,
//                                                 ),
//                                                 Row(
//                                                     mainAxisAlignment:
//                                                         MainAxisAlignment
//                                                             .spaceBetween,
//                                                     children: [
//                                                       Text('Price'),
//                                                       Text('Booking Date'),
//                                                       Text('Vehicle No.'),
//                                                     ]),
//                                                 Row(
//                                                     mainAxisAlignment:
//                                                         MainAxisAlignment
//                                                             .spaceBetween,
//                                                     children: [
//                                                       Text(
//                                                         e.bookingCharges
//                                                                     .toString() ==
//                                                                 "null"
//                                                             ? ''
//                                                             : e.bookingCharges,
//                                                         style: TextStyle(
//                                                             color: Color(
//                                                                 0xFF06234C),
//                                                             fontWeight:
//                                                                 FontWeight
//                                                                     .bold),
//                                                       ),
//                                                       Text(
//                                                         formattedDate = DateFormat(
//                                                                 'dd-MM-yyyy')
//                                                             .format(
//                                                                 e.createdDate),
//                                                         // e.createdDate
//                                                         // .toString(),
//                                                         style: TextStyle(
//                                                             color: Color(
//                                                                 0xFF06234C),
//                                                             fontWeight:
//                                                                 FontWeight
//                                                                     .bold),
//                                                       ),
//                                                       Text(
//                                                         e.vehicleNumber
//                                                                     .toString() ==
//                                                                 "null"
//                                                             ? ''
//                                                             : e.vehicleNumber
//                                                                 .toString(),
//                                                         style: TextStyle(
//                                                             color: Color(
//                                                                 0xFF06234C),
//                                                             fontWeight:
//                                                                 FontWeight
//                                                                     .bold),
//                                                       ),
//                                                     ]),
//                                                 SizedBox(height: 20),
//                                                 ElevatedButton(
//                                                   onPressed: () {},
//                                                   child: Center(
//                                                     child:
//                                                         Text('Cancle Booking'),
//                                                   ),
//                                                   style:
//                                                       ElevatedButton.styleFrom(
//                                                     textStyle: TextStyle(
//                                                         color: Colors.white),
//                                                     backgroundColor:
//                                                         Color(0xFF06234C),
//                                                     padding:
//                                                         EdgeInsets.symmetric(
//                                                             vertical: 16),
//                                                     minimumSize: Size(
//                                                         double.infinity, 50),
//                                                     shape:
//                                                         RoundedRectangleBorder(
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               10), // Rounded corners
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ))
//                                   ]))
//                     ])),
//                 SingleChildScrollView(
//                     child: Column(
//                         // crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                       isLoading
//                           ? Center(child: CircularProgressIndicator())
//                           : Padding(
//                               padding: const EdgeInsets.all(15.0),
//                               child: Column(
//                                   // crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     CustomeTextField(
//                                       width: MediaQuery.of(context).size.width -
//                                           10.0,
//                                       hint: 'Search Cars',
//                                       suffixIcon: Icon(
//                                         Icons.search,
//                                         color: AppColors.lightGrey3,
//                                         size: 20.0,
//                                       ),
//                                       labelColor: AppColors.primary,
//                                       // borderColor: AppColors.primary2,
//                                       focusBorderColor: AppColors.primary,
//                                       borderRadius: BorderRadius.all(
//                                           Radius.circular(20.0)),
//                                       borderColor: AppColors.lightGrey3,
//                                       onChanged: (value) {
//                                         if (value != '') {
//                                           print('value $value');
//                                           value =
//                                               value.toString().toLowerCase();
//                                           bookingList = upcomingBookings!
//                                               .where((BookingList e) =>
//                                                   e.id
//                                                       .toString()
//                                                       .toLowerCase()
//                                                       .contains(value) ||
//                                                   e.pickupLocation
//                                                       .toString()
//                                                       .toLowerCase()
//                                                       .contains(value) ||
//                                                   // e['item_price'].toString().contains(value) ||
//                                                   e.bookingCharges
//                                                       .toString()
//                                                       .toLowerCase()
//                                                       .contains(value))
//                                               .toList();
//                                         } else {
//                                           bookingList = upcomingBookings;
//                                         }
//                                         setState(() {});
//                                       },
//                                     ),
//                                     if (bookingList != null)
//                                       ...bookingList!.map((BookingList e) =>
//                                           Container(
//                                             padding: EdgeInsets.all(10.0),
//                                             margin: EdgeInsets.symmetric(
//                                                 vertical: 5.0),
//                                             decoration: BoxDecoration(
//                                               color: AppColors.light,
//                                               borderRadius:
//                                                   BorderRadius.circular(7.0),
//                                               border: Border.all(
//                                                 color: AppColors.lightGrey,
//                                                 width: 1.0,
//                                               ),
//                                             ),
//                                             child: Column(
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.start,
//                                                 children: [
//                                                   Row(
//                                                     children: [
//                                                       if (e.imageUrl != null)
//                                                         if (e.imageUrl != null)
//                                                           ClipRRect(
//                                                               borderRadius:
//                                                                   BorderRadius
//                                                                       .circular(
//                                                                           10),
//                                                               child:
//                                                                   Image.network(
//                                                                 AppConstants
//                                                                         .imgBaseUrl +
//                                                                     e.imageUrl!,
//                                                                 width: double
//                                                                     .infinity,
//                                                                 fit: BoxFit
//                                                                     .contain,
//                                                                 height: 60.0,
//                                                                 // height: 100.0,
//                                                                 errorBuilder: (BuildContext
//                                                                         context,
//                                                                     Object
//                                                                         exception,
//                                                                     StackTrace?
//                                                                         stackTrace) {
//                                                                   return Image.asset(
//                                                                       AppAssets
//                                                                           .logo,
//                                                                       width:
//                                                                           50.0,
//                                                                       height:
//                                                                           50.0,
//                                                                       fit: BoxFit
//                                                                           .cover);
//                                                                 },
//                                                               )),
//                                                       SizedBox(width: 10),
//                                                       Column(
//                                                         crossAxisAlignment:
//                                                             CrossAxisAlignment
//                                                                 .start,
//                                                         children: [
//                                                           Text(
//                                                               e.brand.toString() ==
//                                                                       "null"
//                                                                   ? ''
//                                                                   : e.brand
//                                                                       .toString(),
//                                                               style: TextStyle(
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .bold,
//                                                                   fontSize:
//                                                                       16)),
//                                                           SizedBox(
//                                                             height: 5,
//                                                           ),
//                                                           Text(
//                                                               e.modal.toString() ==
//                                                                       "null"
//                                                                   ? ''
//                                                                   : e.modal
//                                                                       .toString(),
//                                                               style: TextStyle(
//                                                                   color: Colors
//                                                                           .grey[
//                                                                       600])),
//                                                           SizedBox(
//                                                             height: 5,
//                                                           ),
//                                                           Text(
//                                                               e.vehicleNumber
//                                                                   .toString(),
//                                                               style: TextStyle(
//                                                                   color: Colors
//                                                                           .grey[
//                                                                       600])),
//                                                         ],
//                                                       ),
//                                                       Spacer(),
//                                                       Container(
//                                                           height: 20,
//                                                           width: 80,
//                                                           color:
//                                                               Color(0xFFF3F8FF),
//                                                           child: Text(
//                                                               "ID: 1234",
//                                                               style: TextStyle(
//                                                                 color: Color(
//                                                                     0xFF06234C),
//                                                               ))),
//                                                     ],
//                                                   ),
//                                                   Divider(),
//                                                   // Trip Details
//                                                   Column(
//                                                     crossAxisAlignment:
//                                                         CrossAxisAlignment
//                                                             .start,
//                                                     children: [
//                                                       Container(
//                                                           height: 30,
//                                                           color:
//                                                               Color(0xFFF3F8FF),
//                                                           width: MediaQuery.of(
//                                                                   context)
//                                                               .size
//                                                               .width,
//                                                           child: Text(
//                                                               "    Trip Details",
//                                                               style: TextStyle(
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .bold))),
//                                                       SizedBox(height: 8),
//                                                       Padding(
//                                                           padding:
//                                                               const EdgeInsets
//                                                                   .symmetric(
//                                                                   horizontal:
//                                                                       16.0),
//                                                           child: Row(
//                                                             mainAxisAlignment:
//                                                                 MainAxisAlignment
//                                                                     .spaceBetween,
//                                                             children: [
//                                                               Flexible(
//                                                                   flex: 1,
//                                                                   child: Column(
//                                                                     crossAxisAlignment:
//                                                                         CrossAxisAlignment
//                                                                             .start,
//                                                                     children: [
//                                                                       Text(
//                                                                           "From"),
//                                                                       Text(
//                                                                           e.pickupLocation,
//                                                                           //  "Ramanathapuram",

//                                                                           style: TextStyle(fontWeight: FontWeight.bold)),
//                                                                       Text(
//                                                                         formattedDate =
//                                                                             DateFormat('dd-MM-yyyy').format(e.fromDatetime),

//                                                                         // "25-Aug-2024"
//                                                                       ),
//                                                                     ],
//                                                                   )),
//                                                               Icon(
//                                                                   Icons
//                                                                       .swap_horiz,
//                                                                   color: Colors
//                                                                       .grey),
//                                                               Flexible(
//                                                                   flex: 1,
//                                                                   child: Column(
//                                                                     crossAxisAlignment:
//                                                                         CrossAxisAlignment
//                                                                             .start,
//                                                                     children: [
//                                                                       Text(
//                                                                           "To"),
//                                                                       Text(
//                                                                           e.dropLocation,
//                                                                           //   "Kaniyakumari",
//                                                                           style: TextStyle(fontWeight: FontWeight.bold)),
//                                                                       Text(
//                                                                         formattedDate =
//                                                                             DateFormat('dd-MM-yyyy').format(e.toDatetime),

//                                                                         //  "02-Sept-2024"
//                                                                       ),
//                                                                     ],
//                                                                   )),
//                                                             ],
//                                                           )),
//                                                       SizedBox(height: 16),
//                                                     ],
//                                                   ),

//                                                   Divider(),
//                                                   // Driver Details
//                                                   Column(
//                                                     crossAxisAlignment:
//                                                         CrossAxisAlignment
//                                                             .start,
//                                                     children: [
//                                                       Container(
//                                                           height: 30,
//                                                           color:
//                                                               Color(0xFFF3F8FF),
//                                                           width: MediaQuery.of(
//                                                                   context)
//                                                               .size
//                                                               .width,
//                                                           child: Text(
//                                                               "    Driver Details",
//                                                               style: TextStyle(
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .bold))),
//                                                       SizedBox(height: 8),
//                                                       Padding(
//                                                         padding:
//                                                             const EdgeInsets
//                                                                 .symmetric(
//                                                                 horizontal:
//                                                                     16.0),
//                                                         child: Column(
//                                                           crossAxisAlignment:
//                                                               CrossAxisAlignment
//                                                                   .start,
//                                                           children: [
//                                                             Row(
//                                                               mainAxisAlignment:
//                                                                   MainAxisAlignment
//                                                                       .spaceBetween,
//                                                               children: [
//                                                                 Text("Name: "),
//                                                                 Text(
//                                                                     "Mobile number: "),
//                                                               ],
//                                                             ),
//                                                             Row(
//                                                               mainAxisAlignment:
//                                                                   MainAxisAlignment
//                                                                       .spaceBetween,
//                                                               children: [
//                                                                 Text(
//                                                                     // e
//                                                                     //     .driverId, // name
//                                                                     "Shiva Kumar",
//                                                                     style: TextStyle(
//                                                                         fontWeight:
//                                                                             FontWeight.bold)),
//                                                                 Text(
//                                                                     // e
//                                                                     //     .driverId,
//                                                                     "+91 856325241",
//                                                                     style: TextStyle(
//                                                                         fontWeight:
//                                                                             FontWeight.bold)),
//                                                               ],
//                                                             ),
//                                                           ],
//                                                         ),
//                                                       ),
//                                                       Divider(),
//                                                       Container(
//                                                           height: 40,
//                                                           color:
//                                                               Color(0xFFF3F8FF),
//                                                           child: Padding(
//                                                             padding:
//                                                                 const EdgeInsets
//                                                                     .symmetric(
//                                                                     horizontal:
//                                                                         16.0),
//                                                             child: Column(
//                                                               children: [
//                                                                 Row(
//                                                                     mainAxisAlignment:
//                                                                         MainAxisAlignment
//                                                                             .spaceBetween,
//                                                                     children: [
//                                                                       Text(
//                                                                           'Total Amount:',
//                                                                           style: TextStyle(
//                                                                               color: Color(0xFF06234C),
//                                                                               fontWeight: FontWeight.bold)),
//                                                                       // SizedBox(
//                                                                       //   width: 170,
//                                                                       // ),
//                                                                       Text(
//                                                                           e.bookingCharges.toString() == "null"
//                                                                               ? ''
//                                                                               : e
//                                                                                   .bookingCharges,
//                                                                           // '5000',
//                                                                           style: TextStyle(
//                                                                               color: Color(0xFF06234C),
//                                                                               fontWeight: FontWeight.bold)),
//                                                                     ]),
//                                                                 // Row(children: [
//                                                                 //   Text(
//                                                                 //     'For 5 Days',
//                                                                 //   )
//                                                                 // ]),
//                                                               ],
//                                                             ),
//                                                           ))
//                                                     ],
//                                                   ),
//                                                 ]),
//                                           ))
//                                   ]))
//                     ]))
//               ]))
//             ])));
//   }
// }


