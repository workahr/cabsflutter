import 'package:flutter/material.dart';

class Vechical_ReportsPage extends StatefulWidget {
  const Vechical_ReportsPage({super.key});

  @override
  State<Vechical_ReportsPage> createState() => _Vechical_ReportsPageState();
}

class _Vechical_ReportsPageState extends State<Vechical_ReportsPage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: screenHeight * 0.13,
        backgroundColor: Color(0xFF193358),
        title: Text(
          'Reports',
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
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: const Color(0xFFF3F8FF),
                                  child: Icon(Icons.person_2_outlined,
                                      color: const Color(0xFF193358)),
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Text(
                                  'Shiva Kumar',
                                  style: TextStyle(
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF1E1E1E)),
                                ),
                              ],
                            ),
                            CircleAvatar(
                              backgroundColor: const Color(0xFFF3F8FF),
                              child: Icon(Icons.phone_outlined,
                                  color: const Color(0xFF193358)),
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
                            Icon(Icons.compare_arrows, color: Colors.black),
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
                            const Icon(Icons.error_outline,
                                color: Color(0xFFCF3434)),
                            SizedBox(width: screenWidth * 0.01),
                            const Text(
                              'Important',
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
