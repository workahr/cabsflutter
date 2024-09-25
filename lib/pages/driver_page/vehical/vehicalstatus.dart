import 'package:flutter/material.dart';
import '../../../widgets/custom_text_field.dart';

class vehicalstatusScreen extends StatefulWidget {
  @override
  State<vehicalstatusScreen> createState() => _vehicalstatusScreenState();
}

class _vehicalstatusScreenState extends State<vehicalstatusScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: screenHeight * 0.13,
        backgroundColor: Color(0xFF193358),
        title: Text(
          'Back',
          style: TextStyle(
              fontSize: 23, color: Colors.white, fontWeight: FontWeight.w700),
        ),
        leading: Icon(
          Icons.arrow_back_ios_rounded,
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: Column(
          children: [
            CustomeTextField(
              hint: 'Enter Vehicle Name',
              width: screenWidth * 1,
            ),
            CustomeTextField(
              hint: 'Enter Vehicle Number',
              width: screenWidth * 1,
            ),
            Spacer(), 
            Padding(
              padding: EdgeInsets.only(bottom: screenWidth * 0.04),
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
                  'Submit',
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
    );
  }
}
