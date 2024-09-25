// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class livetrippage extends StatefulWidget {
  const livetrippage({super.key});

  @override
  State<livetrippage> createState() => _livetrippageState();
}

class _livetrippageState extends State<livetrippage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return ListView.builder(
      itemCount: 1,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(
              top: screenHeight * 0.025,
              left: screenWidth * 0.05,
              right: screenWidth * 0.05),
          child: Column(
            children: [
              Container(
                width: screenWidth,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300, width: 1),
                    borderRadius: BorderRadius.circular(16)),
                // Removed padding from around the SizedBox
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(screenWidth * 0.04),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'From',
                                style: TextStyle(
                                    color: Color(0xFF777777),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                'Ramanathapuram',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'To',
                                style: TextStyle(
                                    color: Color(0xFF777777),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                'Kaniyakumari',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Ensure SizedBox has zero padding and touches container directly
                    SizedBox(
                      height: screenHeight * 0.05,
                      width: double.infinity, // Full width of the container
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Color(0xFFF3F8FF),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: screenWidth * 0.04),
                          child: Row(
                            children: [
                              Text(
                                'Costumer Details',
                                style: TextStyle(
                                    color: Color(0xFF193358),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.all(screenWidth * 0.04),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Name:',
                                style: TextStyle(
                                    color: Color(0xFF777777),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                'Vetrimaran',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Mobile number:',
                                style: TextStyle(
                                    color: Color(0xFF777777),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                '+91 856325241',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
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
                          padding: EdgeInsets.only(left: screenWidth * 0.04),
                          child: Row(
                            children: [
                              Text(
                                'Pick-Up Address',
                                style: TextStyle(
                                    color: Color(0xFF193358),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(screenWidth * 0.04),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'No.2/6, Phase',
                            style: TextStyle(
                                color: Color(0xFF777777),
                                fontSize: 15,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            '4, Sri Menga Garden, Tallar Nagar',
                            style: TextStyle(
                                color: Color(0xFF777777),
                                fontSize: 15,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            'Ramathapuram 621361.',
                            style: TextStyle(
                                color: Color(0xFF777777),
                                fontSize: 15,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: screenWidth * 0.04,
                          right: screenWidth * 0.04,
                          bottom: screenWidth * 0.04),
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
                          'Accept',
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
              )
            ],
          ),
        );
      },
    );
  }
}
