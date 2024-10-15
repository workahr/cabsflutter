// ignore_for_file: prefer_const_constructors

import 'package:cabs/pages/driver_page/location/km_update_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../services/cabs_api_service.dart';
import '../../../services/comFuncService.dart';
import '../../../widgets/custom_text_field.dart';

import '../sidemenu.dart';
import '../trips/driver_mytrip.dart';
import 'booking_list_byid_model.dart';
import 'livetrip_page.dart';

class start_trip extends StatefulWidget {
  int? bookingId;
  String? customername;
  String? customermobile;

  start_trip(
      {super.key, this.bookingId, this.customername, this.customermobile});

  @override
  State<start_trip> createState() => _start_tripState();
}

class _start_tripState extends State<start_trip> {
  final CabsApiService apiService = CabsApiService();
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey<ScaffoldState>();
  TextEditingController startkmCtrl = TextEditingController();

  String BookingId = '';
  String Fromlocation = '';
  String Tolocation = '';
  String address = '';

  Future updatestartkilomter() async {
    await apiService.getBearerToken();

    Map<String, dynamic> postData = {
      "booking_id": widget.bookingId,
      "start_km": startkmCtrl.text,
      "end_km": "",
    };
    print("updateexpenses $postData");
    var result = await apiService.updatestartkilomter(postData);

    KmupdateModel response = kmupdateModelFromJson(result);

    if (response.status.toString() == 'SUCCESS') {
      showInSnackBar(context, response.message.toString());
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LivetripPage(bookingId: widget.bookingId),
        ),
      );
    } else {
      print(response.message.toString());
      showInSnackBar(context, response.message.toString());
    }
  }

  void _makePhoneCall() async {
    String? phoneNumber = widget.customermobile;

    if (phoneNumber == null || phoneNumber.isEmpty) {
      throw 'Phone number is not available';
    }
    String telUrl = 'tel:$phoneNumber';
    if (await canLaunch(telUrl)) {
      await launch(telUrl);
    } else {
      throw 'Could not launch phone call';
    }
  }

  @override
  void initState() {
    super.initState();
    getBookingById();
    print('booking id :' + widget.bookingId.toString());
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
        address = (bookingsDetails!.pickupLocation ?? '').toString();
      });
    } else {
      showInSnackBar(context, "Data not found");
      //isLoaded = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _drawerKey,
      drawer: SideMenu(),
      body: Stack(
        children: [
          Image.asset(
            'assets/images/driverhome_1.jpeg',
            width: screenWidth,
            height: screenHeight,
            fit: BoxFit.cover,
          ),
          Positioned(
              child: Padding(
            padding: const EdgeInsets.only(top: 43, left: 28, right: 28),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                        radius: 30,
                        backgroundColor: const Color(0xFFF3F8FF),
                        child: IconButton(
                            onPressed: () {
                              setState(() {
                                _drawerKey.currentState!.openDrawer();
                              });
                            },
                            icon: Icon(
                              Icons.menu_outlined,
                              color: const Color(0xFF193358),
                            ))),
                    SizedBox(
                        height: 48,
                        width: 150,
                        child: DecoratedBox(
                            decoration: BoxDecoration(
                                color: const Color(0xFF193358),
                                borderRadius: BorderRadius.circular(28)),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 4,
                              ),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                      radius: 20,
                                      backgroundColor: const Color(0xFFF3F8FF),
                                      child: Icon(
                                        Icons.person_2_outlined,
                                        color: const Color(0xFF193358),
                                      )),
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xFF193358),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                DriverMyTrip(),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        'My Tips',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16),
                                      ))
                                ],
                              ),
                            ))),
                  ],
                )
              ],
            ),
          )),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(23),
                  topRight: Radius.circular(23),
                ),
              ),
              //   height: screenHeight * 0.52,
              width: double.infinity,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: screenHeight * 0.03,
                      right: screenWidth * 0.075,
                    ),
                    child: Text(
                      'Booking Request',
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        color: Color(0xFF193358),
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.075),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFF3F8FF),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      width: screenWidth * 0.9,
                      // height: screenHeight * 0.16,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 12, top: 18, bottom: 18),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Image.network(
                                  'assets/images/Circle.png',
                                  height: 24,
                                  width: 24,
                                ),
                                SizedBox(width: screenWidth * 0.018),
                                Expanded(
                                  child: Text(
                                    Fromlocation,
                                    // 'Ramanathapuram',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Color(0xFF193358),
                                      fontWeight: FontWeight.w600,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Image.network(
                                  'assets/images/Map.png',
                                  height: 24,
                                  width: 24,
                                ),
                                SizedBox(width: screenWidth * 0.018),
                                Expanded(
                                    child: Text(
                                  Tolocation,
                                  //   'Kaniyakumari',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color(0xFF193358),
                                    fontWeight: FontWeight.w600,
                                    decoration: TextDecoration.none,
                                  ),
                                )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: screenWidth * 0.075),
                        child: Text(
                          'Customer Details',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.014),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.075),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: const Color(0xFFF3F8FF),
                              child: Icon(
                                Icons.person_2_outlined,
                                color: const Color(0xFF193358),
                              ),
                            ),
                            SizedBox(width: screenHeight * 0.018),
                            Text(
                              widget.customername.toString(),
                              // 'Vetrimaran',
                              style: TextStyle(
                                fontSize: 18,
                                color: Color(0xFF1E1E1E),
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ],
                        ),
                        CircleAvatar(
                          backgroundColor: const Color(0xFFF3F8FF),
                          child: IconButton(
                            icon: Icon(Icons.call_outlined,
                                color: const Color(0xFF193358)),
                            onPressed: () => {_makePhoneCall()},
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.10),
                    child: Row(
                      children: [
                        Image.network(
                          'assets/images/Map.png',
                          height: 24,
                          width: 24,
                        ),
                        SizedBox(width: screenWidth * 0.03),
                        Expanded(
                          child: Text(
                            address,
                            //  'No.2/6, Phase 4, Sri Menga Garden,',
                            style: TextStyle(
                                fontSize: 15,
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF7D7D7D)),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.075,
                      vertical: screenHeight * 0.03,
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF193358),
                        minimumSize: Size(screenWidth, 54),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return StatefulBuilder(
                                  builder: (context, setState) {
                                return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                    ),
                                    content: SingleChildScrollView(
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        padding: EdgeInsets.all(2),
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(height: 16),
                                              Text(
                                                "Please Enter The Start Kilometer",
                                                style: TextStyle(fontSize: 16),
                                              ),

                                              SizedBox(height: 16),

                                              // Description text field
                                              CustomeTextField(
                                                control: startkmCtrl,
                                                hint: "Start Kilometer",
                                                type: const TextInputType
                                                    .numberWithOptions(),
                                                inputFormaters: [
                                                  FilteringTextInputFormatter
                                                      .allow(RegExp(
                                                          r'^-?(\d+)?\.?\d{0,11}'))
                                                ],
                                              ),
                                              SizedBox(height: 30),

                                              // Submit button
                                              SizedBox(
                                                width: double.infinity,
                                                height: 50,
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
                                                  onPressed: () {
                                                    updatestartkilomter();
                                                  },
                                                  child: Text(
                                                    'Submit',
                                                    style:
                                                        TextStyle(fontSize: 16),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ));
                              });
                            });
                      },
                      child: Text(
                        'Start your trip',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
