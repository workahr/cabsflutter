import 'package:cabs/pages/admin_panel/admin_sidemenu.dart';
import 'package:cabs/pages/admin_panel/bookings/booking_approvel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constants/app_assets.dart';
import '../../../constants/app_colors.dart';
import '../../../services/cabs_api_service.dart';
import '../../../services/comFuncService.dart';
import 'admin_all_booking_model.dart';
//import 'package:dotted_line/dotted_line.dart';

class Admin_All_Bookings extends StatefulWidget {
  @override
  _Admin_All_BookingsState createState() => _Admin_All_BookingsState();
}

class _Admin_All_BookingsState extends State<Admin_All_Bookings> {
  final CabsApiService apiService = CabsApiService();
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey<ScaffoldState>();

  String? formattedDate;
  String? formattedTime;

  @override
  void initState() {
    getbookingList();
    super.initState();
  }

  bool isLoading = false;
  List<AllBookings>? bookingList;
  List<AllBookings>? bookingListtAll;

  Future getbookingList() async {
    await apiService.getBearerToken();
    var result = await apiService.getbookingList();
    var response = allbookingListDataFromJson(result);
    if (response.status.toString() == 'SUCCESS') {
      setState(() {
        bookingList = response.list;
        bookingListtAll = bookingList;
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

  int pendingBookings = 5;
  int totalBookings = 15;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _drawerKey,
        drawer: Admin_SideMenu(),
        appBar: AppBar(
          title: Text(
            'Dashboard',
            style: TextStyle(color: Colors.white),
          ),
          iconTheme: IconThemeData(
            color: Colors.white, // Change drawer icon color to white
          ),
          backgroundColor: Color(0xFF06234C),
        ),
        body: SingleChildScrollView(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                            padding: EdgeInsets.all(16),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      padding: EdgeInsets.all(6),
                                      color: Color(0xFFF3F8FF),
                                      child: Row(children: [
                                        Icon(Icons.access_time),
                                        Text(
                                          'Pending: $pendingBookings',
                                          style: TextStyle(
                                            color: Color(0xFF06234C),
                                            fontSize: 16,
                                          ),
                                        ),
                                      ])),
                                  Container(
                                      padding: EdgeInsets.all(6),
                                      color: Color(0xFFF3F8FF),
                                      child: Row(children: [
                                        Icon(Icons.directions_car),
                                        Text(
                                          'Total Bookings: $totalBookings',
                                          style: TextStyle(
                                            color: Color(0xFF06234C),
                                            fontSize: 16,
                                          ),
                                        )
                                      ]))
                                ])),
                        if (bookingList != null)
                          ...bookingList!.map(
                            (AllBookings e) => Container(
                              padding: EdgeInsets.all(10.0),
                              margin: EdgeInsets.symmetric(vertical: 5.0),
                              decoration: BoxDecoration(
                                color: AppColors.light,
                                borderRadius: BorderRadius.circular(7.0),
                                border: Border.all(
                                  color: AppColors.lightGrey,
                                  width: 1.0,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      padding: EdgeInsets.all(6),
                                      color: Color(0xFFF3F8FF),
                                      child: Row(children: [
                                        Text(
                                          'Booking ID: #',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          e.id.toString(),
                                          //'Booking ID: #',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      ])),
                                  SizedBox(height: 8),
                                  Row(children: [
                                    Text(
                                      formattedDate = DateFormat('dd-MM-yyyy')
                                          .format(e.createdDate),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "|",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      formattedTime = DateFormat('HH:mm')
                                          .format(e.createdDate),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )
                                  ]),
                                  SizedBox(height: 8),

                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'From:',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              e.pickupLocation,
                                              style: TextStyle(
                                                  color: Color(0xFF06234C),
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                              softWrap: true,
                                              // overflow: TextOverflow
                                              //     .ellipsis, // Prevent overflow with ellipsis
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Image.asset(
                                        AppAssets.arrows,
                                        width: 25.0,
                                        height: 25.0,
                                        fit: BoxFit.cover,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              'To:',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              e.dropLocation,
                                              style: TextStyle(
                                                  color: Color(0xFF06234C),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15),
                                              softWrap: true,
                                              // overflow: TextOverflow
                                              //     .ellipsis, // Prevent overflow with ellipsis
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),

                                  // DottedLine(
                                  //   direction: Axis.horizontal,
                                  //   lineLength: double.infinity,
                                  //   lineThickness: 2.0,
                                  //   dashLength: 6.0,
                                  //   dashColor: Colors.black,
                                  // ),
                                  SizedBox(height: 12),
                                  Center(
                                      child: TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  BookingApprovel(
                                                    bookingId: e.id,
                                                  ))).then((value) {});
                                    },
                                    child: Text(
                                      'View Details',
                                      style: TextStyle(
                                          color: Color(0xFF06234C),
                                          fontWeight: FontWeight.bold),
                                    ),
                                    style: TextButton.styleFrom(
                                      iconColor: Color(0xFF1C3D5B),
                                      // backgroundColor: Color(0xFF1C3D5B),
                                    ),
                                  )),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  )));
  }
}

  // Reusable method for creating booking cards
  



// import 'package:flutter/material.dart';

// import '../../../services/cabs_api_service.dart';
// import '../../../services/comFuncService.dart';
// import 'admin_all_booking_model.dart';
// //import 'package:dotted_line/dotted_line.dart';

// class Admin_All_Bookings extends StatefulWidget {
//   @override
//   _Admin_All_BookingsState createState() => _Admin_All_BookingsState();
// }

// class _Admin_All_BookingsState extends State<Admin_All_Bookings> {

//  final CabsApiService apiService = CabsApiService();

//   @override
//   void initState() {
//     getbookingList();

//     super.initState();
//   }

//   bool isLoading = false;
//   List<AllBookings>? bookingList;
//   List<AllBookings>? bookingListtAll;


//    Future getbookingList() async {
//     await apiService.getBearerToken();
//     var result = await apiService.getbookingList();
//     var response = allbookingListDataFromJson(result);
//     if (response.status.toString() == 'SUCCESS') {
//       setState(() {
//         bookingList = response.list;
//         bookingListtAll = bookingList;
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
  
//   int pendingBookings = 5;
//   int totalBookings = 15;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Dashboard',
//           style: TextStyle(color: Colors.white),
//         ),
//         backgroundColor: Color(0xFF06234C),
//       ),
//       body: Column(
//         children: [
//           Padding(
//               padding: EdgeInsets.all(16),
//               child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(
//                       padding: EdgeInsets.all(6),
//                       color: Color(0xFFF3F8FF),
//                       child: Text(
//                         'Pending: $pendingBookings',
//                         style: TextStyle(
//                           color: Color(0xFF06234C),
//                           fontSize: 16,
//                         ),
//                       ),
//                     ),
//                     Container(
//                         padding: EdgeInsets.all(6),
//                         color: Color(0xFFF3F8FF),
//                         child: Text(
//                           'Total Bookings: $totalBookings',
//                           style: TextStyle(
//                             color: Color(0xFF06234C),
//                             fontSize: 16,
//                           ),
//                         ))
//                   ])),

//           // Booking Cards
//           Expanded(
//             child: ListView(
//               padding: EdgeInsets.all(16),
//               children: [
//                 bookingCard('5232555', '25-Aug-2024', '2:00 PM',
//                     'Ramanathapuram', 'Kaniyakumari'),
//                 bookingCard('5232556', '25-Aug-2024', '2:00 PM',
//                     'Ramanathapuram', 'Kaniyakumari'),
//                 bookingCard('5232557', '25-Aug-2024', '2:00 PM',
//                     'Ramanathapuram', 'Kaniyakumari'),
//               ],
//             ),
//           ),
//         ],
//       ),

//       // Bottom Navigation Bar
//       bottomNavigationBar: BottomNavigationBar(
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.book),
//             label: 'Bookings',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.report),
//             label: 'Reports',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.history),
//             label: 'History',
//           ),
//         ],
//         selectedItemColor: Colors.blue[800],
//       ),
//     );
//   }

//   // Reusable method for creating booking cards
//   Widget bookingCard(
//       String id, String date, String time, String from, String to) {
//     return Card(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10),
//       ),
//       elevation: 4,
//       margin: EdgeInsets.only(bottom: 16),
//       child: Padding(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//                 padding: EdgeInsets.all(6),
//                 color: Color(0xFFF3F8FF),
//                 child: Text(
//                   'Booking ID: #$id',
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 )),
//             SizedBox(height: 8),
//             Text('$date | $time'),
//             SizedBox(height: 8),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text('From:'),
//                 Text('To:'),
//               ],
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   '$from',
//                   style: TextStyle(
//                       color: Color(0xFF06234C), fontWeight: FontWeight.bold),
//                 ),
//                 Text(
//                   '$to',
//                   style: TextStyle(
//                       color: Color(0xFF06234C), fontWeight: FontWeight.bold),
//                 ),
//               ],
//             ),
//             // DottedLine(
//             //   direction: Axis.horizontal,
//             //   lineLength: double.infinity,
//             //   lineThickness: 2.0,
//             //   dashLength: 6.0,
//             //   dashColor: Colors.black,
//             // ),
//             SizedBox(height: 12),
//             Center(
//                 child: TextButton(
//               onPressed: () {
//                 // Handle view details action
//               },
//               child: Text(
//                 'View Details',
//                 style: TextStyle(
//                     color: Color(0xFF06234C), fontWeight: FontWeight.bold),
//               ),
//               style: TextButton.styleFrom(
//                 iconColor: Color(0xFF1C3D5B),
//                 // backgroundColor: Color(0xFF1C3D5B),
//               ),
//             )),
//           ],
//         ),
//       ),
//     );
//   }
// }

