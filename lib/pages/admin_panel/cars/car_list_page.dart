import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../widgets/rounded_icon_button_widget.dart';
import '../../widgets/custom_text_field.dart';
import '../../constants/app_colors.dart';
import '../../services/cabs_api_service.dart';
import '../../services/comFuncService.dart';
import 'car_list_model.dart';

class car_list extends StatefulWidget {
  @override
  _car_listState createState() => _car_listState();
}

class _car_listState extends State<car_list> {
  final CabsApiService apiService = CabsApiService();

  @override
  void initState() {
    getcarList();

    super.initState();
  }

  List<CarListData>? carList;
  List<CarListData>? carListtAll;

  Future getcarList() async {
    await apiService.getBearerToken();
    var result = await apiService.getcarList();
    var response = carListModelFromJson(result);
    if (response.status.toString() == 'SUCCESS') {
      setState(() {
        carList = response.list;
        carListtAll = carList;
      });
    } else {
      setState(() {
        carList = [];
        carListtAll = [];
      });
      showInSnackBar(context, response.message.toString());
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF06234C),
        title: Text(
          'Cars List',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomeTextField(
                    width: MediaQuery.of(context).size.width - 10.0,
                    hint: 'Search Buyers',
                    suffixIcon: Icon(
                      Icons.search,
                      color: AppColors.lightGrey3,
                      size: 20.0,
                    ),
                    labelColor: AppColors.primary,
                    // borderColor: AppColors.primary2,
                    focusBorderColor: AppColors.primary,
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    borderColor: AppColors.lightGrey3,
                    onChanged: (value) {
                      if (value != '') {
                        print('value $value');
                        value = value.toString().toLowerCase();
                        carList = carListtAll!
                            .where((CarListData e) =>
                                e.carId
                                    .toString()
                                    .toLowerCase()
                                    .contains(value) ||
                                e.carname
                                    .toString()
                                    .toLowerCase()
                                    .contains(value) ||
                                // e['item_price'].toString().contains(value) ||
                                e.cartype
                                    .toString()
                                    .toLowerCase()
                                    .contains(value))
                            .toList();
                      } else {
                        carList = carListtAll;
                      }
                      setState(() {});
                    },
                  ),
                  if (carList != null)
                    ...carList!.map(
                      (CarListData e) => Container(
                        padding: EdgeInsets.all(10.0),
                        margin: EdgeInsets.symmetric(vertical: 5.0),
                        decoration: BoxDecoration(
                          color: AppColors.light,
                          borderRadius: BorderRadius.circular(7.0),
                          border: Border.all(
                            color: AppColors.lightGrey,
                            width: 1.0,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                e.imageUrl.toString(),
                                fit: BoxFit.cover,
                                height: 150,
                                width: double.infinity,
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    e.cartype.toString(),
                                    style: TextStyle(
                                      color: Colors.blueAccent,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Vechical No.',
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
                                  e.carname.toString(),
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  e.vechicalno.toString(),
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
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
                                    Text(e.seats.toString()),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 15),
                          ],
                        ),
                      ),
                    ),
                  SizedBox(
                    height: 110.0,
                  ),
                ])),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          RoundedIconButtonWidget(
            title: 'Add Expense',
            buttonColor: AppColors.primary,
            onPressed: () {
              // addExpense();
            },
          ),
        ],
      ),
    );
  }
} 


// SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             ListView(
//               shrinkWrap: true,
//               physics: NeverScrollableScrollPhysics(),
//               children: [
//                 CarTile(
//                   carName: 'Volkswagen Virtus',
//                   carType: 'Sedan',
//                   vechicalno: '1',
//                   seats: 5,
//                   imageUrl: 'assets/images/car_vols.png',
//                 ),
//                 CarTile(
//                   carName: 'Toyota Fortuner',
//                   carType: 'SUV',
//                   vechicalno: '2',
//                   seats: 7,
//                   imageUrl: 'assets/images/car_toy.png',
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class CarTile extends StatelessWidget {
//   final String carName;
//   final String carType;
//   final String vechicalno;
//   final int seats;
//   final String imageUrl;

//   CarTile({
//     required this.carName,
//     required this.carType,
//     required this.vechicalno,
//     required this.seats,
//     required this.imageUrl,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 8),
//       padding: EdgeInsets.all(10),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.2),
//             spreadRadius: 2,
//             blurRadius: 5,
//             offset: Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.circular(10),
//             child: Image.asset(
//               imageUrl,
//               fit: BoxFit.cover,
//               height: 150,
//               width: double.infinity,
//             ),
//           ),
//           SizedBox(height: 10),
//           Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//             Text(
//               carType,
//               style: TextStyle(
//                 color: Colors.blueAccent,
//                 fontSize: 14,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             Text(
//               'Vechical No.',
//               style: TextStyle(
//                 fontSize: 16,
//                 color: Colors.black,
//               ),
//             ),
//           ]),
//           SizedBox(height: 5),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 carName,
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 5),
//               Text(
//                 ' $vechicalno',
//                 style: TextStyle(
//                   fontSize: 16,
//                   color: Colors.black,
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 10),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 children: [
//                   Icon(Icons.settings, size: 16),
//                   SizedBox(width: 4),
//                   Text('Manual'),
//                 ],
//               ),
//               Row(
//                 children: [
//                   Icon(Icons.local_gas_station, size: 16),
//                   SizedBox(width: 4),
//                   Text('Petrol'),
//                 ],
//               ),
//               Row(
//                 children: [
//                   Icon(Icons.person, size: 16),
//                   SizedBox(width: 4),
//                   Text('$seats Seats'),
//                 ],
//               ),
//             ],
//           ),
//           SizedBox(height: 15),
//         ],
//       ),
//     );
//   }
// }
