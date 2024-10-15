// ignore_for_file: prefer_const_constructors

import 'package:cabs/pages/driver_page/location/km_update_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../services/cabs_api_service.dart';
import '../../../services/comFuncService.dart';
import '../../../widgets/custom_text_field.dart';
import '../sidemenu.dart';
import '../trips/driver_mytrip.dart';
import 'driverhome_page..dart';

class LivetripPage extends StatefulWidget {
  int? bookingId;
  LivetripPage({super.key, this.bookingId});

  @override
  State<LivetripPage> createState() => _LivetripPageState();
}

class _LivetripPageState extends State<LivetripPage> {
  final CabsApiService apiService = CabsApiService();
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey<ScaffoldState>();
  TextEditingController endkmCtrl = TextEditingController();

  Future updatestartkilomter() async {
    await apiService.getBearerToken();

    Map<String, dynamic> postData = {
      "booking_id": widget.bookingId,
      "start_km": "",
      "end_km": endkmCtrl.text,
    };
    print("updateexpenses $postData");
    var result = await apiService.updatestartkilomter(postData);

    KmupdateModel response = kmupdateModelFromJson(result);

    if (response.status.toString() == 'SUCCESS') {
      showInSnackBar(context, response.message.toString());
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DriverMyTrip(),
        ),
      );
    } else {
      print(response.message.toString());
      showInSnackBar(context, response.message.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        key: _drawerKey,
        drawer: SideMenu(),
        body: Stack(children: [
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
                        width: 124,
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
                                  SizedBox(
                                    width: screenWidth * 0.015,
                                  ),
                                  Text(
                                    'My Trips',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16),
                                  )
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
              height: screenHeight * 0.10,
              width: double.infinity,
              child: Padding(
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
                          return StatefulBuilder(builder: (context, setState) {
                            return AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                ),
                                content: SingleChildScrollView(
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.all(2),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 16),
                                          Text(
                                            "Please Enter The End Kilometer",
                                            style: TextStyle(fontSize: 16),
                                          ),

                                          SizedBox(height: 16),

                                          // Description text field
                                          CustomeTextField(
                                            control: endkmCtrl,
                                            hint: "End  Kilometer",
                                            type: const TextInputType
                                                .numberWithOptions(),
                                            inputFormaters: [
                                              FilteringTextInputFormatter.allow(
                                                  RegExp(
                                                      r'^-?(\d+)?\.?\d{0,11}'))
                                            ],
                                          ),
                                          SizedBox(height: 30),

                                          // Submit button
                                          SizedBox(
                                            width: double.infinity,
                                            height: 50,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Color(0xFF193358),
                                                minimumSize:
                                                    Size(screenWidth, 54),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                              onPressed: () {
                                                updatestartkilomter();
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
                                ));
                          });
                        });
                  },
                  child: Text(
                    'Trip Complete',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          )
        ]));
  }
}
