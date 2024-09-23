import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../../constants/app_colors.dart';
import '../../../services/cabs_api_service.dart';
import '../../../services/comFuncService.dart';
import '../../../widgets/custom_text_field.dart';
import 'add_drivers_model.dart';
import 'driver_edit_model.dart';
import 'driver_list_page.dart';
import 'driver_update_model.dart';

class AddDrivers extends StatefulWidget {
  int? driverId;

  AddDrivers({super.key, this.driverId});
  @override
  _AddDriverState createState() => _AddDriverState();
}

class _AddDriverState extends State<AddDrivers> {
  final _formKey = GlobalKey<FormState>();
  final CabsApiService apiService = CabsApiService();
  final GlobalKey<FormState> driverForm = GlobalKey<FormState>();

  TextEditingController userIdController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController fullnameController = TextEditingController();
  TextEditingController vehicleIdController = TextEditingController();
  TextEditingController licenseNumberController = TextEditingController();
  TextEditingController licenseExpiryDateController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController emailIdController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  Future saveDriver() async {
    if (driverForm.currentState!.validate()) {
      DateTime parsedDate =
          DateFormat('dd-MM-yyyy').parse(licenseExpiryDateController.text);

      // Format the date to yyyy-MM-dd
      String formattedDate = DateFormat('yyyy-MM-dd').format(parsedDate);
      Map<String, dynamic> postData = {
        "username": userNameController.text,
        "password": passwordController.text,
        "fullname": fullnameController.text,
        "vehicle_id": vehicleIdController.text,
        "license_number": licenseNumberController.text,
        "license_expiry": formattedDate,
        "mobile": mobileNumberController.text,
        "email": emailIdController.text,
        "address": addressController.text,
      };
      print('postData $postData');

      String url = 'v1/user_details/create-user_details';

      var result = await apiService.saveDriver(url, postData);
      print('result $result');
      DriverAddModel response = driverAddModelFromJson(result);

      if (response.status.toString() == 'SUCCESS') {
        showInSnackBar(context, response.message.toString());
        // Navigator.pop(context, {'type': 1});
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
    } else {
      showInSnackBar(context, "Please fill all fields");
    }
  }

  errValidateDate(String? value) {
    return (value) {
      if (value.isEmpty) {
        return 'License Expiry Date is required';
      }
      return null;
    };
  }

  errValidateusername(String? value) {
    return (value) {
      if (value.isEmpty) {
        return 'User Name is required';
      }
      return null;
    };
  }

  errValidatefullname(String? value) {
    return (value) {
      if (value.isEmpty) {
        return 'Full Name is required';
      }
      return null;
    };
  }

  errValidatepassword(String? value) {
    return (value) {
      if (value.isEmpty) {
        return 'Password is required';
      }
      return null;
    };
  }

  errValidatevehicleId(String? value) {
    return (value) {
      if (value.isEmpty) {
        return 'Vehicle Id is required';
      }
      return null;
    };
  }

  errValidatelicenseno(String? value) {
    return (value) {
      if (value.isEmpty) {
        return 'License No. is required';
      }
      return null;
    };
  }

  errValidateEmailId(String? value) {
    return (value) {
      if (value.isEmpty) {
        return 'Email Id is required';
      }
      return null;
    };
  }

  errValidateAddress(String? value) {
    return (value) {
      if (value.isEmpty) {
        return 'Address is required';
      }
      return null;
    };
  }

  errValidateMobileNo(String value) {
    return (value) {
      if (value.isEmpty) {
        return 'Mobile is required';
      } else if (value.length != 10) {
        return 'Mobile number should be 10 digits';
      }
      return null;
    };
  }

  Future updatedriver() async {
    await apiService.getBearerToken();
    if (driverForm.currentState!.validate()) {
      int userId =
          int.parse(userIdController.text.toString()); // Convert to int

      int vehicleId =
          int.parse(vehicleIdController.text.toString()); // Convert to int

      DateTime parsedDate =
          DateFormat('dd-MM-yyyy').parse(licenseExpiryDateController.text);

      // Format the date to yyyy-MM-dd
      String formattedDate = DateFormat('yyyy-MM-dd').format(parsedDate);

      Map<String, dynamic> postData = {
        "id": widget.driverId,
        "u_username": userNameController.text,
        "u_password": passwordController.text,
        "u_fullname": fullnameController.text,
        "u_mobile": mobileNumberController.text,
        "u_email": emailIdController.text,
        "u_user_id": userId,
        "u_vehicle_id": vehicleId,
        "u_license_number": licenseNumberController.text,
        "u_license_expiry": formattedDate,
        "u_address": addressController.text
      };
      print("driverupdate $postData");
      var result = await apiService.updatedriver(postData);

      DriverupdateModel response = driverupdateModelFromJson(result);

      if (response.status.toString() == 'SUCCESS') {
        showInSnackBar(context, response.message.toString());
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
    } else {
      showInSnackBar(context, "Please fill all fields");
    }
  }

  @override
  void initState() {
    super.initState();
    refresh();
    print('Driver id :' + widget.driverId.toString());
  }

  refresh() async {
    if (widget.driverId != null) {
      await getDriverById();
    }
  }

  DriverDetails? driverDetails;

  Future getDriverById() async {
    await apiService.getBearerToken();
    var result = await apiService.getDriverById(widget.driverId);
    DriverEditModel response = driverEditModelFromJson(result);
    print(response);
    if (response.status.toString() == 'SUCCESS') {
      setState(() {
        driverDetails = response.list;
        userIdController.text = (driverDetails!.userId ?? '').toString();
        fullnameController.text = (driverDetails!.fullname ?? '').toString();
        passwordController.text = (driverDetails!.password ?? '').toString();
        vehicleIdController.text = (driverDetails!.vehicleId ?? '').toString();
        licenseNumberController.text = driverDetails!.licenseNumber ?? '';
        userNameController.text = driverDetails!.username;

        DateTime parsedDate = DateFormat('yyyy-MM-dd')
            .parse(driverDetails!.licenseExpiry.toIso8601String());

        // Format the date to yyyy-MM-dd
        String formattedDate = DateFormat('dd-MM-yyyy').format(parsedDate);

        licenseExpiryDateController.text = formattedDate;
        mobileNumberController.text = driverDetails!.mobile ?? '';
        emailIdController.text = driverDetails!.email ?? '';
        addressController.text = driverDetails!.address ?? '';
      });
    } else {
      showInSnackBar(context, "Data not found");
      //isLoaded = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              widget.driverId == null ? "Add Drivers" : "Update Drivers",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Color(0xFF06234C)),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: driverForm,
              child: Column(
                children: [
                  CustomeTextField(
                    control: userNameController,
                    validator: errValidateusername(userNameController.text),
                    labelText: 'User Name',
                    width: MediaQuery.of(context).size.width - 10,
                  ),
                  SizedBox(height: 16),
                  CustomeTextField(
                    control: passwordController,
                    validator: errValidatepassword(passwordController.text),
                    labelText: 'Password',
                    width: MediaQuery.of(context).size.width - 10,
                  ),
                  SizedBox(height: 16),
                  CustomeTextField(
                    control: fullnameController,
                    validator: errValidatefullname(fullnameController.text),
                    labelText: 'Full Name',
                    width: MediaQuery.of(context).size.width - 10,
                  ),
                  SizedBox(height: 16),
                  CustomeTextField(
                    control: vehicleIdController,
                    validator: errValidatevehicleId(fullnameController.text),
                    labelText: 'Vehicle Id',
                    width: MediaQuery.of(context).size.width - 10,
                  ),
                  SizedBox(height: 16),
                  CustomeTextField(
                    control: licenseNumberController,
                    validator:
                        errValidatelicenseno(licenseNumberController.text),
                    labelText: 'License Number',
                    width: MediaQuery.of(context).size.width - 10,
                  ),
                  SizedBox(height: 16),
                  CustomeTextField(
                      labelText: 'License Expiry Date',
                      prefixIcon: const Icon(
                        Icons.date_range,
                      ),
                      control: licenseExpiryDateController,
                      validator:
                          errValidateDate(licenseExpiryDateController.text),
                      width: MediaQuery.of(context).size.width - 10,
                      readOnly: true, // when true user cannot edit text

                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1948),
                          lastDate: DateTime.now(),
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: ColorScheme.light(
                                  primary: AppColors.primary2,
                                  // onSurface: AppColors.light,
                                ),
                                textButtonTheme: TextButtonThemeData(
                                  style: TextButton.styleFrom(
                                    foregroundColor: AppColors.light,
                                    backgroundColor: AppColors.primary2,
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
                            licenseExpiryDateController.text = formattedDate;
                          });
                        } else {
                          showInSnackBar(context, "Date is required");
                        }
                      }),
                  SizedBox(height: 16),
                  CustomeTextField(
                    labelText: 'Mobile Number',
                    width: MediaQuery.of(context).size.width / 1.1,
                    control: mobileNumberController,
                    validator: errValidateMobileNo(mobileNumberController.text),
                    type: const TextInputType.numberWithOptions(),
                    inputFormaters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^-?(\d+)?\.?\d{0,11}'))
                    ],
                  ),
                  SizedBox(height: 16),
                  CustomeTextField(
                    control: emailIdController,
                    validator: errValidateEmailId(emailIdController.text),
                    labelText: 'Email ID',
                    width: MediaQuery.of(context).size.width - 10,
                  ),
                  SizedBox(height: 16),
                  CustomeTextField(
                    control: addressController,
                    validator: errValidateAddress(addressController.text),
                    labelText: 'Address',
                    width: MediaQuery.of(context).size.width - 10,
                    lines: 4,
                  ),
                  SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () {
                      print(widget.driverId);
                      widget.driverId == null ? saveDriver() : updatedriver();
                    },
                    child: Text(
                      widget.driverId == null ? 'Add Now' : 'Update Now',
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
                ],
              ),
            ),
          ),
        ));
  }
}
