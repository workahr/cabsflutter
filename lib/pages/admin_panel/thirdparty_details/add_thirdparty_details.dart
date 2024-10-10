// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../services/cabs_api_service.dart';

import '../../../services/comFuncService.dart';
import '../../../widgets/custom_text_field.dart';
import '../driver/driver_edit_model.dart';
import '../driver/driver_list_page.dart';
import 'add_thirdparty_model.dart';

import 'thirdparty_edit_model.dart';
import 'thirdparty_list_page.dart';
import 'thirdparty_update_model.dart';

class Third_party_details extends StatefulWidget {
  int? thirdpartyId;
  Third_party_details({super.key, this.thirdpartyId});

  @override
  State<Third_party_details> createState() => _Third_party_detailsState();
}

class _Third_party_detailsState extends State<Third_party_details> {
  final _formKey = GlobalKey<FormState>();
  final CabsApiService apiService = CabsApiService();
  final GlobalKey<FormState> thirdpartyForm = GlobalKey<FormState>();

  TextEditingController ownernameController = TextEditingController();
  TextEditingController ownermobileNumberController = TextEditingController();
  TextEditingController owneraddressController = TextEditingController();

  Future saveThirdparty() async {
    if (thirdpartyForm.currentState!.validate()) {
      Map<String, dynamic> postData = {
        "owner_name": ownernameController.text,
        "owner_mobile": ownermobileNumberController.text,
        "owner_address": owneraddressController.text,
      };
      print('postData $postData');

      var result = await apiService.saveThirdParty(postData);
      print('result $result');
      ThirdpartyAddmodel response = thirdpartyAddmodelFromJson(result);

      if (response.status.toString() == 'SUCCESS') {
        showInSnackBar(context, response.message.toString());
        // Navigator.pop(context, {'type': 1});
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
    } else {
      showInSnackBar(context, "Please fill all fields");
    }
  }

  @override
  void initState() {
    super.initState();
    refresh();
    print('ThirdpartyId :' + widget.thirdpartyId.toString());
  }

  refresh() async {
    if (widget.thirdpartyId != null) {
      await getThirdpartyById();
    }
  }

  ThirdpartyDetails? thirdpartyDetails;

  Future getThirdpartyById() async {
    await apiService.getBearerToken();

    var result = await apiService.getThirdpartyById(widget.thirdpartyId);
    ThirdpartyEditModel response = thirdpartyEditModelFromJson(result);
    print(response);
    if (response.status.toString() == 'SUCCESS') {
      setState(() {
        thirdpartyDetails = response.list;
        ownernameController.text =
            (thirdpartyDetails!.ownerName ?? '').toString();
        ownermobileNumberController.text = thirdpartyDetails!.ownerMobile ?? '';

        owneraddressController.text = thirdpartyDetails!.ownerAddress ?? '';
      });
    } else {
      showInSnackBar(context, "Data not found");
      //isLoaded = false;
    }
  }

  Future updatethirdparty() async {
    await apiService.getBearerToken();
    if (thirdpartyForm.currentState!.validate()) {
      Map<String, dynamic> postData = {
        "id": widget.thirdpartyId,
        "u_owner_name": ownernameController.text,
        "u_owner_mobile": ownermobileNumberController.text,
        "u_owner_address": owneraddressController.text,
      };
      print("thirdpartyupdate $postData");
      var result = await apiService.updatethirdparty(postData);

      ThirdpartyupdateModel response = thirdpartyupdateModelFromJson(result);

      if (response.status.toString() == 'SUCCESS') {
        showInSnackBar(context, response.message.toString());
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
    } else {
      showInSnackBar(context, "Please fill all fields");
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // toolbarHeight: screenHeight * 0.13,
        backgroundColor: Color(0xFF193358),
        title: Text(
          widget.thirdpartyId == null
              ? "Add Owner Details"
              : "Update Owner Details",
          // 'Third Party Details',
          style: TextStyle(
              fontSize: 23, color: Colors.white, fontWeight: FontWeight.w700),
        ),
        leading: Icon(
          Icons.arrow_back_ios_rounded,
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
            left: screenWidth * 0.015,
            right: screenWidth * 0.015,
            top: screenHeight * 0.015),
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: thirdpartyForm,
          child: Column(
            children: [
              CustomeTextField(
                control: ownernameController,
                // validator: errValidatefullname(ownernameController.text),
                labelText: 'Owner Name',
                width: screenWidth * 1,
              ),
              CustomeTextField(
                labelText: 'Owner Mobile Number',
                width: screenWidth * 1,
                control: ownermobileNumberController,
                type: const TextInputType.numberWithOptions(),
              ),
              CustomeTextField(
                control: owneraddressController,
                // validator: errValidateAddress(addressController.text),
                labelText: 'Owner Address',
                width: screenWidth * 1,
                lines: 4,
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              ElevatedButton(
                onPressed: () {
                  // print(widget.driverId);
                  widget.thirdpartyId == null
                      ? saveThirdparty()
                      : updatethirdparty();
                  // saveThirdparty();
                },
                child: Text('Submit'),
                style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(color: Colors.white),
                  backgroundColor: Color(0xFF06234C),
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
