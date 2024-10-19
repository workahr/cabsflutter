import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../constants/app_colors.dart';
import '../../../services/cabs_api_service.dart';
import '../../../services/comFuncService.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/rounded_icon_button_widget.dart';
import '../admin_sidemenu.dart';
import 'add_thirdparty_details.dart';

import 'thirdparty_delete_model.dart';
import 'thirdparty_list_model.dart';

class Third_party_List extends StatefulWidget {
  const Third_party_List({super.key});

  @override
  State<Third_party_List> createState() => _ThirdpartyListState();
}

class _ThirdpartyListState extends State<Third_party_List> {
  final CabsApiService apiService = CabsApiService();
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey<ScaffoldState>();

  List<ThirdpartyList>? thirdpartyList;
  List<ThirdpartyList>? thirdpartyListAll;
  bool isLoading = false;

  @override
  void initState() {
    getthirdpartyList();

    super.initState();
  }

  Future getthirdpartyList() async {
    setState(() {
      isLoading = true;
    });
    await apiService.getBearerToken();
    var result = await apiService.getthirdpartyList();
    var response = thirdpartyListDataFromJson(result);
    if (response.status.toString() == 'SUCCESS') {
      setState(() {
        thirdpartyList = response.list;
        thirdpartyListAll = thirdpartyList;
        isLoading = false;
      });
    } else {
      setState(() {
        thirdpartyList = [];
        thirdpartyListAll = [];
        isLoading = false;
      });
      showInSnackBar(context, response.message.toString());
    }
    setState(() {});
  }

  Future deleteThirdpartyById(id) async {
    final dialogBoxResult = await showAlertDialogInfo(
        context: context,
        title: 'Are you sure?',
        msg: 'You want to delete this data',
        status: 'danger',
        okBtn: false);
    if (dialogBoxResult == 'OK') {
      await apiService.getBearerToken();
      print('owner delete test $id');
      Map<String, dynamic> postData = {"id": id};
      var result = await apiService.deleteThirdpartyById(postData);
      ThirdpartyDeleteModel response = thirdpartyDeleteModelFromJson(result);

      if (response.status.toString() == 'SUCCESS') {
        showInSnackBar(context, response.message.toString());
        setState(() {
          getthirdpartyList();
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Third_party_List(),
          ),
        );
      } else {
        print(response.message.toString());
        showInSnackBar(context, response.message.toString());
      }
    }
  }

  addThirdparty() {
    Navigator.push(context,
            MaterialPageRoute(builder: (context) => Third_party_details()))
        .then((value) {
      if (value != null && value['add']) {
        getthirdpartyList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerKey,
      drawer: Admin_SideMenu(),
      appBar: AppBar(
        title: const Text(
          'Owner List',
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
                          hint: 'Search Owners',
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
                              thirdpartyList = thirdpartyListAll!
                                  .where((ThirdpartyList e) =>
                                      e.ownerName
                                          .toString()
                                          .toLowerCase()
                                          .contains(value) ||
                                      e.ownerMobile
                                          .toString()
                                          .toLowerCase()
                                          .contains(value))
                                  .toList();
                            } else {
                              thirdpartyList = thirdpartyListAll;
                            }
                            setState(() {});
                          },
                        ),
                        if (thirdpartyList != null)
                          ...thirdpartyList!.map(
                            (ThirdpartyList e) => Container(
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
                                          e.ownerName.toString(),
                                          style: const TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          e.ownerMobile.toString(),
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
                                      print(
                                          "party id test : " + e.id.toString()),
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Third_party_details(
                                                    thirdpartyId: e.id,
                                                  ))).then((value) {})
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete,
                                        color: Colors.red[400]),
                                    onPressed: () =>
                                        {deleteThirdpartyById(e.id)},
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
            title: 'Add Owner',
            buttonColor: AppColors.primary,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Third_party_details(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
