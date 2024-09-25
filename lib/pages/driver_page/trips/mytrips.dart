import 'package:cabs/pages/driver_page/trips/tab.dart';
import 'package:flutter/material.dart';

class mytripsPage1 extends StatefulWidget {
  @override
  State<mytripsPage1> createState() => _mytripsPage1State();
}

class _mytripsPage1State extends State<mytripsPage1> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: screenHeight * 0.13,
        backgroundColor: Color(0xFF193358),
        title: Text(
          'My trips',
          style: TextStyle(
              fontSize: 23, color: Colors.white, fontWeight: FontWeight.w700),
        ),
        leading: Icon(
          Icons.arrow_back_ios_rounded,
          color: Colors.white,
        ),
      ),
      body: TabBarPage(),
    );
  }
}
