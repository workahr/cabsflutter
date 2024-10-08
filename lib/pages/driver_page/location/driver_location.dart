import 'package:flutter/material.dart';

class Driver_Location extends StatefulWidget {
  const Driver_Location({super.key});

  @override
  State<Driver_Location> createState() => _Driver_LocationState();
}

class _Driver_LocationState extends State<Driver_Location> {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        Image.network(
          'assets/images/driverhome_2.jpeg',
          width: screenWidth,
          height: screenHeight,
          fit: BoxFit.cover,
        ),
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
            height: screenHeight * 0.2,
            width: double.infinity,
            child: Column(
              children: [
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
                      'Allow access your location',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Text(
                  'Enter your location manually',
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    color: Color(0xFF193358),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
