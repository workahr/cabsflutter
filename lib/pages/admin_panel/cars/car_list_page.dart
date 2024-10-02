import 'package:cabs/pages/admin_panel/admin_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../constants/app_assets.dart';
import '../../../constants/app_constants.dart';
import '../../../widgets/rounded_icon_button_widget.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../constants/app_colors.dart';
import '../../../services/cabs_api_service.dart';
import '../../../services/comFuncService.dart';
import 'add_cars.dart';
import 'car_delete_model.dart';
import 'car_list_model.dart';

class car_list extends StatefulWidget {
  @override
  _car_listState createState() => _car_listState();
}

class _car_listState extends State<car_list> {
  final CabsApiService apiService = CabsApiService();
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    getcarList();

    super.initState();
  }

  bool isLoading = false;
  List<ListElement>? carList;
  List<ListElement>? carListtAll;

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

  Future deleteCarById(id) async {
    final dialogBoxResult = await showAlertDialogInfo(
        context: context,
        title: 'Are you sure?',
        msg: 'You want to delete this data',
        status: 'danger',
        okBtn: false);
    if (dialogBoxResult == 'OK') {
      await apiService.getBearerToken();
      Map<String, dynamic> postData = {"id": id};
      var result = await apiService.deleteCarById(postData);
      CarDeleteModel response = carDeleteModelFromJson(result);

      if (response.status.toString() == 'SUCCESS') {
        showInSnackBar(context, response.message.toString());
        setState(() {
          getcarList();
        });
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
        //  automaticallyImplyLeading: false,
        backgroundColor: Color(0xFF06234C),
        title: Text(
          'Cars List',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(
          color: Colors.white, // Change drawer icon color to white
        ),
      ),
      body: SingleChildScrollView(
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomeTextField(
                        width: MediaQuery.of(context).size.width - 10.0,
                        hint: 'Search Cars',
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
                                .where((ListElement e) =>
                                    e.id
                                        .toString()
                                        .toLowerCase()
                                        .contains(value) ||
                                    e.brand
                                        .toString()
                                        .toLowerCase()
                                        .contains(value) ||
                                    // e['item_price'].toString().contains(value) ||
                                    e.modal
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
                          (ListElement e) => Container(
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
                                if (e.imageUrl != null)
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      AppConstants.imgBaseUrl + e.imageUrl!,
                                      width: double.infinity,
                                      fit: BoxFit.contain,
                                      height: 60.0,
                                      // height: 100.0,
                                      errorBuilder: (BuildContext context,
                                          Object exception,
                                          StackTrace? stackTrace) {
                                        return Image.asset(AppAssets.logo,
                                            width: 50.0,
                                            height: 50.0,
                                            fit: BoxFit.cover);
                                      },
                                    ),
                                    //  Image.network(
                                    //   e.imageUrl.toString(),
                                    //   fit: BoxFit.cover,
                                    //   height: 150,
                                    //   width: double.infinity,
                                    // ),
                                  ),
                                SizedBox(height: 10),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        e.brand.toString(),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      e.modal.toString(),
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      e.vehicleNumber.toString(),
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                        Text(e.fuelType.toString()),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.person, size: 16),
                                        SizedBox(width: 4),
                                        Text(e.seatCapacity.toString()),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 15),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                        width: 120,
                                        height: 40,
                                        child: ElevatedButton.icon(
                                          onPressed: () {
                                            deleteCarById(e.id);
                                          },
                                          icon: Icon(
                                            Icons.delete_outline,
                                            color: Color(0xFF06234C),
                                          ),
                                          label: Text(
                                            "Delete",
                                            style: TextStyle(
                                              color: Color(0xFF06234C),
                                            ),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                color: Color(0xFF06234C),
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10.0,
                                                horizontal: 15.0),
                                          ),
                                        )),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    SizedBox(
                                        width: 110,
                                        height: 40,
                                        child: ElevatedButton.icon(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        AddCarScreen(
                                                          carId: e.id,
                                                        ))).then((value) {});
                                          },
                                          icon: Icon(Icons.edit_outlined),
                                          label: Text(
                                            "Edit",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            backgroundColor: Color(0xFF06234C),
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10.0,
                                                horizontal: 15.0),
                                          ),
                                        )),
                                  ],
                                ),
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
            title: 'Add Cars',
            buttonColor: AppColors.primary,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddCarScreen(),
                ),
              );
              AddCarScreen();
            },
          ),
        ],
      ),
    );
  }
}
