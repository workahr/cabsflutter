import 'package:cabs/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';

import 'package:google_places_flutter/google_places_flutter.dart';
import '../../widgets/custom_text_field.dart';
import 'latlong_model.dart';
import 'package:http/http.dart' as http;  // For making HTTP requests
import 'dart:convert'; 

 // Import for date formatting

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
   TextEditingController pickupDateCtrl = TextEditingController();
  TextEditingController pickupLocCtrl = TextEditingController();
  TextEditingController dropDateCtrl = TextEditingController();
  TextEditingController dropLocCtrl = TextEditingController();
  TextEditingController dobCtrl = TextEditingController();


  

  LatLong pickupLatLng = LatLong(latitude: 0.0, longitude: 0.0);
  LatLong dropLatLng = LatLong(latitude: 0.0, longitude: 0.0);

  String pickLocation = '';
  String dropLocation = '';
  DateTime selectedDate = DateTime.now();
  int selectedPersons = 1;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2021),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
final client = http.Client();
   static var headerData = {
    'Content-Type': 'application/json',
    'Accept': 'application/json ',
  };

   Future<List<Prediction>> fetchPlaces(String input) async {
    String apiKey = 'AIzaSyCV_BHnDXUjS0B5p4x4SxaqpHbcBoY-EHs'; // Replace with your actual API key
    //final url = 'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=$apiKey';

    try {
      final url = Uri.parse('https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=$apiKey');
      final response = await client.get(
        url,
        headers: headerData,
      );
     // final response = await http.get(Uri.parse(url, headerData));
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        var predictions = jsonData['predictions'] as List;
        return predictions.map((p) => Prediction.fromJson(p)).toList();
      } else {
        print('Failed to fetch place data: ${response.statusCode}');
        return [];
      }
    } catch (error) {
      print('Error fetching place data: $error');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              AppAssets.homeAppbarImg,
              //height: 300.0,
            ),
            const SizedBox(height: 10.0),
            // Header Section

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Where are you going?',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Enter the required details',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 10),
                  // Pick Location Field
                  // TextField(
                  //   decoration: InputDecoration(
                  //     prefixIcon: Icon(Icons.add_location_alt_outlined),
                  //     labelText: 'Pick location',
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(10),
                  //     ),
                  //   ),
                  //   onChanged: (value) {
                  //     setState(() {
                  //       pickLocation = value;
                  //     });
                  //   },
                  // ),

              //  TypeAheadField<Prediction>(
              //    suggestionsCallback: (pattern) async {
              //     return await fetchPlaces(pattern);
              //   },
              //       builder: (context, controller, focusNode) {
              //       return TextField(
              //         controller: pickupLocCtrl,
              //         focusNode: focusNode,
              //         autofocus: true,
              //         decoration: InputDecoration(
              //           border: OutlineInputBorder(),
              //           labelText: 'pick Location',
              //         )
              //       );
              //       },
        
              //       itemBuilder: (context, Prediction suggestion) {
              //         return ListTile(
              //           leading: Icon(Icons.location_on),
              //           title: Text(suggestion.description ?? ""),
              //         );
              //       },
              //      onSelected: (Prediction value) {  
              //          setState(() {
              //           pickupLocCtrl.text = value.description ?? '';
              //           pickupLatLng.latitude = double.parse(value.lat!);
              //           pickupLatLng.longitude = double.parse(value.lng!);
              //         });
              //       },
              //     ),


                  GooglePlaceAutoCompleteTextField(
                            textEditingController: pickupLocCtrl,
                            googleAPIKey: AppConstants.googleMapApiKey,
                            // inputDecoration: InputDecoration(),
                            boxDecoration: BoxDecoration(),
                            inputDecoration: InputDecoration(
                              labelText: 'Pickup Location',
                              iconColor: AppColors.primary,
                              floatingLabelStyle: TextStyle(
                                  fontSize: 14.0, color: AppColors.primary),
                              hintStyle: TextStyle(
                                  fontSize: 14.0, color: AppColors.lightGrey),
                              labelStyle: TextStyle(
                                  fontSize: 14.0, color: AppColors.lightGrey),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 5),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1.5, color: AppColors.lightGrey),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25))),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1.5, color: AppColors.lightGrey),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25))),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1.5, color: AppColors.primary),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25))),
                            ),
                            debounceTime: 800, // default 600 ms,
                            // countries: [
                            //   "in",
                            //   "uae",
                            //   // "fr"
                            // ], // optional by default null is set
                            isLatLngRequired:
                                true, // if you required coordinates from place detail
                            getPlaceDetailWithLatLng: (Prediction prediction) {
                              pickupLatLng.latitude =
                                  double.parse(prediction.lat!);
                              pickupLatLng.longitude =
                                  double.parse(prediction.lng!);
                              // this method will return latlng with place detail
                              print("placeDetails lng" +
                                  prediction.lng.toString());
                              print("placeDetails lat" +
                                  prediction.lat.toString());
                            }, // this callback is called when isLatLngRequired is true
                            itemClick: (Prediction prediction) {
                              pickupLocCtrl.text = prediction.description!;
                              pickupLocCtrl.selection =
                                  TextSelection.fromPosition(TextPosition(
                                      offset: prediction.description!.length));
                            },
                            itemBuilder:
                                (context, index, Prediction prediction) {
                              return Container(
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    Icon(Icons.location_on),
                                    SizedBox(
                                      width: 7,
                                    ),
                                    Expanded(
                                        child: Text(
                                            "${prediction.description ?? ""}"))
                                  ],
                                ),
                              );
                            },
                            // if you want to add seperator between list items
                            // seperatedBuilder: Divider(),
                            // want to show close icon
                            isCrossBtnShown: false,
                          ),


                  SizedBox(height: 10),
                  // Drop Location Field
                  // TextField(
                  //   decoration: InputDecoration(
                  //     prefixIcon: Icon(Icons.location_on_outlined),
                  //     labelText: 'Drop',
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(10),
                  //     ),
                  //   ),
                  //   onChanged: (value) {
                  //     setState(() {
                  //       dropLocation = value;
                  //     });
                  //   },
                  // ),


                  GooglePlaceAutoCompleteTextField(
                              textEditingController: dropLocCtrl,
                              googleAPIKey: AppConstants.googleMapApiKey,

                              // inputDecoration: InputDecoration(),
                              boxDecoration: BoxDecoration(),
                              inputDecoration: InputDecoration(
                                labelText: 'Drop',
                                iconColor: AppColors.primary,
                                floatingLabelStyle: TextStyle(
                                    fontSize: 14.0, color: AppColors.primary),
                                hintStyle: TextStyle(
                                    fontSize: 14.0, color: AppColors.lightGrey),
                                labelStyle: TextStyle(
                                    fontSize: 14.0, color: AppColors.lightGrey),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 5),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.5, color: AppColors.lightGrey),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(25))),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.5, color: AppColors.lightGrey),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(25))),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.5, color: AppColors.primary),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(25))),
                              ),
                              debounceTime: 800, // default 600 ms,
                              // countries: [
                              //   "in",
                              //   "uae",
                              //   // "fr"
                              // ], // optional by default null is set
                              isLatLngRequired:
                                  true, // if you required coordinates from place detail
                              getPlaceDetailWithLatLng:
                                  (Prediction prediction) {
                                dropLatLng.latitude =
                                    double.parse(prediction.lat!);
                                dropLatLng.longitude =
                                    double.parse(prediction.lng!);
                                // this method will return latlng with place detail
                                print("placeDetails lng" +
                                    prediction.lng.toString());
                                print("placeDetails lat" +
                                    prediction.lat.toString());
                              }, // this callback is called when isLatLngRequired is true
                              itemClick: (Prediction prediction) {
                                dropLocCtrl.text = prediction.description!;
                                dropLocCtrl.selection =
                                    TextSelection.fromPosition(TextPosition(
                                        offset:
                                            prediction.description!.length));
                              },
                              itemBuilder:
                                  (context, index, Prediction prediction) {
                                return Container(
                                  padding: EdgeInsets.all(10),
                                  child: Row(
                                    children: [
                                      Icon(Icons.location_on),
                                      SizedBox(
                                        width: 7,
                                      ),
                                      Expanded(
                                          child: Text(
                                              "${prediction.description ?? ""}"))
                                    ],
                                  ),
                                );
                              },
                              // if you want to add seperator between list items
                              // seperatedBuilder: Divider(),
                              // want to show close icon
                              isCrossBtnShown: false,
                            ),



                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        // Date Field
                        child: 
                        // TextField(
                        //   onTap: () => _selectDate(context),
                        //   readOnly: true,
                        //   decoration: InputDecoration(
                        //     prefixIcon: Icon(Icons.calendar_month_outlined),
                        //     labelText: DateFormat('dd MMM yyyy')
                        //         .format(selectedDate), // Format as dd MMM yyyy
                        //     border: OutlineInputBorder(
                        //       borderRadius: BorderRadius.circular(10),
                        //     ),
                        //   ),
                        // ),


                        CustomeTextField(
                          labelText: 'DD/MM/YYYY',
                          prefixIcon: const Icon(
                            Icons.date_range,
                          ),
                          control: dobCtrl,
                          width: MediaQuery.of(context).size.width - 10,
                          readOnly: true, // when true user cannot edit text

                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1948),
                              lastDate: DateTime(2100),
                              builder: (context, child) {
                                return Theme(
                                  
                                  data: Theme.of(context).copyWith(
                                    
                                    colorScheme: ColorScheme.light(
                                      primary: Theme.of(context)
                                          .primaryColor, // <-- SEE HERE
                                      onSurface: Theme.of(context)
                                          .primaryColor, // <-- SEE HERE
                                    ),
                                    textButtonTheme: TextButtonThemeData(
                                      style: TextButton.styleFrom(
                                         foregroundColor: AppColors.light,
                                          backgroundColor: AppColors.primary,
                                      ),
                                    ),
                                  ),
                                  child: child!,
                                );
                              },
                            );

                            if (pickedDate != null) {
                              String formattedDate =
                                  DateFormat('dd-MM-yyyy').format(pickedDate);

                              setState(() {
                                dobCtrl.text = formattedDate;
                              });
                            } else {
                              print("Date is not selected");
                            }
                          }),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        // Persons Dropdown
                        child: DropdownButtonFormField<int>(
                          value: selectedPersons,
                          items: List.generate(10, (index) => index + 1)
                              .map((int value) {
                            return DropdownMenuItem<int>(
                              value: value,
                              child: Text('$value Persons'),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              selectedPersons = newValue!;
                            });
                          },
                         decoration: InputDecoration(
      prefixIcon: Icon(Icons.person_outline),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey, width: 1.5), // Grey border when not focused
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey, width: 1.5), // Grey border when focused
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  ),
),
                    ],
                  ),
                  SizedBox(height: 20),
                  // Book Now Button
                  ElevatedButton(
                    onPressed: () {},
                    child: Center(
                      child: Text('Book Now'),
                    ),
                    style: ElevatedButton.styleFrom(
                      textStyle: TextStyle(color: Colors.white),
                      backgroundColor: Color(0xFF06234C),
                      padding: EdgeInsets.symmetric(vertical: 16),
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10), // Rounded corners
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Popular Cars',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  // Car List
                  ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      CarTile(
                        carName: 'Volkswagen Virtus',
                        carType: 'Sedan',
                        price: '₹1000/day',
                        seats: 5,
                        imageUrl: AppAssets.car1,
                      ),
                      CarTile(
                        carName: 'Toyota Fortuner',
                        carType: 'SUV',
                        price: '₹2000/day',
                        seats: 7,
                        imageUrl: AppAssets.car2,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// CarTile Widget for displaying car details
class CarTile extends StatelessWidget {
  final String carName;
  final String carType;
  final String price;
  final int seats;
  final String imageUrl;

  CarTile({
    required this.carName,
    required this.carType,
    required this.price,
    required this.seats,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Car Image
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              imageUrl,
              fit: BoxFit.cover,
              height: 150,
              width: double.infinity,
            ),
          ),
          SizedBox(height: 10),
          // Car Name and Type
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              carType,
              style: TextStyle(
                color: Colors.blueAccent,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Price',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ]),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                carName,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              // Price and Booking Button

              Text(
                ' $price',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          // Additional Details
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.settings, size: 16),
                  SizedBox(width: 4),
                  Text('Manual'),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.local_gas_station, size: 16),
                  SizedBox(width: 4),
                  Text('Petrol'),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.person, size: 16),
                  SizedBox(width: 4),
                  Text('$seats Seats'),
                ],
              ),
            ],
          ),
          SizedBox(height: 15),
          ElevatedButton(
            onPressed: () {},
            child: Center(
              child: Text('Book Now'),
            ),
            style: ElevatedButton.styleFrom(
              textStyle: TextStyle(color: Colors.white),
              backgroundColor: Color(0xFF06234C),
              padding: EdgeInsets.symmetric(vertical: 16),
              minimumSize: Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // Rounded corners
              ),
            ),
          ),
          // ElevatedButton(
          //   onPressed: () {},
          //   style: ElevatedButton.styleFrom(
          //     backgroundColor: Color(0xFF06234C),
          //     padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(8),
          //     ),
          //   ),
          //   child: Text(
          //     'Book Now',
          //     style: TextStyle(color: Colors.white),
          //   ),
          // ),
        ],
      ),
    );
  }
}







// import 'package:flutter/material.dart';

// class TCabsScreen extends StatefulWidget {
//   @override
//   _TCabsScreenState createState() => _TCabsScreenState();
// }

// class _TCabsScreenState extends State<TCabsScreen> {
//   String pickLocation = '';
//   String dropLocation = '';
//   DateTime selectedDate = DateTime.now();
//   int selectedPersons = 1;

//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: selectedDate,
//       firstDate: DateTime(2021),
//       lastDate: DateTime(2025),
//     );
//     if (picked != null && picked != selectedDate)
//       setState(() {
//         selectedDate = picked;
//       });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               height: 80,
//               width: MediaQuery.of(context).size.width,
//               decoration: BoxDecoration(
//                 color: Color(0xFF06234C),
//                 borderRadius: BorderRadius.vertical(
//                   bottom: Radius.circular(25),
//                 ),
//               ),
//               child: Center(
//                 child: Text(
//                   'T-CABS',
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold),
//                 ),
//               ),
//               // color: Color(0xFF06234C),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Where are you going?',
//                     style: TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 5,
//                   ),
//                   Text(
//                     'Enter the required details',
//                     style: TextStyle(
//                       fontSize: 15,
//                       color: Colors.grey,
//                       //  fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   TextField(
//                     decoration: InputDecoration(
//                       prefixIcon: Icon(
//                         Icons.location_on,
//                       ),
//                       labelText: 'Pick location',
//                       border: OutlineInputBorder(),
//                     ),
//                     onChanged: (value) {
//                       setState(() {
//                         pickLocation = value;
//                       });
//                     },
//                   ),
//                   SizedBox(height: 10),
//                   TextField(
//                     decoration: InputDecoration(
//                       prefixIcon: Icon(
//                         Icons.location_on,
//                       ),
//                       labelText: 'Drop',
//                       border: OutlineInputBorder(),
//                     ),
//                     onChanged: (value) {
//                       setState(() {
//                         dropLocation = value;
//                       });
//                     },
//                   ),
//                   SizedBox(height: 10),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: TextField(
//                           onTap: () => _selectDate(context),
//                           readOnly: true,
//                           decoration: InputDecoration(
//                             prefixIcon: Icon(Icons
//                                 .calendar_month_outlined), // Add prefix icon
//                             labelText:
//                                 '${selectedDate.toLocal()}'.split(' ')[0],
//                             border: OutlineInputBorder(),
//                           ),
//                         ),
//                       ),
//                       SizedBox(width: 10),
//                       Expanded(
//                         child: DropdownButtonFormField<int>(
//                           value: selectedPersons,
//                           items: List.generate(10, (index) => index + 1)
//                               .map((int value) {
//                             return DropdownMenuItem<int>(
//                               value: value,
//                               child: Text('$value Persons'),
//                             );
//                           }).toList(),
//                           onChanged: (newValue) {
//                             setState(() {
//                               selectedPersons = newValue!;
//                             });
//                           },
//                           decoration: InputDecoration(
//                             prefixIcon: Icon(Icons.person_outline),
//                             border: OutlineInputBorder(),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: () {},
//                     child: Center(
//                       child: Text('Book Now'),
//                     ),
//                     style: ElevatedButton.styleFrom(
//                       textStyle: TextStyle(color: Colors.white),
//                       backgroundColor: Color(0xFF06234C),
//                       padding: EdgeInsets.symmetric(vertical: 16),
//                       minimumSize: Size(double.infinity, 50),
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   Text(
//                     'Popular Cars',
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   ListView(
//                     shrinkWrap: true,
//                     physics: NeverScrollableScrollPhysics(),
//                     children: [
//                       CarTile(
//                         carName: 'Volkswagen Virtus',
//                         carType: 'Sedan',
//                         price: '₹1000/day',
//                         seats: 5,
//                         imageUrl: 'assets/virtus.png',
//                       ),
//                       CarTile(
//                         carName: 'Toyota Fortuner',
//                         carType: 'SUV',
//                         price: '₹2000/day',
//                         seats: 7,
//                         imageUrl: 'assets/fortuner.png',
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.book),
//             label: 'My Booking',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.add),
//             label: 'Add Cars',
//           ),
//         ],
//       ),
//     );
//   }
// }

// class CarTile extends StatelessWidget {
//   final String carName;
//   final String carType;
//   final String price;
//   final int seats;
//   final String imageUrl;

//   CarTile({
//     required this.carName,
//     required this.carType,
//     required this.price,
//     required this.seats,
//     required this.imageUrl,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: ListTile(
//         leading: Image.asset(
//           imageUrl,
//           width: 80,
//         ),
//         title: Text(carName),
//         subtitle: Text('$carType\n$price'),
//         trailing: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text('Seats: $seats'),
//           ],
//         ),
//         onTap: () {},
//       ),
//     );
//   }
// }