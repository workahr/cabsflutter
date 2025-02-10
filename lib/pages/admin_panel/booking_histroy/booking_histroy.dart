import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../services/cabs_api_service.dart';
import '../../../services/comFuncService.dart';
import 'booking_histroy_model.dart'; // Assuming you have this model

class BookingHistory extends StatefulWidget {
  @override
  _BookingHistoryState createState() => _BookingHistoryState();
}

class _BookingHistoryState extends State<BookingHistory> {
  final CabsApiService apiService = CabsApiService();
  bool isLoading = true;
  List<BookingSectionModel> bookingSections = [];

  @override
  void initState() {
    super.initState();
    getBookingList();
  }

  // API Call to fetch the booking list
  Future<void> getBookingList() async {
    await apiService.getBearerToken();
    var result = await apiService.getbookingList();
    var response = bookinghistroyListDataFromJson(result);

    if (response.status.toString() == 'SUCCESS') {
      setState(() {
        bookingSections = _groupBookingsByMonth(response.list);
        isLoading = false;
      });
    } else {
      setState(() {
        bookingSections = [];
        isLoading = false;
      });
      showInSnackBar(context, response.message.toString());
    }
  }

  // Helper function to group bookings by month
  List<BookingSectionModel> _groupBookingsByMonth(
      List<BookingHistroy> bookings) {
    Map<String, List<BookingItemModel>> monthMap = {};

    for (var booking in bookings) {
      String bookingMonth =
          _getMonthFromBooking(booking.fromDatetime.toString());
      if (!monthMap.containsKey(bookingMonth)) {
        monthMap[bookingMonth] = [];
      }
      monthMap[bookingMonth]!.add(
        BookingItemModel(
          status: booking.bookingStatus.toString().split('.').last,
          id: booking.id.toString(),
        ),
      );
    }

    return monthMap.entries
        .map((entry) =>
            BookingSectionModel(month: entry.key, bookings: entry.value))
        .toList();
  }

  String _getMonthFromBooking(String date) {
    DateTime parsedDate = DateTime.parse(date); // Parse the date string
    return DateFormat('MMMM yyyy')
        .format(parsedDate); // Return 'September 2024'
  }

  // Helper function to show snackbar with an error message
  void showInSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  // Color getStatusColor(BookingStatus status) {
//     switch (status) {
//       case BookingStatus.COMPLETED:
//         return Colors.lightGreen;
//       case BookingStatus.NEW:
//         return Colors.blue.shade100;
//       case BookingStatus.PENDING: // Add this if you have this status
//         return Colors.red.shade100;
//       default:
//         return Colors.grey.shade200;
//     }
//   }

  // Get color based on status
  Color getStatusColor(String status) {
    switch (status) {
      case 'COMPLETED':
        return Colors.teal;
      case 'PENDING':
        return Colors.amber;
      case 'CANCELED':
        return Colors.red;
      case 'NEW':
        return Colors.blue;
      default:
        return Colors.purple;
    }
  }

  // Build individual booking item
  Widget buildBookingItem(BookingItemModel booking) {
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
              'Booking ID #${booking.id}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: getStatusColor(booking.status),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                booking.status,
                style: TextStyle(
                  color: getStatusColor(booking.status).computeLuminance() > 0.5
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

  // Build section for each month
  Widget buildBookingSection(BookingSectionModel section) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            section.month,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Column(
          children: section.bookings
              .map((booking) => buildBookingItem(booking))
              .toList(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(
          child: Text(
            'Bookings History',
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Color(0xFF06234C),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView(
              children: bookingSections
                  .map((section) => buildBookingSection(section))
                  .toList(),
            ),
    );
  }
}

// Models for bookings
class BookingSectionModel {
  final String month;
  final List<BookingItemModel> bookings;

  BookingSectionModel({required this.month, required this.bookings});
}

class BookingItemModel {
  final String status;
  final String id;

  BookingItemModel({required this.status, required this.id});
}








// import 'package:flutter/material.dart';

// import '../../../services/cabs_api_service.dart';
// import '../../../services/comFuncService.dart';
// import 'booking_histroy_model.dart'; // Assuming you have this model

// class BookingHistory extends StatefulWidget {
//   @override
//   _BookingHistoryState createState() => _BookingHistoryState();
// }

// class _BookingHistoryState extends State<BookingHistory> {
//   final CabsApiService apiService = CabsApiService();
//   bool isLoading = true;
//   List<BookingHistroy>? bookingHistoryList = [];

//   @override
//   void initState() {
//     super.initState();
//     getBookingList();
//   }

//   // API Call to fetch the booking list
//   Future<void> getBookingList() async {
//     await apiService.getBearerToken();
//     var result = await apiService.getbookingList();
//     var response = bookinghistroyListDataFromJson(result);

//     if (response.status.toString() == 'SUCCESS') {
//       setState(() {
//         bookingHistoryList = response.list;
//         isLoading = false;
//       });
//     } else {
//       setState(() {
//         bookingHistoryList = [];
//         isLoading = false;
//       });
//       showInSnackBar(context, response.message.toString());
//     }
//   }

//   // Helper function to show snackbar with an error message
//   void showInSnackBar(BuildContext context, String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text(message)),
//     );
//   }

//   // Helper function to get the status color
//   Color getStatusColor(BookingStatus status) {
//     switch (status) {
//       case BookingStatus.COMPLETED:
//         return Colors.lightGreen;
//       case BookingStatus.NEW:
//         return Colors.blue.shade100;
//       case BookingStatus.PENDING: // Add this if you have this status
//         return Colors.red.shade100;
//       default:
//         return Colors.grey.shade200;
//     }
//   }

//   // Function to build individual booking item
//   Widget buildBookingItem(BookingHistroy booking) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(10.0),
//           border: Border.all(color: Colors.grey.shade300),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               'Booking ID #${booking.id}',
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//             ),
//             SizedBox(height: 8),
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
//               decoration: BoxDecoration(
//                 color: getStatusColor(
//                     booking.bookingStatus), // Pass the enum directly
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Text(
//                 booking.bookingStatus
//                     .toString()
//                     .split('.')
//                     .last, // Convert enum to string
//                 style: TextStyle(
//                   color:
//                       getStatusColor(booking.bookingStatus).computeLuminance() >
//                               0.5
//                           ? Colors.black
//                           : Colors.white,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: Center(
//             child: Text(
//           'Bookings History',
//           style: TextStyle(color: Colors.white),
//         )),
//         backgroundColor: Color(0xFF06234C),
//       ),
//       body: isLoading
//           ? Center(
//               child:
//                   CircularProgressIndicator()) // Show loader while data is being fetched
//           : bookingHistoryList == null || bookingHistoryList!.isEmpty
//               ? Center(child: Text("No booking history found"))
//               : ListView.builder(
//                   itemCount: bookingHistoryList!.length,
//                   itemBuilder: (context, index) {
//                     return buildBookingItem(bookingHistoryList![index]);
//                   },
//                 ),
//     );
//   }
// }
