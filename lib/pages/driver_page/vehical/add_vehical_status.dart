import 'package:flutter/material.dart';
import '../../../services/cabs_api_service.dart';
import '../../../services/comFuncService.dart';
import '../../../widgets/custom_autocomplete_widget.dart';
import '../../../widgets/custom_text_field.dart';
import 'add_vehical_status_model.dart';
import 'vehical_number_model.dart';

class AddVehicalStatus extends StatefulWidget {
  @override
  State<AddVehicalStatus> createState() => _AddVehicalStatusState();
}

class _AddVehicalStatusState extends State<AddVehicalStatus> {
  final CabsApiService apiService = CabsApiService();
  final GlobalKey<FormState> addvehicalstatusForm = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    getcarList();
    print("test1");
  }

  var selectedStatusArr;
  String? selectedstatus;
  int? selectedStatusrId;

  // bool StatusPerson = false;
  List statusList = [
    {"name": "Break Down", "value": 1},
    {"name": "Tyre Puncher", "value": 2},
    {"name": "Dead Battery", "value": 3},
    {"name": "Overheating Engine", "value": 4},
    {"name": "Broken Fan Belt", "value": 5},
    {"name": "Headlight or taillight failure", "value": 6},
    {"name": "Electrical Issues", "value": 7},
    {"name": "Clutch Problems", "value": 8},
  ];

  List<CarDetails>? carnumberList = [];
  List<CarDetails>? carnumberListAll = [];

  var selectedcarnumberArr;
  String? selectedcarnumber;
  int? selectedcarnumberId;

  Future getcarList() async {
    await apiService.getBearerToken();
    var result = await apiService.getcarList();
    var response = carNumberModelFromJson(result);
    if (response.status.toString() == 'SUCCESS') {
      setState(() {
        carnumberList = response.list;
        carnumberListAll = carnumberList;
      });
    } else {
      setState(() {
        carnumberList = [];
        carnumberListAll = [];
      });
      showInSnackBar(context, response.message.toString());
    }
    setState(() {});
  }

  // Future savevehicalstatus() async {
  //   if (addvehicalstatusForm.currentState!.validate()) {
  //     Map<String, dynamic> postData = {
  //       "car_id": selectedcarnumberId,
  //       "vehicle_status": selectedstatus,
  //     };
  //     print('postData $postData');

  //     var result = await apiService.savevehicalstatus(postData);
  //     print('result $result');
  //     VehicalstatusaddModel response = vehicalstatusaddModelFromJson(result);

  //     if (response.status.toString() == 'SUCCESS') {
  //       showInSnackBar(context, response.message.toString());
  //       // Navigator.pop(context, {'type': 1});
  //       selectedcarnumber = "";
  //       selectedcarnumberId = 0;
  //       selectedstatus = "";
  //       selectedStatusrId = 0;
  //     } else {
  //       print(response.message.toString());
  //       showInSnackBar(context, response.message.toString());
  //     }
  //   } else {
  //     showInSnackBar(context, "Please fill all fields");
  //   }
  // }

  Future savevehicalstatus() async {
    await apiService.getBearerToken();
    if (addvehicalstatusForm.currentState!.validate()) {
      Map<String, dynamic> postData = {
        "car_id": selectedcarnumberId,
        "vehicle_status": selectedstatus,
      };
      print("updateexpenses $postData");
      var result = await apiService.savevehicalstatus(postData);

      VehicalstatusaddModel response = vehicalstatusaddModelFromJson(result);

      if (response.status.toString() == 'SUCCESS') {
        showInSnackBar(context, response.message.toString());
        selectedcarnumber = "";
        selectedcarnumberId = 0;
        selectedstatus = "";
        selectedStatusrId = 0;
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
          //   toolbarHeight: screenHeight * 0.13,
          backgroundColor: Color(0xFF193358),
          title: Text(
            'Back',
            style: TextStyle(
                fontSize: 23, color: Colors.white, fontWeight: FontWeight.w700),
          ),
          leading: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.white,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(screenWidth * 0.04),
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: addvehicalstatusForm,
            child: Column(
              children: [
                // CustomeTextField(
                //   hint: 'Enter Vehicle Name',
                //   width: screenWidth * 1,
                // ),
                // CustomeTextField(
                //   hint: 'Enter Vehicle Number',
                //   width: screenWidth * 1,
                // ),
                CustomAutoCompleteWidget(
                  width: MediaQuery.of(context).size.width / 1.1,
                  selectedItem: selectedcarnumberArr,
                  labelText: 'Vehicle Number',
                  labelField: (item) => item.vehicleNumber,
                  onChanged: (value) {
                    selectedcarnumber = value.vehicleNumber;
                    selectedcarnumberId = value.id;
                    print("car id $selectedcarnumberId");
                  },
                  valArr: carnumberList,
                ),
                CustomAutoCompleteWidget(
                  width: MediaQuery.of(context).size.width / 1.1,
                  selectedItem: selectedStatusArr,
                  labelText: 'Vehicle Problem',
                  labelField: (item) => item["name"],
                  onChanged: (value) {
                    setState(() {
                      selectedstatus = value["name"];
                      selectedStatusrId = value["value"];
                      print(selectedstatus);
                    });
                  },
                  valArr: statusList,
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.only(bottom: screenWidth * 0.04),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF193358),
                      minimumSize: Size(screenWidth, 54),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      savevehicalstatus();
                    },
                    child: Text(
                      'Submit',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
