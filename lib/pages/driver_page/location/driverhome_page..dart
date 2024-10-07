import 'package:flutter/material.dart';

import '../sidemenu.dart';

class DriverhomePage extends StatefulWidget {
  const DriverhomePage({super.key});

  @override
  State<DriverhomePage> createState() => _DriverhomePageState();
}

class _DriverhomePageState extends State<DriverhomePage> {
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _drawerKey,
      drawer: SideMenu(),
      body: Row(
        children: [
          Stack(
            children: [
              Image.asset(
                'assets/images/driverhome_2.jpeg',
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
                            width: 170,
                          ),
                          SizedBox(
                              height: 48,
                              width: 124,
                              child: DecoratedBox(
                                  decoration: BoxDecoration(
                                      color: const Color(0xFF193358),
                                      borderRadius: BorderRadius.circular(28)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 4),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                            radius: 20,
                                            backgroundColor:
                                                const Color(0xFFF3F8FF),
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
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
