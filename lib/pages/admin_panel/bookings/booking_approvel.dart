import 'package:cabs/pages/admin_panel/bookings/car_list_model.dart';
import 'package:cabs/pages/admin_panel/bookings/driver_list_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constants/app_assets.dart';
import '../../../constants/app_constants.dart';
import '../../../services/cabs_api_service.dart';
import '../../../services/comFuncService.dart';
import 'booking_getbyid_model.dart';

class BookingApprovel extends StatefulWidget {
  int? bookingId;

  BookingApprovel({super.key, this.bookingId});

  @override
  _BookingApprovelState createState() => _BookingApprovelState();
}

class _BookingApprovelState extends State<BookingApprovel> {
  final CabsApiService apiService = CabsApiService();
  String phoneNumber = "tel:1234567890";
  String selectedDriver = '';
  String selectedCar = '';
  String BookingId = '';
  String BookingDate = '';
  String Fromlocation = '';
  String Tolocation = '';
  String Fromdate = '';
  String Todate = '';

  @override
  void initState() {
    super.initState();
    refresh();
    getdriverList();
    getcarList();
    print('Driver id :' + widget.bookingId.toString());
  }

  refresh() async {
    if (widget.bookingId != null) {
      await getBookingById();
    }
  }

  void _makePhoneCall() async {
    if (await canLaunch(phoneNumber)) {
      await launch(phoneNumber);
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }

  bool isLoading = false;

  List<DriversList>? driverList;
  List<DriversList>? driverListtAll;
  List<ListElement>? carList;
  List<ListElement>? carListtAll;

  Future getdriverList() async {
    setState(() {
      isLoading = true;
    });
    await apiService.getBearerToken();
    var result = await apiService.getdriverList();
    var response = driverListDataFromJson(result);
    if (response.status.toString() == 'SUCCESS') {
      setState(() {
        driverList = response.list;
        driverListtAll = driverList;
        isLoading = false;
      });
    } else {
      setState(() {
        driverList = [];
        driverListtAll = [];
        isLoading = false;
      });
      showInSnackBar(context, response.message.toString());
    }
    setState(() {});
  }

  Future getcarList() async {
    await apiService.getBearerToken();
    var result = await apiService.getcarList();
    var response = carListDataFromJson(result);
    if (response.status.toString() == 'SUCCESS') {
      setState(() {
        carList = response.list;
        carListtAll = carList;
        isLoading = false;
      });
    } else {
      setState(() {
        carList = [];
        carListtAll = [];
        isLoading = false;
      });
      showInSnackBar(context, response.message.toString());
    }
    setState(() {});
  }

  BookingsDetails? bookingsDetails;

  Future getBookingById() async {
    await apiService.getBearerToken();
    var result = await apiService.getBookingById(widget.bookingId);
    BookingGetByIdModel response = bookingGetByIdModelFromJson(result);
    print(response);
    if (response.status.toString() == 'SUCCESS') {
      setState(() {
        bookingsDetails = response.list;
        BookingId = (bookingsDetails!.id ?? '').toString();
        // phoneNumber = (bookingsDetails!.id ?? '').toString(); //phone number
        Fromlocation = (bookingsDetails!.pickupLocation ?? '').toString();
        Tolocation = (bookingsDetails!.dropLocation ?? '').toString();
        DateTime parsedDate = DateFormat('yyyy-MM-dd')
            .parse(bookingsDetails!.createdDate.toIso8601String());
        BookingDate = DateFormat('dd-MM-yyyy').format(parsedDate);
        DateTime parsedDate1 = DateFormat('yyyy-MM-dd')
            .parse(bookingsDetails!.fromDatetime.toIso8601String());
        Fromdate = DateFormat('dd-MM-yyyy').format(parsedDate1);
        DateTime parsedDate2 = DateFormat('yyyy-MM-dd')
            .parse(bookingsDetails!.toDatetime.toIso8601String());
        Todate = DateFormat('dd-MM-yyyy').format(parsedDate2);

        // licenseExpiryDateController.text = formattedDate;
        // mobileNumberController.text = driverDetails!.mobile ?? '';
        // emailIdController.text = driverDetails!.email ?? '';
        // addressController.text = driverDetails!.address ?? '';
      });
    } else {
      showInSnackBar(context, "Data not found");
      //isLoaded = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Center(
              child: Text(
            'Booking Approvel',
            style: TextStyle(color: Colors.white),
          )),
          backgroundColor: Color(0xFF06234C),
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: Colors.grey.shade300),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            spreadRadius: 5,
                            blurRadius: 10,
                            offset: Offset(0, 3),
                          ),
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width,
                            height: 60,
                            decoration: BoxDecoration(
                                color: Color(0xFF06234C),
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10.0),
                                    topLeft: Radius.circular(10.0))),
                            child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Row(children: [
                                  // Text(
                                  //   'Booking ID #5232555',
                                  //   style: TextStyle(
                                  //       color: Colors.white,
                                  //       fontWeight: FontWeight.bold,
                                  //       fontSize: 15),
                                  // ),
                                  Text(
                                    'Booking ID ',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                  Text(
                                    '#$BookingId',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ]))),
                        SizedBox(height: 10),
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Customer Name:',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      'Booking date:',
                                      style: TextStyle(fontSize: 15),
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 1),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Vetrimaran',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF06234C),
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      BookingDate,
                                      // '15-Sept-2024',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF06234C),
                                        fontSize: 15,
                                      ),
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 30),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Mobile number:',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      Text(
                                        '+91 856325241',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF06234C),
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                  // Column(
                                  //     crossAxisAlignment:
                                  //         CrossAxisAlignment.start,
                                  //     children: [
                                  //       Text(
                                  //         'No. of Persons:',
                                  //         style: TextStyle(fontSize: 15),
                                  //         textAlign: TextAlign.end,
                                  //       ),
                                  //       Text(
                                  //         // e.,
                                  //         '5',
                                  //         style: TextStyle(
                                  //           fontWeight: FontWeight.bold,
                                  //           color: Color(0xFF06234C),
                                  //           fontSize: 15,
                                  //         ),
                                  //         textAlign: TextAlign.left,
                                  //       ),
                                  //     ])
                                ],
                              ),
                              SizedBox(height: 30),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'From Date :',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      Text(
                                        Fromdate,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF06234C),
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'To Date:',
                                          style: TextStyle(fontSize: 15),
                                          textAlign: TextAlign.end,
                                        ),
                                        Text(
                                          Todate,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF06234C),
                                            fontSize: 15,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ])
                                ],
                              ),
                              SizedBox(height: 30),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('From',
                                          style: TextStyle(fontSize: 15)),
                                      Text(
                                        Fromlocation,
                                        //'Ramanathapuram',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF06234C),
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  )),
                                  Icon(Icons.compare_arrows,
                                      color: Colors.black),
                                  Expanded(
                                      child: Column(
                                          // crossAxisAlignment:
                                          //     CrossAxisAlignment.start,
                                          children: [
                                        Text('To',
                                            style: TextStyle(fontSize: 15)),
                                        Text(Tolocation,
                                            //'Kaniyakumari',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF06234C),
                                              fontSize: 15,
                                            ),
                                            textAlign: TextAlign.end),
                                      ]))
                                ],
                              ),
                              SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 25),
                  Text(
                    'Available Drivers',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Divider(),
                  isLoading
                      ? Center(child: CircularProgressIndicator())
                      : Column(
                          children: [
                            if (driverList != null)
                              ...driverList!.map(
                                (DriversList e) => Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 16.0),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 36,
                                        height: 36,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xFFF3F8FF),
                                        ),
                                        child: Icon(
                                          Icons.person_2_outlined,
                                          color: Colors.grey.shade700,
                                          size: 20,
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      Expanded(
                                        child: Text(
                                          e.username,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Radio<String>(
                                        value: e.id.toString(),
                                        groupValue: selectedDriver,
                                        onChanged: (String? value) {
                                          setState(() {
                                            selectedDriver = value!;
                                          });
                                        },
                                        activeColor: Color(0xFF0A3068),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                  SizedBox(height: 20),
                  Text(
                    'Available Cars',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Divider(),
                  isLoading
                      ? Center(child: CircularProgressIndicator())
                      : Column(children: [
                          if (carList != null)
                            ...carList!.map((ListElement e) => Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 16.0),
                                  child: Row(
                                    children: [
                                      Container(
                                          width: 50,
                                          child: e.imageUrl != null
                                              ? ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: Image.network(
                                                    AppConstants.imgBaseUrl +
                                                        e.imageUrl!,
                                                    width: double.infinity,
                                                    fit: BoxFit.contain,
                                                    height: 60.0,
                                                    // height: 100.0,
                                                    errorBuilder:
                                                        (BuildContext context,
                                                            Object exception,
                                                            StackTrace?
                                                                stackTrace) {
                                                      return Image.asset(
                                                          AppAssets.logo,
                                                          width: 30.0,
                                                          height: 50.0,
                                                          fit: BoxFit.cover);
                                                    },
                                                  ),
                                                )
                                              : Image.asset(AppAssets.logo,
                                                  width: 30.0,
                                                  height: 50.0,
                                                  fit: BoxFit.contain)),
                                      SizedBox(width: 18),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(children: [
                                              Text(
                                                e.brand,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                width: 15,
                                              ),
                                              Text(e.modal,
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold))
                                            ]),
                                            Text(
                                              'Sedan, Manual, 5 person',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Radio<String>(
                                        value: e.id.toString(),
                                        groupValue: selectedCar,
                                        onChanged: (String? value) {
                                          setState(() {
                                            selectedCar = value!;
                                          });
                                        },
                                        activeColor: Color(0xFF0A3068),
                                      ),
                                    ],
                                  ),
                                ))
                        ]),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          height: 50,
                          width: 130,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              _makePhoneCall();
                            },
                            icon: Icon(
                              Icons.phone_outlined,
                              color: Colors.black,
                              size: 30,
                            ),
                            label: Text(
                              'Call',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            ),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              backgroundColor: Colors.white,
                              side: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                          )),
                      SizedBox(
                          height: 50,
                          width: 130,
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Text(
                              'Confirm',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF06234C),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          )),
                    ],
                  ),
                ]))));
  }
}

// class CarSelection extends StatelessWidget {
//   final List<String> cars;
//   final List<String> carImages;
//   final String selectedCar;
//   final ValueChanged<String?> onChanged;

//   CarSelection({
//     required this.cars,
//     required this.carImages,
//     required this.selectedCar,
//     required this.onChanged,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: cars.asMap().entries.map((entry) {
//         int index = entry.key;
//         String car = entry.value;
//         return Container(
//           padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//           child: Row(
//             children: [
//               Image.asset(
//                 carImages[index],
//                 width: 80,
//                 height: 60,
//                 fit: BoxFit.contain,
//               ),
//               SizedBox(width: 18),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(car,
//                         style: TextStyle(
//                             fontSize: 18, fontWeight: FontWeight.bold)),
//                     Text(
//                       'Sedan, Manual, 5 person',
//                       style: TextStyle(color: Colors.black, fontSize: 16),
//                     ),
//                   ],
//                 ),
//               ),
//               Radio<String>(
//                 value: car,
//                 groupValue: selectedCar,
//                 onChanged: onChanged,
//                 activeColor: Color(0xFF0A3068),
//               ),
//             ],
//           ),
//         );
//       }).toList(),
//     );
//   }
//}





// import 'package:cabs/pages/admin_panel/bookings/driver_list_model.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// import '../../../services/cabs_api_service.dart';
// import '../../../services/comFuncService.dart';
// import 'booking_getbyid_model.dart';

// class BookingApprovel extends StatefulWidget {
//   int? bookingId;
  

//   BookingApprovel({super.key, this.bookingId});

//   @override
//   _BookingApprovelState createState() => _BookingApprovelState();
// }

// class _BookingApprovelState extends State<BookingApprovel> {
//   final CabsApiService apiService = CabsApiService();
//   String selectedDriver = '';
//   String selectedCar = '';
//   String BookingId = '';
//   String BookingDate = '';
//   String Fromlocation = '';
//   String Tolocation = '';

//   @override
//   void initState() {
//     super.initState();
//     refresh();
//      getdriverList();
//     print('Driver id :' + widget.bookingId.toString());
//   }

//   refresh() async {
//     if (widget.bookingId != null) {
//       await getBookingById();
//     }
//   }

//   bool isLoading = false;



//   List<DriversList>? driverList;
//   List<DriversList>? driverListtAll;
 
//   Future getdriverList() async {
//     setState(() {
//       isLoading = true;
//     });
//     await apiService.getBearerToken();
//     var result = await apiService.getdriverList();
//     var response = driverListDataFromJson(result);
//     if (response.status.toString() == 'SUCCESS') {
//       setState(() {
//         driverList = response.list;
//         driverListtAll = driverList;
//         isLoading = false;
//       });
//     } else {
//       setState(() {
//         driverList = [];
//         driverListtAll = [];
//         isLoading = false;
//       });
//       showInSnackBar(context, response.message.toString());
//     }
//     setState(() {});
//   }


//   BookingsDetails? bookingsDetails;

//   Future getBookingById() async {
//     await apiService.getBearerToken();
//     var result = await apiService.getBookingById(widget.bookingId);
//     BookingGetByIdModel response = bookingGetByIdModelFromJson(result);
//     print(response);
//     if (response.status.toString() == 'SUCCESS') {
//       setState(() {
//         bookingsDetails = response.list;
//         BookingId = (bookingsDetails!.id ?? '').toString();
//         Fromlocation = (bookingsDetails!.pickupLocation ?? '').toString();
//         Tolocation = (bookingsDetails!.dropLocation ?? '').toString();
//         DateTime parsedDate = DateFormat('yyyy-MM-dd')
//             .parse(bookingsDetails!.createdDate.toIso8601String());
//         BookingDate = DateFormat('dd-MM-yyyy').format(parsedDate);

//         // licenseExpiryDateController.text = formattedDate;
//         // mobileNumberController.text = driverDetails!.mobile ?? '';
//         // emailIdController.text = driverDetails!.email ?? '';
//         // addressController.text = driverDetails!.address ?? '';
//       });
//     } else {
//       showInSnackBar(context, "Data not found");
//       //isLoaded = false;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           title: Center(
//               child: Text(
//             'Booking Approvel',
//             style: TextStyle(color: Colors.white),
//           )),
//           backgroundColor: Color(0xFF06234C),
//         ),
//         body: SingleChildScrollView(
//             child: Padding(
//                 padding: const EdgeInsets.all(15.0),
//                 child: Column(children: [
//                   Container(
//                     decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(10.0),
//                         border: Border.all(color: Colors.grey.shade300),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey.withOpacity(0.4),
//                             spreadRadius: 5,
//                             blurRadius: 10,
//                             offset: Offset(0, 3),
//                           ),
//                         ]),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Container(
//                             width: MediaQuery.of(context).size.width,
//                             height: 60,
//                             decoration: BoxDecoration(
//                                 color: Color(0xFF06234C),
//                                 borderRadius: BorderRadius.only(
//                                     topRight: Radius.circular(10.0),
//                                     topLeft: Radius.circular(10.0))),
//                             child: Padding(
//                                 padding: const EdgeInsets.all(20.0),
//                                 child: Row(children: [
//                                   // Text(
//                                   //   'Booking ID #5232555',
//                                   //   style: TextStyle(
//                                   //       color: Colors.white,
//                                   //       fontWeight: FontWeight.bold,
//                                   //       fontSize: 15),
//                                   // ),
//                                   Text(
//                                     'Booking ID ',
//                                     style: TextStyle(
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 15),
//                                   ),
//                                   Text(
//                                     '#$BookingId',
//                                     style: TextStyle(
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 15),
//                                   ),
//                                 ]))),
//                         SizedBox(height: 10),
//                         Padding(
//                           padding: EdgeInsets.all(10.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Row(
//                                 children: [
//                                   Expanded(
//                                     child: Text(
//                                       'Customer Name:',
//                                       style: TextStyle(fontSize: 15),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     child: Text(
//                                       'Booking date:',
//                                       style: TextStyle(fontSize: 15),
//                                       textAlign: TextAlign.end,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(height: 1),
//                               Row(
//                                 children: [
//                                   Expanded(
//                                     child: Text(
//                                       'Vetrimaran',
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         color: Color(0xFF06234C),
//                                         fontSize: 15,
//                                       ),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     child: Text(
//                                       BookingDate,
//                                       // '15-Sept-2024',
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         color: Color(0xFF06234C),
//                                         fontSize: 15,
//                                       ),
//                                       textAlign: TextAlign.end,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(height: 30),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         'Mobile number:',
//                                         style: TextStyle(fontSize: 15),
//                                       ),
//                                       Text(
//                                         '+91 856325241',
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           color: Color(0xFF06234C),
//                                           fontSize: 15,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           'No. of Persons:',
//                                           style: TextStyle(fontSize: 15),
//                                           textAlign: TextAlign.end,
//                                         ),
//                                         Text(
//                                           '5',
//                                           style: TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             color: Color(0xFF06234C),
//                                             fontSize: 15,
//                                           ),
//                                           textAlign: TextAlign.left,
//                                         ),
//                                       ])
//                                 ],
//                               ),
//                               SizedBox(height: 30),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Expanded(
//                                       child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text('From',
//                                           style: TextStyle(fontSize: 15)),
//                                       Text(
//                                         Fromlocation,
//                                         //'Ramanathapuram',
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           color: Color(0xFF06234C),
//                                           fontSize: 15,
//                                         ),
//                                       ),
//                                     ],
//                                   )),
//                                   Icon(Icons.compare_arrows,
//                                       color: Colors.black),
//                                   Expanded(
//                                       child: Column(
//                                           // crossAxisAlignment:
//                                           //     CrossAxisAlignment.start,
//                                           children: [
//                                         Text('To',
//                                             style: TextStyle(fontSize: 15)),
//                                         Text(Tolocation,
//                                             //'Kaniyakumari',
//                                             style: TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                               color: Color(0xFF06234C),
//                                               fontSize: 15,
//                                             ),
//                                             textAlign: TextAlign.end),
//                                       ]))
//                                 ],
//                               ),
//                               SizedBox(height: 10),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 25),
//                   Text(
//                     'Available Drivers',
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                   ),
//                   Divider(),
//                  isLoading
//           ? Center(child: CircularProgressIndicator())
//           :  Column(
//                       children: [  if (driverList != null)
//                           ...driverList!.map(
//                             (DriversList e) =>  Container(
//           padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//           child: Row(
//             children: [
//               Container(
//                 width: 36,
//                 height: 36,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: Color(0xFFF3F8FF),
//                 ),
//                 child: Icon(
//                   Icons.person_2_outlined,
//                   color: Colors.grey.shade700,
//                   size: 20,
//                 ),
//               ),
//               SizedBox(width: 20),
//               Expanded(
//                 child: Text(
//                   e.fullname,
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                 ),
//               ),
//               Radio<String>(
//                 value: driver,
//                 groupValue: selectedDriver,
//                 onChanged: onChanged,
//                 activeColor: Color(0xFF0A3068),
//               ),
//             ],
//           ),
//         ))]),
//                   SizedBox(height: 20),
//                   Text(
//                     'Available Cars',
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                   ),
//                   Divider(),
//                   CarSelection(
//                     cars: [
//                       'Volkswagen Virtus',
//                       'Toyota Fortuner',
//                       'Volkswagen Virtus1'
//                     ],
//                     carImages: [
//                       'assets/images/car1.png',
//                       'assets/images/car2.png',
//                       'assets/images/car1.png'
//                     ],
//                     selectedCar: selectedCar,
//                     onChanged: (value) {
//                       setState(() {
//                         selectedCar = value!;
//                       });
//                     },
//                   ),
//                   SizedBox(height: 20),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       SizedBox(
//                           height: 50,
//                           width: 130,
//                           child: ElevatedButton.icon(
//                             onPressed: () {},
//                             icon: Icon(
//                               Icons.phone_outlined,
//                               color: Colors.black,
//                               size: 30,
//                             ),
//                             label: Text(
//                               'Call',
//                               style:
//                                   TextStyle(fontSize: 20, color: Colors.black),
//                             ),
//                             style: ElevatedButton.styleFrom(
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               backgroundColor: Colors.white,
//                               side: BorderSide(
//                                 color: Colors.black,
//                               ),
//                             ),
//                           )),
//                       SizedBox(
//                           height: 50,
//                           width: 130,
//                           child: ElevatedButton(
//                             onPressed: () {},
//                             child: Text(
//                               'Confirm',
//                               style:
//                                   TextStyle(color: Colors.white, fontSize: 20),
//                             ),
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Color(0xFF06234C),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                             ),
//                           )),
//                     ],
//                   ),
//                 ]))));
//   }
// }

// // class BookingInfoCard extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return isLoading
// //           ? Center(child: CircularProgressIndicator())
// //           : SingleChildScrollView(
// //               child: Padding(
// //                   padding: const EdgeInsets.all(15.0),
// //                   child: Column(
// //                       // crossAxisAlignment: CrossAxisAlignment.start,
// //                       children: [

// //                         if (bookingList != null)
// //                           ...bookingList!.map(
// //                             (BookingsDetails e) =>  Container(
// //       decoration: BoxDecoration(
// //           color: Colors.white,
// //           borderRadius: BorderRadius.circular(10.0),
// //           border: Border.all(color: Colors.grey.shade300),
// //           boxShadow: [
// //             BoxShadow(
// //               color: Colors.grey.withOpacity(0.4),
// //               spreadRadius: 5,
// //               blurRadius: 10,
// //               offset: Offset(0, 3),
// //             ),
// //           ]),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           Container(
// //               width: MediaQuery.of(context).size.width,
// //               height: 60,
// //               decoration: BoxDecoration(
// //                   color: Color(0xFF06234C),
// //                   borderRadius: BorderRadius.only(
// //                       topRight: Radius.circular(10.0),
// //                       topLeft: Radius.circular(10.0))),
// //               child: Padding(
// //                   padding: const EdgeInsets.all(20.0),
// //                   child: Text(
// //                     'Booking ID #5232555',
// //                     style: TextStyle(
// //                         color: Colors.white,
// //                         fontWeight: FontWeight.bold,
// //                         fontSize: 15),
// //                   ))),
// //           SizedBox(height: 10),
// //           Padding(
// //             padding: EdgeInsets.all(10.0),
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Row(
// //                   children: [
// //                     Expanded(
// //                       child: Text(
// //                         'Customer Name:',
// //                         style: TextStyle(fontSize: 15),
// //                       ),
// //                     ),
// //                     Expanded(
// //                       child: Text(
// //                         'Booking date:',
// //                         style: TextStyle(fontSize: 15),
// //                         textAlign: TextAlign.end,
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //                 SizedBox(height: 1),
// //                 Row(
// //                   children: [
// //                     Expanded(
// //                       child: Text(
// //                         'Vetrimaran',
// //                         style: TextStyle(
// //                           fontWeight: FontWeight.bold,
// //                           color: Color(0xFF06234C),
// //                           fontSize: 15,
// //                         ),
// //                       ),
// //                     ),
// //                     Expanded(
// //                       child: Text(
// //                         '15-Sept-2024',
// //                         style: TextStyle(
// //                           fontWeight: FontWeight.bold,
// //                           color: Color(0xFF06234C),
// //                           fontSize: 15,
// //                         ),
// //                         textAlign: TextAlign.end,
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //                 SizedBox(height: 30),
// //                 Row(
// //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                   children: [
// //                     Column(
// //                       crossAxisAlignment: CrossAxisAlignment.start,
// //                       children: [
// //                         Text(
// //                           'Mobile number:',
// //                           style: TextStyle(fontSize: 15),
// //                         ),
// //                         Text(
// //                           '+91 856325241',
// //                           style: TextStyle(
// //                             fontWeight: FontWeight.bold,
// //                             color: Color(0xFF06234C),
// //                             fontSize: 15,
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                     Column(
// //                         crossAxisAlignment: CrossAxisAlignment.start,
// //                         children: [
// //                           Text(
// //                             'No. of Persons:',
// //                             style: TextStyle(fontSize: 15),
// //                             textAlign: TextAlign.end,
// //                           ),
// //                           Text(
// //                             '5',
// //                             style: TextStyle(
// //                               fontWeight: FontWeight.bold,
// //                               color: Color(0xFF06234C),
// //                               fontSize: 15,
// //                             ),
// //                             textAlign: TextAlign.left,
// //                           ),
// //                         ])
// //                   ],
// //                 ),
// //                 SizedBox(height: 30),
// //                 Row(
// //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                   children: [
// //                     Column(
// //                       crossAxisAlignment: CrossAxisAlignment.start,
// //                       children: [
// //                         Text('From', style: TextStyle(fontSize: 15)),
// //                         Text(
// //                           'Ramanathapuram',
// //                           style: TextStyle(
// //                             fontWeight: FontWeight.bold,
// //                             color: Color(0xFF06234C),
// //                             fontSize: 15,
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                     Icon(Icons.compare_arrows, color: Colors.black),
// //                     Column(
// //                         crossAxisAlignment: CrossAxisAlignment.start,
// //                         children: [
// //                           Text('To', style: TextStyle(fontSize: 15)),
// //                           Text('Kaniyakumari',
// //                               style: TextStyle(
// //                                 fontWeight: FontWeight.bold,
// //                                 color: Color(0xFF06234C),
// //                                 fontSize: 15,
// //                               ),
// //                               textAlign: TextAlign.end),
// //                         ])
// //                   ],
// //                 ),
// //                 SizedBox(height: 10),
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //     )
// //     )
// //     ]
// //     )
// //     )
// //     );
// //   }
// // }

// // class DriverSelection extends StatelessWidget {
// //   final List<String> drivers;
// //   final String selectedDriver;
// //   final ValueChanged<String?> onChanged;

// //   DriverSelection({
// //     required this.drivers,
// //     required this.selectedDriver,
// //     required this.onChanged,
// //   });

// //   @override
// //   Widget build(BuildContext context) {
// //     return Column(
// //       children: drivers.map((driver) {
// //         return Container(
// //           padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
// //           child: Row(
// //             children: [
// //               Container(
// //                 width: 36,
// //                 height: 36,
// //                 decoration: BoxDecoration(
// //                   shape: BoxShape.circle,
// //                   color: Color(0xFFF3F8FF),
// //                 ),
// //                 child: Icon(
// //                   Icons.person_2_outlined,
// //                   color: Colors.grey.shade700,
// //                   size: 20,
// //                 ),
// //               ),
// //               SizedBox(width: 20),
// //               Expanded(
// //                 child: Text(
// //                   driver,
// //                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
// //                 ),
// //               ),
// //               Radio<String>(
// //                 value: driver,
// //                 groupValue: selectedDriver,
// //                 onChanged: onChanged,
// //                 activeColor: Color(0xFF0A3068),
// //               ),
// //             ],
// //           ),
// //         );
// //       }).toList(),
// //     );
// //   }
// // }

// class CarSelection extends StatelessWidget {
//   final List<String> cars;
//   final List<String> carImages;
//   final String selectedCar;
//   final ValueChanged<String?> onChanged;

//   CarSelection({
//     required this.cars,
//     required this.carImages,
//     required this.selectedCar,
//     required this.onChanged,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: cars.asMap().entries.map((entry) {
//         int index = entry.key;
//         String car = entry.value;
//         return Container(
//           padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//           child: Row(
//             children: [
//               Image.asset(
//                 carImages[index],
//                 width: 80,
//                 height: 60,
//                 fit: BoxFit.contain,
//               ),
//               SizedBox(width: 18),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(car,
//                         style: TextStyle(
//                             fontSize: 18, fontWeight: FontWeight.bold)),
//                     Text(
//                       'Sedan, Manual, 5 person',
//                       style: TextStyle(color: Colors.black, fontSize: 16),
//                     ),
//                   ],
//                 ),
//               ),
//               Radio<String>(
//                 value: car,
//                 groupValue: selectedCar,
//                 onChanged: onChanged,
//                 activeColor: Color(0xFF0A3068),
//               ),
//             ],
//           ),
//         );
//       }).toList(),
//     );
//   }
// }
