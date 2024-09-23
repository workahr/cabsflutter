import 'package:cabs/constants/app_assets.dart';
import 'package:flutter/material.dart';

class userMyBookings extends StatefulWidget {
  @override
  _userMyBookingsState createState() => _userMyBookingsState();
}

class _userMyBookingsState extends State<userMyBookings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Bookings",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF06234C),
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        children: [
          BookingCard(
            carName: 'Volkswagen Virtus',
            carType: 'Sedan, Manual',
            carNumber: 'TN11BR2133',
            fromLocation: 'Ramanathapuram',
            toLocation: 'Kaniyakumari',
            fromdateRange: '25-Aug-2024    ',
            todateRange: "02-Sept-2024",
            amount: '₹5000',
            status: 'Completed',
            carImage: AppAssets.bookcarVols,
          ),
          BookingCard(
            carName: 'Toyota Fortuner',
            carType: 'SUV, Manual',
            carNumber: 'TN11BR2133',
            fromLocation: 'Ramanathapuram',
            toLocation: 'Kaniyakumari',
            fromdateRange: '25-Aug-2024    ',
            todateRange: "02-Sept-2024",
            amount: '₹5000',
            status: 'Completed',
            carImage: AppAssets.bookcarToy,
          ),
          BookingCard(
            carName: 'Toyota Fortuner',
            carType: 'SUV, Manual',
            carNumber: 'TN11BR2133',
            fromLocation: 'Ramanathapuram',
            toLocation: 'Kaniyakumari',
            fromdateRange: '25-Aug-2024    ',
            todateRange: "02-Sept-2024",
            amount: '₹5000',
            status: 'Completed',
            carImage: AppAssets.bookcarToy,
          ),
        ],
      ),
    );
  }
}

class BookingCard extends StatelessWidget {
  final String carName;
  final String carType;
  final String carNumber;
  final String fromLocation;
  final String toLocation;
  final String fromdateRange;
  final String todateRange;
  final String amount;
  final String status;
  final String carImage;

  BookingCard({
    required this.carName,
    required this.carType,
    required this.carNumber,
    required this.fromLocation,
    required this.toLocation,
    required this.fromdateRange,
    required this.todateRange,
    required this.amount,
    required this.status,
    required this.carImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      //width: MediaQuery.of(context).size.width * 0.43,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      margin: EdgeInsets.all(10),
      child: Padding(
          padding: const EdgeInsets.all(10.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                Image.asset(carImage, width: 80, height: 60),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(carName,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    SizedBox(
                      height: 5,
                    ),
                    Text(carType, style: TextStyle(color: Colors.grey[600])),
                    SizedBox(
                      height: 5,
                    ),
                    Text(carNumber, style: TextStyle(color: Colors.grey[600])),
                  ],
                ),
                Spacer(),
                Text(status,
                    style: TextStyle(
                        color: Color(0xFF06234C), fontWeight: FontWeight.bold)),
              ],
            ),
            Divider(),
            SizedBox(
              height: 10,
            ),
            Row(children: [
              Text('From: '),
              SizedBox(
                width: 230,
              ),
              Text('To: '),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(
                '$fromLocation',
                style: TextStyle(
                    color: Color(0xFF06234C), fontWeight: FontWeight.bold),
              ),
              // SizedBox(
              //   width: 150,
              // ),
              Text(
                '$toLocation',
                style: TextStyle(
                    color: Color(0xFF06234C), fontWeight: FontWeight.bold),
              ),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('Price'),
              Text('Booking Date'),
              Text('Vehicle No.'),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('5,000'),
              Text('$fromdateRange'),
              Text('TN45AM1234'),
            ]),
            SizedBox(height: 20),
            Container(
              color: Color(0xFFF3F8FF),
              child: Column(
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total Amount:',
                            style: TextStyle(
                                color: Color(0xFF06234C),
                                fontWeight: FontWeight.bold)),
                        // SizedBox(
                        //   width: 170,
                        // ),
                        Text('$amount',
                            style: TextStyle(
                                color: Color(0xFF06234C),
                                fontWeight: FontWeight.bold)),
                      ]),
                  Row(children: [
                    Text(
                      'For 5 Days',
                    )
                  ]),
                ],
              ),
            )
          ])),
    );
  }
}
