import 'package:cabs/pages/admin_panel/bookings/car_list_model.dart';
import 'package:cabs/pages/admin_panel/bookings/driver_list_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constants/app_assets.dart';
import '../../../constants/app_constants.dart';
import '../../../services/cabs_api_service.dart';
import '../../../services/comFuncService.dart';
import '../../main_container.dart';
import '../add_new_booking/add_booking_model.dart';
import 'booking_getbyid_model.dart';
import 'booking_update_model.dart';
import 'calculate_bookingcharge_model.dart';

class BookingApprovel extends StatefulWidget {
  int? bookingId;

  BookingApprovel({super.key, this.bookingId});

  @override
  _BookingApprovelState createState() => _BookingApprovelState();
}

class _BookingApprovelState extends State<BookingApprovel> {
  final CabsApiService apiService = CabsApiService();
  String phoneNumber = "tel:1234567890";
  String selectedDriver = '';
  String selectedCar = '';
  String BookingId = '';
  String BookingDate = '';
  String Fromlocation = '';
  String Tolocation = '';
  String Fromdate = '';
  String Todate = '';

  @override
  void initState() {
    super.initState();
    refresh();
    getdriverList();
    getcarList();
    print('Driver id :' + widget.bookingId.toString());
  }

  refresh() async {
    if (widget.bookingId != null) {
      await getBookingById();
    }
  }

  void _makePhoneCall() async {
    if (await canLaunch(phoneNumber)) {
      await launch(phoneNumber);
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }

  bool isLoading = false;

  List<DriversList>? driverList;
  List<DriversList>? driverListtAll;
  List<ListElement>? carList;
  List<ListElement>? carListtAll;

  Future getdriverList() async {
    setState(() {
      isLoading = true;
    });
    await apiService.getBearerToken();
    var result = await apiService.getdriverList();
    var response = driverListDataFromJson(result);
    if (response.status.toString() == 'SUCCESS') {
      setState(() {
        driverList = response.list;
        driverListtAll = driverList;
        isLoading = false;
      });
    } else {
      setState(() {
        driverList = [];
        driverListtAll = [];
        isLoading = false;
      });
      showInSnackBar(context, response.message.toString());
    }
    setState(() {});
  }

  Future getcarList() async {
    await apiService.getBearerToken();
    var result = await apiService.getcarList();
    var response = carListDataFromJson(result);
    if (response.status.toString() == 'SUCCESS') {
      setState(() {
        carList = response.list;
        carListtAll = carList;
        isLoading = false;
      });
    } else {
      setState(() {
        carList = [];
        carListtAll = [];
        isLoading = false;
      });
      showInSnackBar(context, response.message.toString());
    }
    setState(() {});
  }

  BookingsDetails? bookingsDetails;

  Future getBookingById() async {
    await apiService.getBearerToken();
    var result = await apiService.getBookingById(widget.bookingId);
    BookingGetByIdModel response = bookingGetByIdModelFromJson(result);
    print(response);
    if (response.status.toString() == 'SUCCESS') {
      setState(() {
        bookingsDetails = response.list;
        BookingId = (bookingsDetails!.id ?? '').toString();
        // phoneNumber = (bookingsDetails!.id ?? '').toString(); //phone number
        Fromlocation = (bookingsDetails!.pickupLocation ?? '').toString();
        Tolocation = (bookingsDetails!.dropLocation ?? '').toString();
        DateTime parsedDate = DateFormat('yyyy-MM-dd')
            .parse(bookingsDetails!.createdDate.toIso8601String());
        BookingDate = DateFormat('dd-MM-yyyy').format(parsedDate);
        DateTime parsedDate1 = DateFormat('yyyy-MM-dd')
            .parse(bookingsDetails!.fromDatetime.toIso8601String());
        Fromdate = DateFormat('dd-MM-yyyy').format(parsedDate1);
        DateTime parsedDate2 = DateFormat('yyyy-MM-dd')
            .parse(bookingsDetails!.toDatetime.toIso8601String());
        Todate = DateFormat('dd-MM-yyyy').format(parsedDate2);

        // licenseExpiryDateController.text = formattedDate;
        // mobileNumberController.text = driverDetails!.mobile ?? '';
        // emailIdController.text = driverDetails!.email ?? '';
        // addressController.text = driverDetails!.address ?? '';
      });
    } else {
      showInSnackBar(context, "Data not found");
      //isLoaded = false;
    }
  }

  int? customerid;

  Future updatebookingbydriverid() async {
    await apiService.getBearerToken();
    final prefs = await SharedPreferences.getInstance();
    customerid = prefs.getInt('user_id');
    print("customer id" + customerid.toString());

    Map<String, dynamic> postData = {
      "id": (bookingsDetails!.id ?? '').toString(),
      "u_driver_id": selectedDriver,
      "u_car_id": selectedCar,
      "u_customer_id": customerid,
      "u_booking_status": "DRIVER ASSIGNED",
      "u_from_datetime": (bookingsDetails!.fromDatetime.toIso8601String()),
      "u_to_datetime": (bookingsDetails!.toDatetime.toIso8601String()),
      "u_pickup_location": (bookingsDetails!.pickupLocation ?? '').toString(),
      "u_drop_location": (bookingsDetails!.dropLocation ?? '').toString(),
      "u_booking_charges": calculatebookingcharge,
    };
    print("updateexpenses $postData");
    var result = await apiService.updatebookingbydriverid(postData);

    BookingupdateModel response = bookingupdateModelFromJson(result);

    if (response.status.toString() == 'SUCCESS') {
      showInSnackBar(context, response.message.toString());
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MainContainerAdmin(),
        ),
      );
    } else {
      print(response.message.toString());
      showInSnackBar(context, response.message.toString());
    }
  }

  CalculatebookingchargeModel? calculatechargeDetails;
  int calculatebookingcharge = 0;

  Future<void> getboookingchargeBykmdate() async {
    try {
      await apiService.getBearerToken();
      var result = await apiService.getboookingchargeBykmdate(
          20, Fromdate, Todate, selectedCar);

      if (result != null) {
        CalculatebookingchargeModel response =
            calculatebookingchargeModelFromJson(result);
        print(response);
        if (response.status.toString() == 'SUCCESS') {
          setState(() {
            calculatechargeDetails = response;
            print(calculatechargeDetails!.calculatedValue);
            calculatebookingcharge = calculatechargeDetails!.calculatedValue;
          });
        } else {
          showInSnackBar(context, "Data not found");
        }
      } else {
        showInSnackBar(context, "Failed to get results from API");
      }
    } catch (error) {
      print('Error fetching kilometers: $error');
      showInSnackBar(context, "An error occurred while fetching distance");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Center(
              child: Text(
            'Booking Approvel',
            style: TextStyle(color: Colors.white),
          )),
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          backgroundColor: Color(0xFF06234C),
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: Colors.grey.shade300),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            spreadRadius: 5,
                            blurRadius: 10,
                            offset: Offset(0, 3),
                          ),
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width,
                            height: 60,
                            decoration: BoxDecoration(
                                color: Color(0xFF06234C),
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10.0),
                                    topLeft: Radius.circular(10.0))),
                            child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Row(children: [
                                  // Text(
                                  //   'Booking ID #5232555',
                                  //   style: TextStyle(
                                  //       color: Colors.white,
                                  //       fontWeight: FontWeight.bold,
                                  //       fontSize: 15),
                                  // ),
                                  Text(
                                    'Booking ID ',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                  Text(
                                    '#$BookingId',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ]))),
                        SizedBox(height: 10),
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Customer Name:',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      'Booking date:',
                                      style: TextStyle(fontSize: 15),
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 1),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Vetrimaran',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF06234C),
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      BookingDate,
                                      // '15-Sept-2024',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF06234C),
                                        fontSize: 15,
                                      ),
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 30),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Mobile number:',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      Text(
                                        '+91 856325241',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF06234C),
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                  // Column(
                                  //     crossAxisAlignment:
                                  //         CrossAxisAlignment.start,
                                  //     children: [
                                  //       Text(
                                  //         'No. of Persons:',
                                  //         style: TextStyle(fontSize: 15),
                                  //         textAlign: TextAlign.end,
                                  //       ),
                                  //       Text(
                                  //         // e.,
                                  //         '5',
                                  //         style: TextStyle(
                                  //           fontWeight: FontWeight.bold,
                                  //           color: Color(0xFF06234C),
                                  //           fontSize: 15,
                                  //         ),
                                  //         textAlign: TextAlign.left,
                                  //       ),
                                  //     ])
                                ],
                              ),
                              SizedBox(height: 30),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'From Date :',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      Text(
                                        Fromdate,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF06234C),
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'To Date:',
                                          style: TextStyle(fontSize: 15),
                                          textAlign: TextAlign.end,
                                        ),
                                        Text(
                                          Todate,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF06234C),
                                            fontSize: 15,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ])
                                ],
                              ),
                              SizedBox(height: 30),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('From',
                                          style: TextStyle(fontSize: 15)),
                                      Text(
                                        Fromlocation,
                                        //'Ramanathapuram',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF06234C),
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  )),
                                  Icon(Icons.compare_arrows,
                                      color: Colors.black),
                                  Expanded(
                                      child: Column(
                                          // crossAxisAlignment:
                                          //     CrossAxisAlignment.start,
                                          children: [
                                        Text('To',
                                            style: TextStyle(fontSize: 15)),
                                        Text(Tolocation,
                                            //'Kaniyakumari',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF06234C),
                                              fontSize: 15,
                                            ),
                                            textAlign: TextAlign.end),
                                      ]))
                                ],
                              ),
                              SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 25),
                  Text(
                    'Available Drivers',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Divider(),
                  isLoading
                      ? Center(child: CircularProgressIndicator())
                      : Column(
                          children: [
                            if (driverList != null)
                              ...driverList!.map(
                                (DriversList e) => Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 16.0),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 36,
                                        height: 36,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xFFF3F8FF),
                                        ),
                                        child: Icon(
                                          Icons.person_2_outlined,
                                          color: Colors.grey.shade700,
                                          size: 20,
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      Expanded(
                                        child: Text(
                                          e.username,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Radio<String>(
                                        value: e.id.toString(),
                                        groupValue: selectedDriver,
                                        onChanged: (String? value) {
                                          setState(() {
                                            selectedDriver = value!;
                                            print(
                                                "selectedDriver  :$selectedDriver");
                                          });
                                        },
                                        activeColor: Color(0xFF0A3068),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                  SizedBox(height: 20),
                  Text(
                    'Available Cars',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Divider(),
                  isLoading
                      ? Center(child: CircularProgressIndicator())
                      : Column(children: [
                          if (carList != null)
                            ...carList!.map((ListElement e) => Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 16.0),
                                  child: Row(
                                    children: [
                                      Container(
                                          width: 50,
                                          child: e.imageUrl != null
                                              ? ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: Image.network(
                                                    AppConstants.imgBaseUrl +
                                                        e.imageUrl!,
                                                    width: double.infinity,
                                                    fit: BoxFit.contain,
                                                    height: 60.0,
                                                    // height: 100.0,
                                                    errorBuilder:
                                                        (BuildContext context,
                                                            Object exception,
                                                            StackTrace?
                                                                stackTrace) {
                                                      return Image.asset(
                                                          AppAssets.logo,
                                                          width: 30.0,
                                                          height: 50.0,
                                                          fit: BoxFit.cover);
                                                    },
                                                  ),
                                                )
                                              : Image.asset(AppAssets.logo,
                                                  width: 30.0,
                                                  height: 50.0,
                                                  fit: BoxFit.contain)),
                                      SizedBox(width: 18),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(children: [
                                              Text(
                                                e.brand,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                width: 15,
                                              ),
                                              Text(e.modal,
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold))
                                            ]),
                                            Text(
                                              'Sedan, Manual, 5 person',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Radio<String>(
                                        value: e.id.toString(),
                                        groupValue: selectedCar,
                                        onChanged: (String? value) {
                                          setState(() {
                                            selectedCar = value!;
                                            print("selectedCar  :$selectedCar");
                                            getboookingchargeBykmdate();
                                          });
                                        },
                                        activeColor: Color(0xFF0A3068),
                                      ),
                                    ],
                                  ),
                                ))
                        ]),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          height: 50,
                          width: 130,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              _makePhoneCall();
                            },
                            icon: Icon(
                              Icons.phone_outlined,
                              color: Colors.black,
                              size: 30,
                            ),
                            label: Text(
                              'Call',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            ),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              backgroundColor: Colors.white,
                              side: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                          )),
                      SizedBox(
                          height: 50,
                          width: 130,
                          child: ElevatedButton(
                            onPressed: () {
                              updatebookingbydriverid();
                            },
                            child: Text(
                              'Confirm',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF06234C),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          )),
                    ],
                  ),
                ]))));
  }
}












// import 'package:cabs/pages/admin_panel/bookings/car_list_model.dart';
// import 'package:cabs/pages/admin_panel/bookings/driver_list_model.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:url_launcher/url_launcher.dart';

// import '../../../constants/app_assets.dart';
// import '../../../constants/app_constants.dart';
// import '../../../services/cabs_api_service.dart';
// import '../../../services/comFuncService.dart';
// import '../../main_container.dart';
// import '../add_new_booking/add_booking_model.dart';
// import 'booking_getbyid_model.dart';

// class BookingApprovel extends StatefulWidget {
//   int? bookingId;

//   BookingApprovel({super.key, this.bookingId});

//   @override
//   _BookingApprovelState createState() => _BookingApprovelState();
// }

// class _BookingApprovelState extends State<BookingApprovel> {
//   final CabsApiService apiService = CabsApiService();
//   String phoneNumber = "tel:1234567890";
//   String selectedDriver = '';
//   String selectedCar = '';
//   String BookingId = '';
//   String BookingDate = '';
//   String Fromlocation = '';
//   String Tolocation = '';
//   String Fromdate = '';
//   String Todate = '';

//   @override
//   void initState() {
//     super.initState();
//     refresh();
//     getdriverList();
//     getcarList();
//     print('Driver id :' + widget.bookingId.toString());
//   }

//   refresh() async {
//     if (widget.bookingId != null) {
//       await getBookingById();
//     }
//   }

//   void _makePhoneCall() async {
//     if (await canLaunch(phoneNumber)) {
//       await launch(phoneNumber);
//     } else {
//       throw 'Could not launch $phoneNumber';
//     }
//   }

//   bool isLoading = false;

//   List<DriversList>? driverList;
//   List<DriversList>? driverListtAll;
//   List<ListElement>? carList;
//   List<ListElement>? carListtAll;

//   Future getdriverList() async {
//     setState(() {
//       isLoading = true;
//     });
//     await apiService.getBearerToken();
//     var result = await apiService.getdriverList();
//     var response = driverListDataFromJson(result);
//     if (response.status.toString() == 'SUCCESS') {
//       setState(() {
//         driverList = response.list;
//         driverListtAll = driverList;
//         isLoading = false;
//       });
//     } else {
//       setState(() {
//         driverList = [];
//         driverListtAll = [];
//         isLoading = false;
//       });
//       showInSnackBar(context, response.message.toString());
//     }
//     setState(() {});
//   }

//   Future getcarList() async {
//     await apiService.getBearerToken();
//     var result = await apiService.getcarList();
//     var response = carListDataFromJson(result);
//     if (response.status.toString() == 'SUCCESS') {
//       setState(() {
//         carList = response.list;
//         carListtAll = carList;
//         isLoading = false;
//       });
//     } else {
//       setState(() {
//         carList = [];
//         carListtAll = [];
//         isLoading = false;
//       });
//       showInSnackBar(context, response.message.toString());
//     }
//     setState(() {});
//   }

//   BookingsDetails? bookingsDetails;

//   Future getBookingById() async {
//     await apiService.getBearerToken();
//     var result = await apiService.getBookingById(widget.bookingId);
//     BookingGetByIdModel response = bookingGetByIdModelFromJson(result);
//     print(response);
//     if (response.status.toString() == 'SUCCESS') {
//       setState(() {
//         bookingsDetails = response.list;
//         BookingId = (bookingsDetails!.id ?? '').toString();
//         // phoneNumber = (bookingsDetails!.id ?? '').toString(); //phone number
//         Fromlocation = (bookingsDetails!.pickupLocation ?? '').toString();
//         Tolocation = (bookingsDetails!.dropLocation ?? '').toString();
//         DateTime parsedDate = DateFormat('yyyy-MM-dd')
//             .parse(bookingsDetails!.createdDate.toIso8601String());
//         BookingDate = DateFormat('dd-MM-yyyy').format(parsedDate);
//         DateTime parsedDate1 = DateFormat('yyyy-MM-dd')
//             .parse(bookingsDetails!.fromDatetime.toIso8601String());
//         Fromdate = DateFormat('dd-MM-yyyy').format(parsedDate1);
//         DateTime parsedDate2 = DateFormat('yyyy-MM-dd')
//             .parse(bookingsDetails!.toDatetime.toIso8601String());
//         Todate = DateFormat('dd-MM-yyyy').format(parsedDate2);

//         // licenseExpiryDateController.text = formattedDate;
//         // mobileNumberController.text = driverDetails!.mobile ?? '';
//         // emailIdController.text = driverDetails!.email ?? '';
//         // addressController.text = driverDetails!.address ?? '';
//       });
//     } else {
//       showInSnackBar(context, "Data not found");
//       //isLoaded = false;
//     }
//   }

//   int? customerid;

//   Future updatebookingbydriverid() async {
//     await apiService.getBearerToken();

//     final prefs = await SharedPreferences.getInstance();
//     customerid = prefs.getInt('user_id');
//     print("customer id" + customerid.toString());

//     DateTime parsedDate1 = DateFormat('yyyy-MM-dd')
//         .parse(bookingsDetails!.fromDatetime.toIso8601String());

//     DateTime parsedDate2 = DateFormat('yyyy-MM-dd')
//         .parse(bookingsDetails!.toDatetime.toIso8601String());

//     Map<String, dynamic> postData = {
//       "id": (bookingsDetails!.id ?? '').toString(),
//       "u_driver_id": selectedDriver,
//       "u_car_id": selectedCar,
//       "u_customer_id": customerid,
//       "u_booking_status": "DRIVER_ASSIGNED",
//       "u_from_datetime": DateFormat('dd-MM-yyyy').format(parsedDate1),
//       "u_to_datetime": DateFormat('dd-MM-yyyy').format(parsedDate2),
//       "u_pickup_location": (bookingsDetails!.pickupLocation ?? '').toString(),
//       "u_drop_location": (bookingsDetails!.dropLocation ?? '').toString(),
//     };

//     var result = await apiService.updatebookingbydriverid(postData);
//     BookingAddModel response = bookingAddModelFromJson(result);

//     if (response.status.toString() == 'SUCCESS') {
//       showInSnackBar(context, response.message.toString());
//       // Navigator.pop(context, {'add': true});
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => MainContainerAdmin(),
//         ),
//       );
//     } else {
//       print(response.message.toString());
//       showInSnackBar(context, response.message.toString());
//     }
//   }



  

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           title: Center(
//               child: Text(
//             'Booking Approvel',
//             style: TextStyle(color: Colors.white),
//           )),
//           iconTheme: IconThemeData(
//             color: Colors.white,
//           ),
//           backgroundColor: Color(0xFF06234C),
//         ),
//         body: SingleChildScrollView(
//             child: Padding(
//                 padding: const EdgeInsets.all(15.0),
//                 child: Column(children: [
//                   Container(
//                     decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(10.0),
//                         border: Border.all(color: Colors.grey.shade300),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey.withOpacity(0.4),
//                             spreadRadius: 5,
//                             blurRadius: 10,
//                             offset: Offset(0, 3),
//                           ),
//                         ]),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Container(
//                             width: MediaQuery.of(context).size.width,
//                             height: 60,
//                             decoration: BoxDecoration(
//                                 color: Color(0xFF06234C),
//                                 borderRadius: BorderRadius.only(
//                                     topRight: Radius.circular(10.0),
//                                     topLeft: Radius.circular(10.0))),
//                             child: Padding(
//                                 padding: const EdgeInsets.all(20.0),
//                                 child: Row(children: [
//                                   // Text(
//                                   //   'Booking ID #5232555',
//                                   //   style: TextStyle(
//                                   //       color: Colors.white,
//                                   //       fontWeight: FontWeight.bold,
//                                   //       fontSize: 15),
//                                   // ),
//                                   Text(
//                                     'Booking ID ',
//                                     style: TextStyle(
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 15),
//                                   ),
//                                   Text(
//                                     '#$BookingId',
//                                     style: TextStyle(
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 15),
//                                   ),
//                                 ]))),
//                         SizedBox(height: 10),
//                         Padding(
//                           padding: EdgeInsets.all(10.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Row(
//                                 children: [
//                                   Expanded(
//                                     child: Text(
//                                       'Customer Name:',
//                                       style: TextStyle(fontSize: 15),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     child: Text(
//                                       'Booking date:',
//                                       style: TextStyle(fontSize: 15),
//                                       textAlign: TextAlign.end,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(height: 1),
//                               Row(
//                                 children: [
//                                   Expanded(
//                                     child: Text(
//                                       'Vetrimaran',
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         color: Color(0xFF06234C),
//                                         fontSize: 15,
//                                       ),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     child: Text(
//                                       BookingDate,
//                                       // '15-Sept-2024',
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         color: Color(0xFF06234C),
//                                         fontSize: 15,
//                                       ),
//                                       textAlign: TextAlign.end,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(height: 30),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         'Mobile number:',
//                                         style: TextStyle(fontSize: 15),
//                                       ),
//                                       Text(
//                                         '+91 856325241',
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           color: Color(0xFF06234C),
//                                           fontSize: 15,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   // Column(
//                                   //     crossAxisAlignment:
//                                   //         CrossAxisAlignment.start,
//                                   //     children: [
//                                   //       Text(
//                                   //         'No. of Persons:',
//                                   //         style: TextStyle(fontSize: 15),
//                                   //         textAlign: TextAlign.end,
//                                   //       ),
//                                   //       Text(
//                                   //         // e.,
//                                   //         '5',
//                                   //         style: TextStyle(
//                                   //           fontWeight: FontWeight.bold,
//                                   //           color: Color(0xFF06234C),
//                                   //           fontSize: 15,
//                                   //         ),
//                                   //         textAlign: TextAlign.left,
//                                   //       ),
//                                   //     ])
//                                 ],
//                               ),
//                               SizedBox(height: 30),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         'From Date :',
//                                         style: TextStyle(fontSize: 15),
//                                       ),
//                                       Text(
//                                         Fromdate,
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           color: Color(0xFF06234C),
//                                           fontSize: 15,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           'To Date:',
//                                           style: TextStyle(fontSize: 15),
//                                           textAlign: TextAlign.end,
//                                         ),
//                                         Text(
//                                           Todate,
//                                           style: TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             color: Color(0xFF06234C),
//                                             fontSize: 15,
//                                           ),
//                                           textAlign: TextAlign.left,
//                                         ),
//                                       ])
//                                 ],
//                               ),
//                               SizedBox(height: 30),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Expanded(
//                                       child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text('From',
//                                           style: TextStyle(fontSize: 15)),
//                                       Text(
//                                         Fromlocation,
//                                         //'Ramanathapuram',
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           color: Color(0xFF06234C),
//                                           fontSize: 15,
//                                         ),
//                                       ),
//                                     ],
//                                   )),
//                                   Icon(Icons.compare_arrows,
//                                       color: Colors.black),
//                                   Expanded(
//                                       child: Column(
//                                           // crossAxisAlignment:
//                                           //     CrossAxisAlignment.start,
//                                           children: [
//                                         Text('To',
//                                             style: TextStyle(fontSize: 15)),
//                                         Text(Tolocation,
//                                             //'Kaniyakumari',
//                                             style: TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                               color: Color(0xFF06234C),
//                                               fontSize: 15,
//                                             ),
//                                             textAlign: TextAlign.end),
//                                       ]))
//                                 ],
//                               ),
//                               SizedBox(height: 10),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 25),
//                   Text(
//                     'Available Drivers',
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                   ),
//                   Divider(),
//                   isLoading
//                       ? Center(child: CircularProgressIndicator())
//                       : Column(
//                           children: [
//                             if (driverList != null)
//                               ...driverList!.map(
//                                 (DriversList e) => Container(
//                                   padding: EdgeInsets.symmetric(
//                                       vertical: 8.0, horizontal: 16.0),
//                                   child: Row(
//                                     children: [
//                                       Container(
//                                         width: 36,
//                                         height: 36,
//                                         decoration: BoxDecoration(
//                                           shape: BoxShape.circle,
//                                           color: Color(0xFFF3F8FF),
//                                         ),
//                                         child: Icon(
//                                           Icons.person_2_outlined,
//                                           color: Colors.grey.shade700,
//                                           size: 20,
//                                         ),
//                                       ),
//                                       SizedBox(width: 20),
//                                       Expanded(
//                                         child: Text(
//                                           e.username,
//                                           style: TextStyle(
//                                               fontSize: 16,
//                                               fontWeight: FontWeight.bold),
//                                         ),
//                                       ),
//                                       Radio<String>(
//                                         value: e.id.toString(),
//                                         groupValue: selectedDriver,
//                                         onChanged: (String? value) {
//                                           setState(() {
//                                             selectedDriver = value!;
//                                             print(
//                                                 "selectedDriver  :$selectedDriver");
//                                           });
//                                         },
//                                         activeColor: Color(0xFF0A3068),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                           ],
//                         ),
//                   SizedBox(height: 20),
//                   Text(
//                     'Available Cars',
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                   ),
//                   Divider(),
//                   isLoading
//                       ? Center(child: CircularProgressIndicator())
//                       : Column(children: [
//                           if (carList != null)
//                             ...carList!.map((ListElement e) => Container(
//                                   padding: EdgeInsets.symmetric(
//                                       vertical: 8.0, horizontal: 16.0),
//                                   child: Row(
//                                     children: [
//                                       Container(
//                                           width: 50,
//                                           child: e.imageUrl != null
//                                               ? ClipRRect(
//                                                   borderRadius:
//                                                       BorderRadius.circular(10),
//                                                   child: Image.network(
//                                                     AppConstants.imgBaseUrl +
//                                                         e.imageUrl!,
//                                                     width: double.infinity,
//                                                     fit: BoxFit.contain,
//                                                     height: 60.0,
//                                                     // height: 100.0,
//                                                     errorBuilder:
//                                                         (BuildContext context,
//                                                             Object exception,
//                                                             StackTrace?
//                                                                 stackTrace) {
//                                                       return Image.asset(
//                                                           AppAssets.logo,
//                                                           width: 30.0,
//                                                           height: 50.0,
//                                                           fit: BoxFit.cover);
//                                                     },
//                                                   ),
//                                                 )
//                                               : Image.asset(AppAssets.logo,
//                                                   width: 30.0,
//                                                   height: 50.0,
//                                                   fit: BoxFit.contain)),
//                                       SizedBox(width: 18),
//                                       Expanded(
//                                         child: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Row(children: [
//                                               Text(
//                                                 e.brand,
//                                                 style: TextStyle(
//                                                     fontSize: 18,
//                                                     fontWeight:
//                                                         FontWeight.bold),
//                                               ),
//                                               SizedBox(
//                                                 width: 15,
//                                               ),
//                                               Text(e.modal,
//                                                   style: TextStyle(
//                                                       fontSize: 18,
//                                                       fontWeight:
//                                                           FontWeight.bold))
//                                             ]),
//                                             Text(
//                                               'Sedan, Manual, 5 person',
//                                               style: TextStyle(
//                                                   color: Colors.black,
//                                                   fontSize: 16),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       Radio<String>(
//                                         value: e.id.toString(),
//                                         groupValue: selectedCar,
//                                         onChanged: (String? value) {
//                                           setState(() {
//                                             selectedCar = value!;
//                                             print("selectedCar  :$selectedCar");
//                                           });
//                                         },
//                                         activeColor: Color(0xFF0A3068),
//                                       ),
//                                     ],
//                                   ),
//                                 ))
//                         ]),
//                   SizedBox(height: 20),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       SizedBox(
//                           height: 50,
//                           width: 130,
//                           child: ElevatedButton.icon(
//                             onPressed: () {
//                               _makePhoneCall();
//                             },
//                             icon: Icon(
//                               Icons.phone_outlined,
//                               color: Colors.black,
//                               size: 30,
//                             ),
//                             label: Text(
//                               'Call',
//                               style:
//                                   TextStyle(fontSize: 20, color: Colors.black),
//                             ),
//                             style: ElevatedButton.styleFrom(
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               backgroundColor: Colors.white,
//                               side: BorderSide(
//                                 color: Colors.black,
//                               ),
//                             ),
//                           )),
//                       SizedBox(
//                           height: 50,
//                           width: 130,
//                           child: ElevatedButton(
//                             onPressed: () {
//                               updatebookingbydriverid();
//                             },
//                             child: Text(
//                               'Confirm',
//                               style:
//                                   TextStyle(color: Colors.white, fontSize: 20),
//                             ),
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Color(0xFF06234C),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                             ),
//                           )),
//                     ],
//                   ),
//                 ]))));
//   }
// }
