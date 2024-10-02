import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../constants/app_colors.dart';
import '../../../services/cabs_api_service.dart';
import '../../../services/comFuncService.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/rounded_icon_button_widget.dart';
import '../admin_sidemenu.dart';
import 'add_drivers.dart';
import 'driver_delete_model.dart';
import 'driver_list_model.dart';

class DriverList extends StatefulWidget {
  const DriverList({Key? key}) : super(key: key);

  @override
  State<DriverList> createState() => _DriverListState();
}

class _DriverListState extends State<DriverList> {
  final CabsApiService apiService = CabsApiService();
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey<ScaffoldState>();

  List<DriversList>? driverList;
  List<DriversList>? driverListtAll;
  bool isLoading = false;

  @override
  void initState() {
    getdriverList();

    super.initState();
  }

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

  Future deleteDriverById(id) async {
    final dialogBoxResult = await showAlertDialogInfo(
        context: context,
        title: 'Are you sure?',
        msg: 'You want to delete this data',
        status: 'danger',
        okBtn: false);
    if (dialogBoxResult == 'OK') {
      await apiService.getBearerToken();
      print('driver delete test $id');
      Map<String, dynamic> postData = {"id": id};
      var result = await apiService.deleteDriverById(postData);
      DriverDeleteModel response = driverDeleteModelFromJson(result);

      if (response.status.toString() == 'SUCCESS') {
        showInSnackBar(context, response.message.toString());
        setState(() {
          getdriverList();
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DriverList(),
          ),
        );
      } else {
        print(response.message.toString());
        showInSnackBar(context, response.message.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerKey,
      drawer: Admin_SideMenu(),
      appBar: AppBar(
        title: const Text(
          'Driver List',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF06234C),
        //automaticallyImplyLeading: false,
        iconTheme: IconThemeData(
          color: Colors.white, // Change drawer icon color to white
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomeTextField(
                          width: MediaQuery.of(context).size.width - 10.0,
                          hint: 'Search Drivers',
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
                              driverList = driverListtAll!
                                  .where((DriversList e) =>
                                      e.username
                                          .toString()
                                          .toLowerCase()
                                          .contains(value) ||
                                      e.mobile
                                          .toString()
                                          .toLowerCase()
                                          .contains(value) ||
                                      // e['item_price'].toString().contains(value) ||
                                      e.vehicleId
                                          .toString()
                                          .toLowerCase()
                                          .contains(value))
                                  .toList();
                            } else {
                              driverList = driverListtAll;
                            }
                            setState(() {});
                          },
                        ),
                        if (driverList != null)
                          ...driverList!.map(
                            (DriversList e) => Container(
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
                              child: Row(
                                children: [
                                  const CircleAvatar(
                                    backgroundColor: Color(0xFFE6EEF8),
                                    child: Icon(Icons.person,
                                        color: Color(0xFF06234C)),
                                  ),
                                  const SizedBox(width: 16.0),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          e.username.toString(),
                                          style: const TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          "ID : " + e.vehicleId.toString(),
                                          style: const TextStyle(
                                              color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.edit,
                                        color: Colors.blue[700]),
                                    onPressed: () => {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => AddDrivers(
                                                    driverId: e.id,
                                                  ))).then((value) {})
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete,
                                        color: Colors.red[400]),
                                    onPressed: () => {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          String formattedDate =
                                              DateFormat('dd-MM-yyyy')
                                                  .format(e.licenseExpiry);

                                          return AlertDialog(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10.0)),
                                            ),
                                            content: SingleChildScrollView(
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                padding: EdgeInsets.all(2),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        CircleAvatar(
                                                          backgroundColor:
                                                              Color(0xFFE6EEF8),
                                                          child: Icon(
                                                              Icons
                                                                  .person_outline,
                                                              color: const Color(
                                                                  0xFF06234C)),
                                                        ),
                                                        SizedBox(width: 10),
                                                        Flexible(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                e.userId
                                                                    .toString(),
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 16,
                                                                ),
                                                              ),
                                                              Container(
                                                                height: 20,
                                                                width: double
                                                                    .infinity,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Color(
                                                                      0xFFF3F8FF),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8.0),
                                                                ),
                                                                child: Text(
                                                                  "ID: " +
                                                                      e.id.toString(),
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 20),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text("Vehicle ID:"),
                                                        Text("License No:"),
                                                      ],
                                                    ),
                                                    SizedBox(height: 10),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Flexible(
                                                          child: Text(
                                                            e.vehicleId
                                                                .toString(),
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                        Flexible(
                                                          child: Text(
                                                            e.licenseNumber
                                                                .toString(),
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 10),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                            "License Expiry Date:"),
                                                        Text("Mobile No:"),
                                                      ],
                                                    ),
                                                    SizedBox(height: 10),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          formattedDate,
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Text(
                                                          e.mobile.toString(),
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 10),
                                                    Text("Email ID:"),
                                                    SizedBox(height: 10),
                                                    Text(
                                                      e.email.toString(),
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    SizedBox(height: 10),
                                                    Text("Address: "),
                                                    SizedBox(height: 10),
                                                    Text(
                                                      e.address.toString(),
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(height: 10),
                                                    Center(
                                                      child: ElevatedButton(
                                                        onPressed: () {
                                                          deleteDriverById(
                                                              e.id);
                                                        },
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              const Color(
                                                                  0xFF06234C),
                                                          minimumSize: Size(
                                                              double.infinity,
                                                              50),
                                                        ),
                                                        child:
                                                            Text("Delete Now"),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    },
                                  )
                                ],
                              ),
                            ),
                          )
                      ])),
            ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          RoundedIconButtonWidget(
            title: 'Add Driver',
            buttonColor: AppColors.primary,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddDrivers(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
