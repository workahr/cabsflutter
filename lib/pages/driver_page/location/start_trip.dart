// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'sidemenu.dart';

class start_trip extends StatefulWidget {
  const start_trip({super.key});

  @override
  State<start_trip> createState() => _start_tripState();
}

class _start_tripState extends State<start_trip> {
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey<ScaffoldState>();

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
                                    'My Tips',
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
              height: screenHeight * 0.52,
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
                      height: screenHeight * 0.16,
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
                                Text(
                                  'Ramanathapuram',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color(0xFF193358),
                                    fontWeight: FontWeight.w600,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: screenHeight * 0.05,
                            ),
                            Row(
                              children: [
                                Image.network(
                                  'assets/images/Map.png',
                                  height: 24,
                                  width: 24,
                                ),
                                SizedBox(width: screenWidth * 0.018),
                                Text(
                                  'Kaniyakumari',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color(0xFF193358),
                                    fontWeight: FontWeight.w600,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
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
                              'Vetrimaran',
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
                          child: Icon(
                            Icons.call_outlined,
                            color: const Color(0xFF193358),
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'No.2/6, Phase 4, Sri Menga Garden,',
                              style: TextStyle(
                                  fontSize: 15,
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF7D7D7D)),
                            ),
                            Text(
                              'Tallar Nagar Ramathapuram 621361.',
                              style: TextStyle(
                                  fontSize: 15,
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF7D7D7D)),
                            ),
                          ],
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
                      onPressed: () {},
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
