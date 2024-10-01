import 'package:flutter/material.dart';

class BookingHistory extends StatefulWidget {
  @override
  _BookingHistoryPageState createState() => _BookingHistoryPageState();
}

class _BookingHistoryPageState extends State<BookingHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(
            child: Text(
          'Bookings History',
          style: TextStyle(color: Colors.white),
        )),
        backgroundColor: Color(0xFF06234C),
      ),
      body: ListView(
        children: [
          BookingSection(
            month: 'September 2024',
            bookings: [
              BookingItem(status: 'Pending'),
              BookingItem(status: 'Completed'),
              BookingItem(status: 'Completed'),
              BookingItem(status: 'Completed'),
            ],
          ),
          BookingSection(
            month: 'August 2024',
            bookings: [
              BookingItem(status: 'Pending'),
              BookingItem(status: 'Canceled'),
              BookingItem(status: 'Completed'),
              BookingItem(status: 'Completed'),
            ],
          ),
        ],
      ),
    );
  }
}

class BookingSection extends StatelessWidget {
  final String month;
  final List<BookingItem> bookings;

  BookingSection({required this.month, required this.bookings});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            month,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        ...bookings,
      ],
    );
  }
}

class BookingItem extends StatelessWidget {
  final String status;

  BookingItem({required this.status});

  Color getStatusColor(String status) {
    switch (status) {
      case 'Completed':
        return Colors.green.shade100;
      case 'Pending':
        return Colors.blue.shade100;
      case 'Canceled':
        return Colors.red.shade100;
      default:
        return Colors.grey.shade200;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Booking ID #5232555',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: getStatusColor(status),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                status,
                style: TextStyle(
                  color: getStatusColor(status).computeLuminance() > 0.5
                      ? Colors.black
                      : Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
