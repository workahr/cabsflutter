import 'package:flutter/material.dart';

class vehicalreport extends StatefulWidget {
  const vehicalreport({super.key});

  @override
  State<vehicalreport> createState() => _vehicalreportState();
}

class _vehicalreportState extends State<vehicalreport> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        // toolbarHeight: screenHeight * 0.13,
        backgroundColor: Color(0xFF193358),
        title: Text(
          ' Vehical Reports',
          style: TextStyle(
              fontSize: 23, color: Colors.white, fontWeight: FontWeight.w700),
        ),
        leading: Icon(
          Icons.arrow_back_ios_rounded,
          color: Colors.white,
        ),
      ),
      body: ListView.builder(
        itemCount: 2,
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
                  child: Padding(
                    padding: EdgeInsets.all(screenWidth * 0.05),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Issue Update on:',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: const Color(0xFF888888)),
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Text(
                                  '25-May-2024',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF193358)),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: const Color(0xFFF3F8FF),
                                  child: Image.asset(
                                    'assets/images/pencil.png',
                                    width: 20,
                                    height: 20,
                                  ),
                                ),
                                SizedBox(
                                  width: screenWidth * 0.03,
                                ),
                                CircleAvatar(
                                  backgroundColor: Color(0xFFFFE9E9),
                                  child: Image.network(
                                    'assets/images/trash.png',
                                    width: 24,
                                    height: 24,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: screenHeight * 0.01),
                          child: Divider(
                              thickness: 1.0, color: Colors.grey.shade300),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Vehicle Name:',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: const Color(0xFF888888)),
                                ),
                                Text(
                                  'Volkswagen Virtus',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF1E1E1E)),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Vehicle No',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: const Color(0xFF888888)),
                                ),
                                Text(
                                  'TN 11-BR-4556',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: const Color(0xFF1E1E1E)),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: screenHeight * 0.01),
                          child: Divider(
                              thickness: 1.0, color: Colors.grey.shade300),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'From',
                                  style: TextStyle(
                                      fontSize: 15, color: Color(0xFF888888)),
                                ),
                                Text(
                                  'Ramanathapuram',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF1E1E1E)),
                                ),
                              ],
                            ),
                            ImageIcon(
                                NetworkImage('assets/images/Streamline.png')),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'To',
                                  style: TextStyle(
                                      fontSize: 15, color: Color(0xFF888888)),
                                ),
                                Text(
                                  'Kaniyakumari',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF1E1E1E)),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: screenHeight * 0.01),
                          child: Divider(
                              thickness: 1.0, color: Colors.grey.shade300),
                        ),
                        Row(
                          children: [
                            Icon(Icons.error_outline, color: Color(0xFFCF3434)),
                            SizedBox(width: screenWidth * 0.01),
                            const Text(
                              'Issue is',
                              style: TextStyle(
                                  color: Color(0xFFCF3434),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: screenHeight * 0.01,
                        ),
                        Row(
                          children: [
                            Text(
                              'Car was Break Down',
                              style: TextStyle(
                                  color: const Color(0xFF1E1E1E),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
