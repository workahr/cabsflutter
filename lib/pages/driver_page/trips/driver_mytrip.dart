import 'package:cabs/pages/driver_page/trips/driver_mytrip_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/app_colors.dart';
import '../../../services/cabs_api_service.dart';
import '../../../services/comFuncService.dart';

class DriverMyTrip extends StatefulWidget {
  @override
  State<DriverMyTrip> createState() => _DriverMyTripState();
}

class _DriverMyTripState extends State<DriverMyTrip> {
  final CabsApiService apiService = CabsApiService();

  List<MyTrips>? mytripList;
  List<MyTrips>? mytripListAll;
  bool isLoading = false;
  String? formattedDate;

  List<MyTrips>? livetrip;
  List<MyTrips>? completed;

  @override
  void initState() {
    super.initState();
    refresh();
  }

  refresh() async {
    print("userid :" + user_id.toString());
    getmytripByidList();
  }

  int? user_id;
  Future getmytripByidList() async {
    final prefs = await SharedPreferences.getInstance();
    user_id = prefs.getInt('user_id' ?? '');
    print("userid 1 api :" + user_id.toString());
    await apiService.getBearerToken();
    var result = await apiService.getmytripByidList(user_id);
    var response = mytripsListDataFromJson(result);
    if (response.status.toString() == 'SUCCESS') {
      setState(() {
        mytripList = response.list;
        // bookingListtAll = bookingList;
        livetrip = mytripList!
            .where((booking) =>
                booking.bookingStatus.trim().toUpperCase() != 'COMPLETED' &&
                booking.bookingStatus.trim().toUpperCase() != 'CANCELLED')
            .toList();

        completed = mytripList!
            .where((booking) =>
                booking.bookingStatus.trim().toUpperCase() == 'COMPLETED')
            .toList();

        mytripList!.forEach((booking) {});
        isLoading = false;
      });
    } else {
      setState(() {
        mytripList = [];
        mytripListAll = [];
        isLoading = false;
      });
      showInSnackBar(context, response.message.toString());
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
                backgroundColor: Color(0xFF193358),
                title: Text(
                  'My Trips',
                  style: TextStyle(
                    fontSize: 23,
                    color: Colors.white,
                  ),
                )),
            body: Column(children: [
              TabBar(
                dividerColor: Colors.transparent,
                indicatorColor: Color(0xFF193358),
                labelStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF193358)),
                unselectedLabelStyle: TextStyle(
                    color: Color(0xFF777777),
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
                tabs: [
                  Tab(
                    text: ('Live Trip'),
                  ),
                  Tab(
                    text: ('Completed'),
                  ),
                ],
              ),
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
                                  if (livetrip != null)
                                    ...livetrip!.map((MyTrips e) => Container(
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.all(
                                                    screenWidth * 0.04),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Flexible(
                                                        child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'From',
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xFF777777),
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        ),
                                                        Text(
                                                          e.pickupLocation,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        )
                                                      ],
                                                    )),
                                                    Flexible(
                                                        child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'To',
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xFF777777),
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        ),
                                                        Text(
                                                          e.dropLocation,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        )
                                                      ],
                                                    )),
                                                  ],
                                                ),
                                              ),
                                              // Ensure SizedBox has zero padding and touches container directly
                                              SizedBox(
                                                height: screenHeight * 0.05,
                                                width: double
                                                    .infinity, // Full width of the container
                                                child: DecoratedBox(
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFFF3F8FF),
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left:
                                                            screenWidth * 0.04),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          'Costumer Details',
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xFF193358),
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),

                                              Padding(
                                                padding: EdgeInsets.all(
                                                    screenWidth * 0.04),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'Name:',
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xFF777777),
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        ),
                                                        Text(
                                                          e.customerName
                                                                      .toString() ==
                                                                  "null"
                                                              ? ''
                                                              : e.customerName
                                                                  .toString(),
                                                          //'Vetrimaran',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        )
                                                      ],
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'Mobile number:',
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xFF777777),
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        ),
                                                        Text(
                                                          e.customerMobile
                                                                      .toString() ==
                                                                  "null"
                                                              ? ''
                                                              : e.customerMobile
                                                                  .toString(),
                                                          // '+91 856325241',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: screenHeight * 0.05,
                                                width: double.infinity,
                                                child: DecoratedBox(
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFFF3F8FF),
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left:
                                                            screenWidth * 0.04),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          'Pick-Up Address',
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xFF193358),
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(
                                                    screenWidth * 0.04),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      e.pickupLocation,
                                                      // 'No.2/6, Phase',
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xFF777777),
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                    // Text(
                                                    //   '4, Sri Menga Garden, Tallar Nagar',
                                                    //   style: TextStyle(
                                                    //       color: Color(0xFF777777),
                                                    //       fontSize: 15,
                                                    //       fontWeight: FontWeight.w400),
                                                    // ),
                                                    // Text(
                                                    //   'Ramathapuram 621361.',
                                                    //   style: TextStyle(
                                                    //       color: Color(0xFF777777),
                                                    //       fontSize: 15,
                                                    //       fontWeight: FontWeight.w400),
                                                    // ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: screenWidth * 0.04,
                                                    right: screenWidth * 0.04,
                                                    bottom: screenWidth * 0.04),
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Color(0xFF193358),
                                                    minimumSize:
                                                        Size(screenWidth, 54),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                  ),
                                                  onPressed: () {},
                                                  child: Text(
                                                    'Accept',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ))
                                ],
                              ),
                            )
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
                                  if (completed != null)
                                    ...completed!.map((MyTrips e) => Container(
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.all(
                                                    screenWidth * 0.04),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'From',
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xFF777777),
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        ),
                                                        Text(
                                                          e.pickupLocation,

                                                          // 'Ramanathapuram',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        )
                                                      ],
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'Start Date',
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xFF777777),
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        ),
                                                        Text(
                                                          formattedDate = DateFormat(
                                                                  'dd-MM-yyyy')
                                                              .format(e
                                                                  .fromDatetime),

                                                          //  '15-Sept-2024',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: screenWidth * 0.04,
                                                    right: screenWidth * 0.04,
                                                    bottom: screenWidth * 0.04),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'To',
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xFF777777),
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        ),
                                                        Text(
                                                          e.dropLocation,

                                                          //  'Kaniyakumari',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        )
                                                      ],
                                                    ),
                                                    CircleAvatar(
                                                        radius: 16,
                                                        backgroundColor:
                                                            const Color(
                                                                0xFF193358),
                                                        child: ImageIcon(
                                                          NetworkImage(
                                                              "assets/images/upanddownarrow.png"),
                                                          color: Colors.white,
                                                        )),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'End Date',
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xFF777777),
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        ),
                                                        Text(
                                                          formattedDate = DateFormat(
                                                                  'dd-MM-yyyy')
                                                              .format(
                                                                  e.toDatetime),
                                                          // '20-Sept-2024',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              // Ensure SizedBox has zero padding and touches container directly
                                              SizedBox(
                                                height: screenHeight * 0.05,
                                                width: double
                                                    .infinity, // Full width of the container
                                                child: DecoratedBox(
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFFF3F8FF),
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left:
                                                            screenWidth * 0.04),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          'Costumer Details',
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xFF193358),
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),

                                              Padding(
                                                padding: EdgeInsets.all(
                                                    screenWidth * 0.04),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'Name:',
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xFF777777),
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        ),
                                                        Text(
                                                          'Vetrimaran',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        )
                                                      ],
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'Mobile number:',
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xFF777777),
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        ),
                                                        Text(
                                                          '+91 856325241',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: screenWidth * 0.02,
                                                    right: screenWidth * 0.02,
                                                    bottom: screenWidth * 0.04),
                                                child: SizedBox(
                                                  height: screenHeight * 0.08,
                                                  width: double
                                                      .infinity, // Full width of the container
                                                  child: DecoratedBox(
                                                    decoration: BoxDecoration(
                                                        color:
                                                            Color(0xFFF3F8FF),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          left: screenWidth *
                                                              0.03,
                                                          right: screenWidth *
                                                              0.03),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                'Total Fair',
                                                                style: TextStyle(
                                                                    color: Color(
                                                                        0xFF193358),
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              ),
                                                              Text(
                                                                'For 5 Days',
                                                                style: TextStyle(
                                                                    color: Color(
                                                                        0xFF777777),
                                                                    fontSize:
                                                                        13,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                              ),
                                                            ],
                                                          ),
                                                          Text(
                                                            e.bookingCharges,
                                                            //  '₹5000',
                                                            style: TextStyle(
                                                                color: Color(
                                                                    0xFF193358),
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )),
                                ],
                              ),
                            ),
                    ]))
              ]))
            ])));
  }
}





// import 'package:cabs/pages/driver_page/trips/driver_mytrip_model.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// import '../../../constants/app_colors.dart';
// import '../../../services/cabs_api_service.dart';
// import '../../../services/comFuncService.dart';

// class DriverMyTrip extends StatefulWidget {
//   @override
//   State<DriverMyTrip> createState() => _DriverMyTripState();
// }

// class _DriverMyTripState extends State<DriverMyTrip> {
//   final CabsApiService apiService = CabsApiService();

//   List<MyTrips>? mytripList;
//   List<MyTrips>? mytripListAll;
//   bool isLoading = false;

//   List<MyTrips>? livetrip;
//   List<MyTrips>? completed;

//   @override
//   void initState() {
//     super.initState();
//     refresh();
//   }

//   refresh() async {
//     if (2 != null) {
//       await getmytripByidList();
//     }
//   }

//   Future getmytripByidList() async {
//     await apiService.getBearerToken();
//     var result = await apiService.getmytripByidList(2);
//     var response = mytripsListDataFromJson(result);
//     if (response.status.toString() == 'SUCCESS') {
//       setState(() {
//         mytripList = response.list;
//         // bookingListtAll = bookingList;
//         livetrip = mytripList!
//             .where((booking) =>
//                 booking.bookingStatus.trim().toUpperCase() != 'COMPLETED' &&
//                 booking.bookingStatus.trim().toUpperCase() != 'CANCELLED')
//             .toList();

//         completed = mytripList!
//             .where((booking) =>
//                 booking.bookingStatus.trim().toUpperCase() == 'COMPLETED')
//             .toList();

//         mytripList!.forEach((booking) {});
//         isLoading = false;
//       });
//     } else {
//       setState(() {
//         mytripList = [];
//         mytripListAll = [];
//         isLoading = false;
//       });
//       showInSnackBar(context, response.message.toString());
//     }
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;
//     return DefaultTabController(
//         length: 2,
//         child: Scaffold(
//             appBar: AppBar(
//                 backgroundColor: Color(0xFF193358),
//                 title: Text(
//                   'My Trips',
//                   style: TextStyle(
//                     fontSize: 23,
//                     color: Colors.white,
//                   ),
//                 )),
//             body: Column(children: [
//               TabBar(
//                 dividerColor: Colors.transparent,
//                 indicatorColor: Color(0xFF193358),
//                 labelStyle: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                     color: Color(0xFF193358)),
//                 unselectedLabelStyle: TextStyle(
//                     color: Color(0xFF777777),
//                     fontSize: 16,
//                     fontWeight: FontWeight.w400),
//                 tabs: [
//                   Tab(
//                     text: ('Live Trip'),
//                   ),
//                   Tab(
//                     text: ('Completed'),
//                   ),
//                 ],
//               ),
//               Expanded(
//                 child: TabBarView(
//                   children: [
//                     isLoading
//                         ? Center(child: CircularProgressIndicator())
//                         : Padding(
//                             padding: const EdgeInsets.all(15.0),
//                             child: Column(
//                               // crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 if (livetrip != null)
//                                   ...livetrip!.map((MyTrips e) => Container(
//                                         padding: EdgeInsets.all(10.0),
//                                         margin:
//                                             EdgeInsets.symmetric(vertical: 5.0),
//                                         decoration: BoxDecoration(
//                                           color: AppColors.light,
//                                           borderRadius:
//                                               BorderRadius.circular(7.0),
//                                           border: Border.all(
//                                             color: AppColors.lightGrey,
//                                             width: 1.0,
//                                           ),
//                                         ),
//                                         child: Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.start,
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Padding(
//                                               padding: EdgeInsets.all(
//                                                   screenWidth * 0.04),
//                                               child: Row(
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.start,
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment
//                                                         .spaceBetween,
//                                                 children: [
//                                                   Column(
//                                                     mainAxisAlignment:
//                                                         MainAxisAlignment.start,
//                                                     crossAxisAlignment:
//                                                         CrossAxisAlignment
//                                                             .start,
//                                                     children: [
//                                                       Text(
//                                                         'From',
//                                                         style: TextStyle(
//                                                             color: Color(
//                                                                 0xFF777777),
//                                                             fontSize: 15,
//                                                             fontWeight:
//                                                                 FontWeight
//                                                                     .w400),
//                                                       ),
//                                                       Text(
//                                                         e.pickupLocation,
//                                                         style: TextStyle(
//                                                             color: Colors.black,
//                                                             fontSize: 16,
//                                                             fontWeight:
//                                                                 FontWeight
//                                                                     .w600),
//                                                       )
//                                                     ],
//                                                   ),
//                                                   Column(
//                                                     crossAxisAlignment:
//                                                         CrossAxisAlignment
//                                                             .start,
//                                                     children: [
//                                                       Text(
//                                                         'To',
//                                                         style: TextStyle(
//                                                             color: Color(
//                                                                 0xFF777777),
//                                                             fontSize: 15,
//                                                             fontWeight:
//                                                                 FontWeight
//                                                                     .w400),
//                                                       ),
//                                                       Text(
//                                                         e.dropLocation,
//                                                         style: TextStyle(
//                                                             color: Colors.black,
//                                                             fontSize: 16,
//                                                             fontWeight:
//                                                                 FontWeight
//                                                                     .w600),
//                                                       )
//                                                     ],
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                             // Ensure SizedBox has zero padding and touches container directly
//                                             SizedBox(
//                                               height: screenHeight * 0.05,
//                                               width: double
//                                                   .infinity, // Full width of the container
//                                               child: DecoratedBox(
//                                                 decoration: BoxDecoration(
//                                                   color: Color(0xFFF3F8FF),
//                                                 ),
//                                                 child: Padding(
//                                                   padding: EdgeInsets.only(
//                                                       left: screenWidth * 0.04),
//                                                   child: Row(
//                                                     children: [
//                                                       Text(
//                                                         'Costumer Details',
//                                                         style: TextStyle(
//                                                             color: Color(
//                                                                 0xFF193358),
//                                                             fontSize: 15,
//                                                             fontWeight:
//                                                                 FontWeight
//                                                                     .w600),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),

//                                             Padding(
//                                               padding: EdgeInsets.all(
//                                                   screenWidth * 0.04),
//                                               child: Row(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment
//                                                         .spaceBetween,
//                                                 children: [
//                                                   Column(
//                                                     crossAxisAlignment:
//                                                         CrossAxisAlignment
//                                                             .start,
//                                                     children: [
//                                                       Text(
//                                                         'Name:',
//                                                         style: TextStyle(
//                                                             color: Color(
//                                                                 0xFF777777),
//                                                             fontSize: 15,
//                                                             fontWeight:
//                                                                 FontWeight
//                                                                     .w400),
//                                                       ),
//                                                       Text(
//                                                         'Vetrimaran',
//                                                         style: TextStyle(
//                                                             color: Colors.black,
//                                                             fontSize: 16,
//                                                             fontWeight:
//                                                                 FontWeight
//                                                                     .w600),
//                                                       )
//                                                     ],
//                                                   ),
//                                                   Column(
//                                                     crossAxisAlignment:
//                                                         CrossAxisAlignment
//                                                             .start,
//                                                     children: [
//                                                       Text(
//                                                         'Mobile number:',
//                                                         style: TextStyle(
//                                                             color: Color(
//                                                                 0xFF777777),
//                                                             fontSize: 15,
//                                                             fontWeight:
//                                                                 FontWeight
//                                                                     .w400),
//                                                       ),
//                                                       Text(
//                                                         '+91 856325241',
//                                                         style: TextStyle(
//                                                             color: Colors.black,
//                                                             fontSize: 16,
//                                                             fontWeight:
//                                                                 FontWeight
//                                                                     .w600),
//                                                       )
//                                                     ],
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                             SizedBox(
//                                               height: screenHeight * 0.05,
//                                               width: double.infinity,
//                                               child: DecoratedBox(
//                                                 decoration: BoxDecoration(
//                                                   color: Color(0xFFF3F8FF),
//                                                 ),
//                                                 child: Padding(
//                                                   padding: EdgeInsets.only(
//                                                       left: screenWidth * 0.04),
//                                                   child: Row(
//                                                     children: [
//                                                       Text(
//                                                         'Pick-Up Address',
//                                                         style: TextStyle(
//                                                             color: Color(
//                                                                 0xFF193358),
//                                                             fontSize: 15,
//                                                             fontWeight:
//                                                                 FontWeight
//                                                                     .w600),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                             Padding(
//                                               padding: EdgeInsets.all(
//                                                   screenWidth * 0.04),
//                                               child: Column(
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.start,
//                                                 children: [
//                                                   Text(
//                                                     e.pickupLocation,
//                                                     // 'No.2/6, Phase',
//                                                     style: TextStyle(
//                                                         color:
//                                                             Color(0xFF777777),
//                                                         fontSize: 15,
//                                                         fontWeight:
//                                                             FontWeight.w400),
//                                                   ),
//                                                   // Text(
//                                                   //   '4, Sri Menga Garden, Tallar Nagar',
//                                                   //   style: TextStyle(
//                                                   //       color: Color(0xFF777777),
//                                                   //       fontSize: 15,
//                                                   //       fontWeight: FontWeight.w400),
//                                                   // ),
//                                                   // Text(
//                                                   //   'Ramathapuram 621361.',
//                                                   //   style: TextStyle(
//                                                   //       color: Color(0xFF777777),
//                                                   //       fontSize: 15,
//                                                   //       fontWeight: FontWeight.w400),
//                                                   // ),
//                                                 ],
//                                               ),
//                                             ),
//                                             Padding(
//                                               padding: EdgeInsets.only(
//                                                   left: screenWidth * 0.04,
//                                                   right: screenWidth * 0.04,
//                                                   bottom: screenWidth * 0.04),
//                                               child: ElevatedButton(
//                                                 style: ElevatedButton.styleFrom(
//                                                   backgroundColor:
//                                                       Color(0xFF193358),
//                                                   minimumSize:
//                                                       Size(screenWidth, 54),
//                                                   shape: RoundedRectangleBorder(
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             10),
//                                                   ),
//                                                 ),
//                                                 onPressed: () {},
//                                                 child: Text(
//                                                   'Accept',
//                                                   style: TextStyle(
//                                                     color: Colors.white,
//                                                     fontSize: 18,
//                                                     fontWeight: FontWeight.w600,
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ))
//                               ],
//                             ),
//                           ),
//                     ListView.builder(
//                       itemCount: 1,
//                       itemBuilder: (context, index) {
//                         return Padding(
//                           padding: EdgeInsets.only(
//                               top: screenHeight * 0.025,
//                               left: screenWidth * 0.05,
//                               right: screenWidth * 0.05),
//                           child: Column(
//                             children: [
//                               Container(
//                                 width: screenWidth,
//                                 decoration: BoxDecoration(
//                                     border: Border.all(
//                                         color: Colors.grey.shade300, width: 1),
//                                     borderRadius: BorderRadius.circular(16)),
//                                 // Removed padding from around the SizedBox
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Padding(
//                                       padding:
//                                           EdgeInsets.all(screenWidth * 0.04),
//                                       child: Row(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Column(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.start,
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               Text(
//                                                 'From',
//                                                 style: TextStyle(
//                                                     color: Color(0xFF777777),
//                                                     fontSize: 15,
//                                                     fontWeight:
//                                                         FontWeight.w400),
//                                               ),
//                                               Text(
//                                                 'Ramanathapuram',
//                                                 style: TextStyle(
//                                                     color: Colors.black,
//                                                     fontSize: 16,
//                                                     fontWeight:
//                                                         FontWeight.w600),
//                                               )
//                                             ],
//                                           ),
//                                           Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               Text(
//                                                 'Start Date',
//                                                 style: TextStyle(
//                                                     color: Color(0xFF777777),
//                                                     fontSize: 15,
//                                                     fontWeight:
//                                                         FontWeight.w400),
//                                               ),
//                                               Text(
//                                                 '15-Sept-2024',
//                                                 style: TextStyle(
//                                                     color: Colors.black,
//                                                     fontSize: 16,
//                                                     fontWeight:
//                                                         FontWeight.w600),
//                                               )
//                                             ],
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     Padding(
//                                       padding: EdgeInsets.only(
//                                           left: screenWidth * 0.04,
//                                           right: screenWidth * 0.04,
//                                           bottom: screenWidth * 0.04),
//                                       child: Row(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Column(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.start,
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               Text(
//                                                 'To',
//                                                 style: TextStyle(
//                                                     color: Color(0xFF777777),
//                                                     fontSize: 15,
//                                                     fontWeight:
//                                                         FontWeight.w400),
//                                               ),
//                                               Text(
//                                                 'Kaniyakumari',
//                                                 style: TextStyle(
//                                                     color: Colors.black,
//                                                     fontSize: 16,
//                                                     fontWeight:
//                                                         FontWeight.w600),
//                                               )
//                                             ],
//                                           ),
//                                           CircleAvatar(
//                                               radius: 16,
//                                               backgroundColor:
//                                                   const Color(0xFF193358),
//                                               child: ImageIcon(
//                                                 NetworkImage(
//                                                     "assets/images/upanddownarrow.png"),
//                                                 color: Colors.white,
//                                               )),
//                                           Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               Text(
//                                                 'Vehicle No',
//                                                 style: TextStyle(
//                                                     color: Color(0xFF777777),
//                                                     fontSize: 15,
//                                                     fontWeight:
//                                                         FontWeight.w400),
//                                               ),
//                                               Text(
//                                                 '20-Sept-2024',
//                                                 style: TextStyle(
//                                                     color: Colors.black,
//                                                     fontSize: 16,
//                                                     fontWeight:
//                                                         FontWeight.w600),
//                                               )
//                                             ],
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     // Ensure SizedBox has zero padding and touches container directly
//                                     SizedBox(
//                                       height: screenHeight * 0.05,
//                                       width: double
//                                           .infinity, // Full width of the container
//                                       child: DecoratedBox(
//                                         decoration: BoxDecoration(
//                                           color: Color(0xFFF3F8FF),
//                                         ),
//                                         child: Padding(
//                                           padding: EdgeInsets.only(
//                                               left: screenWidth * 0.04),
//                                           child: Row(
//                                             children: [
//                                               Text(
//                                                 'Costumer Details',
//                                                 style: TextStyle(
//                                                     color: Color(0xFF193358),
//                                                     fontSize: 15,
//                                                     fontWeight:
//                                                         FontWeight.w600),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                     ),

//                                     Padding(
//                                       padding:
//                                           EdgeInsets.all(screenWidth * 0.04),
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               Text(
//                                                 'Name:',
//                                                 style: TextStyle(
//                                                     color: Color(0xFF777777),
//                                                     fontSize: 15,
//                                                     fontWeight:
//                                                         FontWeight.w400),
//                                               ),
//                                               Text(
//                                                 'Vetrimaran',
//                                                 style: TextStyle(
//                                                     color: Colors.black,
//                                                     fontSize: 16,
//                                                     fontWeight:
//                                                         FontWeight.w600),
//                                               )
//                                             ],
//                                           ),
//                                           Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               Text(
//                                                 'Mobile number:',
//                                                 style: TextStyle(
//                                                     color: Color(0xFF777777),
//                                                     fontSize: 15,
//                                                     fontWeight:
//                                                         FontWeight.w400),
//                                               ),
//                                               Text(
//                                                 '+91 856325241',
//                                                 style: TextStyle(
//                                                     color: Colors.black,
//                                                     fontSize: 16,
//                                                     fontWeight:
//                                                         FontWeight.w600),
//                                               )
//                                             ],
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     Padding(
//                                       padding: EdgeInsets.only(
//                                           left: screenWidth * 0.02,
//                                           right: screenWidth * 0.02,
//                                           bottom: screenWidth * 0.04),
//                                       child: SizedBox(
//                                         height: screenHeight * 0.08,
//                                         width: double
//                                             .infinity, // Full width of the container
//                                         child: DecoratedBox(
//                                           decoration: BoxDecoration(
//                                               color: Color(0xFFF3F8FF),
//                                               borderRadius:
//                                                   BorderRadius.circular(10)),
//                                           child: Padding(
//                                             padding: EdgeInsets.only(
//                                                 left: screenWidth * 0.03,
//                                                 right: screenWidth * 0.03),
//                                             child: Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment
//                                                       .spaceBetween,
//                                               children: [
//                                                 Column(
//                                                   crossAxisAlignment:
//                                                       CrossAxisAlignment.center,
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment.center,
//                                                   children: [
//                                                     Text(
//                                                       'Total Fair',
//                                                       style: TextStyle(
//                                                           color:
//                                                               Color(0xFF193358),
//                                                           fontSize: 15,
//                                                           fontWeight:
//                                                               FontWeight.w600),
//                                                     ),
//                                                     Text(
//                                                       'For 5 Days',
//                                                       style: TextStyle(
//                                                           color:
//                                                               Color(0xFF777777),
//                                                           fontSize: 13,
//                                                           fontWeight:
//                                                               FontWeight.w400),
//                                                     ),
//                                                   ],
//                                                 ),
//                                                 Text(
//                                                   '₹5000',
//                                                   style: TextStyle(
//                                                       color: Color(0xFF193358),
//                                                       fontSize: 15,
//                                                       fontWeight:
//                                                           FontWeight.w600),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               )
//                             ],
//                           ),
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ])));
//   }
// }
