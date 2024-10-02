import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constants/app_assets.dart';
import '../../../constants/app_constants.dart';
import '../../../services/cabs_api_service.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import '../../../services/comFuncService.dart';
import '../../../widgets/custom_dropdown_widget.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/outline_btn_widget.dart';
import '../bookings/car_list_model.dart';
import 'add_cars_model.dart';
import 'package:image_picker/image_picker.dart';

import 'car_edit_model.dart';
import 'car_list_page.dart';
import 'car_update_model.dart';

class AddCarScreen extends StatefulWidget {
  int? carId;
  AddCarScreen({super.key, this.carId});

  @override
  State<AddCarScreen> createState() => _AddCarScreenState();
}

class _AddCarScreenState extends State<AddCarScreen> {
  final CabsApiService apiService = CabsApiService();
  final GlobalKey<FormState> carsForm = GlobalKey<FormState>();

  final TextEditingController brandCtrl = TextEditingController();
  final TextEditingController modelCtrl = TextEditingController();
  final TextEditingController fuelTypeCtrl = TextEditingController();
  final TextEditingController seatCapacityCtrl = TextEditingController();
  final TextEditingController vehicleNumberCtrl = TextEditingController();

  // Uint8List data = Uint8List(0);

  @override
  void initState() {
    super.initState();

    refresh();
    print('car id :' + widget.carId.toString());
  }

  refresh() async {
    if (widget.carId != null) {
      await getCarById();
    }
  }

  Map<String, dynamic>? selectedWeight = {'label': 'No', 'value': '2'};
  List<Map<String, dynamic>>? weightList = [
    {'label': 'Yes', 'value': 1},
    {'label': 'No', 'value': 2},
  ];
  String? selectedSpecies = 'No';

  String? selectedBatch;
  int type = 0;

  CarDetails? carDetails;

  Future getCarById() async {
    //isLoaded = true;
    // try {
    await apiService.getBearerToken();
    var result = await apiService.getCarById(widget.carId);
    CarEditModel response = carEditModelFromJson(result);
    print(response);
    if (response.status.toString() == 'SUCCESS') {
      setState(() {
        carDetails = response.list;
        brandCtrl.text = carDetails!.brand ?? '';
        modelCtrl.text = carDetails!.modal ?? '';
        fuelTypeCtrl.text = carDetails!.fuelType ?? '';
        seatCapacityCtrl.text = (carDetails!.seatCapacity ?? '').toString();
        vehicleNumberCtrl.text = carDetails!.vehicleNumber ?? '';
        liveimgSrc = carDetails!.imageUrl ?? '';
        //  imageFile = carDetails!.imageUrl as XFile?;
      });
    } else {
      showInSnackBar(context, "Data not found");
      //isLoaded = false;
    }
  }

  Future saveCar() async {
    await apiService.getBearerToken();
    if (imageFile == null && widget.carId == null) {
      showInSnackBar(context, 'Car image is required');
      return;
    }

    if (carsForm.currentState!.validate()) {
      final prefs = await SharedPreferences.getInstance();

      await prefs.setString('brabd', brandCtrl.toString());
      await prefs.setString('modal', modelCtrl.toString());
      await prefs.setString('fuel_type', fuelTypeCtrl.toString());
      await prefs.setString('seat_capacity', seatCapacityCtrl.toString());
      await prefs.setString('vehicle_number', vehicleNumberCtrl.toString());

      Map<String, dynamic> postData = {
        "rental": selectedWeight.toString(),
        "rental_id": selectedWeight.toString(),
        "brand": brandCtrl.text,
        "modal": modelCtrl.text,
        "fuel_type": fuelTypeCtrl.text,
        "seat_capacity": seatCapacityCtrl.text,
        "vehicle_number": vehicleNumberCtrl.text
      };
      setState(() {
        // isLoading = true;
      });
      showSnackBar(context: context);
      // update-Car_management
      String url = 'v1/cars/create-cars';
      if (widget.carId != null) {
        // postData['id'] = widget.carId;
        postData = {
          "id": widget.carId,
          "u_brand": brandCtrl.text,
          "u_modal": modelCtrl.text,
          "u_fuel_type": fuelTypeCtrl.text,
          "u_seat_capacity": seatCapacityCtrl.text,
          "u_vehicle_number": vehicleNumberCtrl.text
        };
        url = 'v1/cars/update-cars';
      }
      var result = await apiService.saveCar(url, postData, imageFile);
      closeSnackBar(context: context);
      setState(() {
        // isLoading = false;
      });
      CarAddModel response = carAddModelFromJson(result);

      if (response.status.toString() == 'SUCCESS') {
        showInSnackBar(context, response.message.toString());
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => car_list(),
          ),
        );

        brandCtrl.text = '';
        modelCtrl.text = '';
        fuelTypeCtrl.text = '';
        seatCapacityCtrl.text = '';
        vehicleNumberCtrl.text = '';

        imageFile = null;
        imageSrc = null;
        liveimgSrc = null;
      } else {
        print(response.message.toString());
        showInSnackBar(context, response.message.toString());
      }
    }
  }

  // Future saveCar() async {
  //   if (carsForm.currentState!.validate()) {
  //     if (imageFile == null) {
  //       showInSnackBar(context, 'Car image is required');
  //       return;
  //     }

  //     Map<String, dynamic> postData = {
  //       //"user_id": selectedUserId,
  //       "brand": brandCtrl.text,
  //       "modal": modelCtrl.text,
  //       "fuel_type": fuelTypeCtrl.text,
  //       "seat_capacity": seatCapacityCtrl.text,
  //       "vehicle_number": vehicleNumberCtrl.text
  //     };
  //     print('postData $postData');

  //     String url = 'v1/cars/create-cars';

  //     var result = await apiService.saveCar(url, postData, imageFile);
  //     print('result $result');
  //     CarAddModel response = carAddModelFromJson(result);

  //     if (response.status.toString() == 'SUCCESS') {
  //       showInSnackBar(context, response.message.toString());
  //       // Navigator.pop(context, {'type': 1});
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => car_list(),
  //         ),
  //       );
  //     } else {
  //       print(response.message.toString());
  //       showInSnackBar(context, response.message.toString());
  //     }
  //   } else {
  //     showInSnackBar(context, "Please fill all fields");
  //   }
  // }

  // Future updateCar() async {
  //   await apiService.getBearerToken();
  //   if (imageFile == null) {
  //     showInSnackBar(context, 'Car image is required');
  //     return;
  //   }
  //   Map<String, dynamic> postData = {
  //     "id": widget.carId,
  //     "u_brand": brandCtrl.text,
  //     "u_modal": modelCtrl.text,
  //     "u_fuel_type": fuelTypeCtrl.text,
  //     "u_seat_capacity": seatCapacityCtrl.text,
  //     "u_vehicle_number": vehicleNumberCtrl.text
  //   };

  //   var result = await apiService.updatecar(postData, imageFile);
  //   print('result $result');
  //   CarupdateModel response = carupdateModelFromJson(result);

  //   if (response.status.toString() == 'SUCCESS') {
  //     showInSnackBar(context, response.message.toString());
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => car_list(),
  //       ),
  //     );
  //   } else {
  //     print(response.message.toString());
  //     showInSnackBar(context, response.message.toString());
  //   }
  // }

  errValidatebrand(String? value) {
    return (value) {
      if (value.isEmpty) {
        return 'Brand is required';
      }
      return null;
    };
  }

  errValidatemodel(String? value) {
    return (value) {
      if (value.isEmpty) {
        return 'Model is required';
      }
      return null;
    };
  }

  errValidatefueltype(String? value) {
    return (value) {
      if (value.isEmpty) {
        return 'Fuel Type is required';
      }
      return null;
    };
  }

  errValidateseat(String? value) {
    return (value) {
      if (value.isEmpty) {
        return 'Seat Capacity is required';
      }
      return null;
    };
  }

  errValidatevehiclenumber(String? value) {
    return (value) {
      if (value.isEmpty) {
        return 'vehicle number is required';
      }
      return null;
    };
  }

  XFile? imageFile;
  File? imageSrc;
  String? liveimgSrc;

  getImage(ImageSource source) async {
    try {
      Navigator.pop(context);
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage != null) {
        imageFile = pickedImage;
        imageSrc = File(pickedImage.path);
        getRecognizedText(pickedImage);
        setState(() {});
      }
    } catch (e) {
      setState(() {});
    }
  }

  void getRecognizedText(image) async {
    try {
      final inputImage = InputImage.fromFilePath(image.path);

      final textDetector = TextRecognizer();
      RecognizedText recognisedText =
          await textDetector.processImage(inputImage);
      final resVal = recognisedText.blocks.toList();
      List allDates = [];
      for (TextBlock block in resVal) {
        for (TextLine line in block.lines) {
          String recognizedLine = line.text;
          RegExp dateRegex = RegExp(r"\b\d{1,2}/\d{1,2}/\d{2,4}\b");
          Iterable<Match> matches = dateRegex.allMatches(recognizedLine);

          for (Match match in matches) {
            allDates.add(match.group(0));
          }
        }
      }

      await textDetector.close();

      print(allDates); // For example, print the dates
    } catch (e) {
      showInSnackBar(context, e.toString());
    }
  }

  showActionSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () async {
                  await getImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () async {
                  await getImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.close_rounded),
                title: const Text('Close'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              widget.carId == null ? "Add Cars" : "Update Cars",
              // "Add Cars",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Color(0xFF06234C)),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: carsForm,
            child: Column(
              children: [
                CustomeTextField(
                  control: brandCtrl,
                  validator: errValidatebrand(brandCtrl.text),
                  labelText: 'Brand',
                  width: MediaQuery.of(context).size.width - 10,
                ),
                const SizedBox(height: 16.0),
                CustomeTextField(
                  control: modelCtrl,
                  validator: errValidatemodel(modelCtrl.text),
                  labelText: 'Model',
                  width: MediaQuery.of(context).size.width - 10,
                ),
                const SizedBox(height: 16.0),
                CustomeTextField(
                  control: fuelTypeCtrl,
                  validator: errValidatefueltype(fuelTypeCtrl.text),
                  labelText: 'Fuel Type',
                  width: MediaQuery.of(context).size.width - 10,
                  // lines: 4,
                ),
                const SizedBox(height: 16.0),
                CustomeTextField(
                  control: seatCapacityCtrl,
                  validator: errValidateseat(seatCapacityCtrl.text),
                  labelText: 'Seat Capacity',
                  width: MediaQuery.of(context).size.width - 10,
                ),
                const SizedBox(height: 16.0),
                CustomeTextField(
                  control: vehicleNumberCtrl,
                  validator: errValidatevehiclenumber(vehicleNumberCtrl.text),
                  labelText: 'Vehicle Number',
                  width: MediaQuery.of(context).size.width - 10,
                ),
                CustomDropdownWidget(
                  labelText: 'Select weight range',
                  height: 50.0,
                  valArr: weightList,
                  itemAsString: (p0) => p0['label'],
                  selectedItem: selectedWeight,
                  onChanged: (value) {
                    print(value['label']); // Print only the label value
                    selectedWeight = value;
                    setState(() {});
                  },
                ),
                const SizedBox(height: 16.0),
                OutlineBtnWidget(
                    title: 'Upload Image of Car',
                    icon: Icons.add_circle,
                    width: MediaQuery.of(context).size.width - 10,
                    height: 50,
                    onTap: () {
                      type = 0;
                      showActionSheet(context);
                    }),
                SizedBox(height: 10.0),
                Center(
                  child: Stack(
                    children: [
                      liveimgSrc != "" && liveimgSrc != null && imageSrc == null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Container(
                                width: 160,
                                height: 160,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      AppConstants.imgBaseUrl +
                                          (liveimgSrc ?? ''),
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: liveimgSrc == null
                                    ? Image.asset(
                                        AppAssets.user,
                                        fit: BoxFit.fill,
                                      )
                                    : null,
                              ),
                            )
                          : imageSrc != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      16), // Adjust the radius as needed
                                  child: Container(
                                    width: 160,
                                    height: 160,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: FileImage(imageSrc!),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                )
                              : SizedBox(),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // widget.carId == null ?
                      saveCar();
                      // : updateCar();
                    },
                    child: Text(
                      widget.carId == null ? 'Add Now' : 'Update Now',
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
                ),
              ],
            ),
          ),
        )));
  }
}






// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../../../constants/app_assets.dart';
// import '../../../constants/app_constants.dart';
// import '../../../services/cabs_api_service.dart';
// import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
// import '../../../services/comFuncService.dart';
// import '../../../widgets/custom_text_field.dart';
// import '../../../widgets/outline_btn_widget.dart';
// import 'add_cars_model.dart';
// import 'package:image_picker/image_picker.dart';

// import 'car_edit_model.dart';
// import 'car_list_page.dart';
// import 'car_update_model.dart';

// class AddCarScreen extends StatefulWidget {
//   int? carId;
//   AddCarScreen({super.key, this.carId});

//   @override
//   State<AddCarScreen> createState() => _AddCarScreenState();
// }

// class _AddCarScreenState extends State<AddCarScreen> {
//   final CabsApiService apiService = CabsApiService();
//   final GlobalKey<FormState> carsForm = GlobalKey<FormState>();

//   final TextEditingController brandCtrl = TextEditingController();
//   final TextEditingController modelCtrl = TextEditingController();
//   final TextEditingController fuelTypeCtrl = TextEditingController();
//   final TextEditingController seatCapacityCtrl = TextEditingController();
//   final TextEditingController vehicleNumberCtrl = TextEditingController();

//   // Uint8List data = Uint8List(0);

//   @override
//   void initState() {
//     super.initState();
//     refresh();
//     print('car id :' + widget.carId.toString());
//   }

//   refresh() async {
//     if (widget.carId != null) {
//       await getCarById();
//     }
//   }

//   String? selectedBatch;
//   int type = 0; // 0- car tag image, 1- car weight image

//   CarDetails? carDetails;

//   Future getCarById() async {
//     //isLoaded = true;
//     // try {
//     await apiService.getBearerToken();
//     var result = await apiService.getCarById(widget.carId);
//     CarEditModel response = carEditModelFromJson(result);
//     print(response);
//     if (response.status.toString() == 'SUCCESS') {
//       setState(() {
//         carDetails = response.list;
//         brandCtrl.text = carDetails!.brand ?? '';
//         modelCtrl.text = carDetails!.modal ?? '';
//         fuelTypeCtrl.text = carDetails!.fuelType ?? '';
//         seatCapacityCtrl.text = (carDetails!.seatCapacity ?? '').toString();
//         vehicleNumberCtrl.text = carDetails!.vehicleNumber ?? '';
//         liveimgSrc = carDetails!.imageUrl ?? '';
//         //  imageFile = carDetails!.imageUrl as XFile?;
//       });
//     } else {
//       showInSnackBar(context, "Data not found");
//       //isLoaded = false;
//     }
//   }

//   Future saveCar() async {
//     await apiService.getBearerToken();
//     if (imageFile == null && widget.carId == null) {
//       showInSnackBar(context, 'Car image is required');
//       return;
//     }

//     if (carsForm.currentState!.validate()) {
//       final prefs = await SharedPreferences.getInstance();

//       await prefs.setString('brabd', brandCtrl.toString());
//       await prefs.setString('modal', modelCtrl.toString());
//       await prefs.setString('fuel_type', fuelTypeCtrl.toString());
//       await prefs.setString('seat_capacity', seatCapacityCtrl.toString());
//       await prefs.setString('vehicle_number', vehicleNumberCtrl.toString());

//       Map<String, dynamic> postData = {
//         //"user_id": selectedUserId,
//         "brand": brandCtrl.text,
//         "modal": modelCtrl.text,
//         "fuel_type": fuelTypeCtrl.text,
//         "seat_capacity": seatCapacityCtrl.text,
//         "vehicle_number": vehicleNumberCtrl.text
//       };
//       setState(() {
//         // isLoading = true;
//       });
//       showSnackBar(context: context);
//       // update-Car_management
//       String url = 'v1/cars/create-cars';
//       if (widget.carId != null) {
//         // postData['id'] = widget.carId;
//         postData = {
//           "id": widget.carId,
//           "u_brand": brandCtrl.text,
//           "u_modal": modelCtrl.text,
//           "u_fuel_type": fuelTypeCtrl.text,
//           "u_seat_capacity": seatCapacityCtrl.text,
//           "u_vehicle_number": vehicleNumberCtrl.text
//         };
//         url = 'v1/cars/update-cars';
//       }
//       var result = await apiService.saveCar(url, postData, imageFile);
//       closeSnackBar(context: context);
//       setState(() {
//         // isLoading = false;
//       });
//       CarAddModel response = carAddModelFromJson(result);

//       if (response.status.toString() == 'SUCCESS') {
//         showInSnackBar(context, response.message.toString());
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => car_list(),
//           ),
//         );

//         brandCtrl.text = '';
//         modelCtrl.text = '';
//         fuelTypeCtrl.text = '';
//         seatCapacityCtrl.text = '';
//         vehicleNumberCtrl.text = '';

//         imageFile = null;
//         imageSrc = null;
//         liveimgSrc = null;
//       } else {
//         print(response.message.toString());
//         showInSnackBar(context, response.message.toString());
//       }
//     }
//   }

//   // Future saveCar() async {
//   //   if (carsForm.currentState!.validate()) {
//   //     if (imageFile == null) {
//   //       showInSnackBar(context, 'Car image is required');
//   //       return;
//   //     }

//   //     Map<String, dynamic> postData = {
//   //       //"user_id": selectedUserId,
//   //       "brand": brandCtrl.text,
//   //       "modal": modelCtrl.text,
//   //       "fuel_type": fuelTypeCtrl.text,
//   //       "seat_capacity": seatCapacityCtrl.text,
//   //       "vehicle_number": vehicleNumberCtrl.text
//   //     };
//   //     print('postData $postData');

//   //     String url = 'v1/cars/create-cars';

//   //     var result = await apiService.saveCar(url, postData, imageFile);
//   //     print('result $result');
//   //     CarAddModel response = carAddModelFromJson(result);

//   //     if (response.status.toString() == 'SUCCESS') {
//   //       showInSnackBar(context, response.message.toString());
//   //       // Navigator.pop(context, {'type': 1});
//   //       Navigator.push(
//   //         context,
//   //         MaterialPageRoute(
//   //           builder: (context) => car_list(),
//   //         ),
//   //       );
//   //     } else {
//   //       print(response.message.toString());
//   //       showInSnackBar(context, response.message.toString());
//   //     }
//   //   } else {
//   //     showInSnackBar(context, "Please fill all fields");
//   //   }
//   // }

//   // Future updateCar() async {
//   //   await apiService.getBearerToken();
//   //   if (imageFile == null) {
//   //     showInSnackBar(context, 'Car image is required');
//   //     return;
//   //   }
//   //   Map<String, dynamic> postData = {
//   //     "id": widget.carId,
//   //     "u_brand": brandCtrl.text,
//   //     "u_modal": modelCtrl.text,
//   //     "u_fuel_type": fuelTypeCtrl.text,
//   //     "u_seat_capacity": seatCapacityCtrl.text,
//   //     "u_vehicle_number": vehicleNumberCtrl.text
//   //   };

//   //   var result = await apiService.updatecar(postData, imageFile);
//   //   print('result $result');
//   //   CarupdateModel response = carupdateModelFromJson(result);

//   //   if (response.status.toString() == 'SUCCESS') {
//   //     showInSnackBar(context, response.message.toString());
//   //     Navigator.push(
//   //       context,
//   //       MaterialPageRoute(
//   //         builder: (context) => car_list(),
//   //       ),
//   //     );
//   //   } else {
//   //     print(response.message.toString());
//   //     showInSnackBar(context, response.message.toString());
//   //   }
//   // }

//   errValidatebrand(String? value) {
//     return (value) {
//       if (value.isEmpty) {
//         return 'Brand is required';
//       }
//       return null;
//     };
//   }

//   errValidatemodel(String? value) {
//     return (value) {
//       if (value.isEmpty) {
//         return 'Model is required';
//       }
//       return null;
//     };
//   }

//   errValidatefueltype(String? value) {
//     return (value) {
//       if (value.isEmpty) {
//         return 'Fuel Type is required';
//       }
//       return null;
//     };
//   }

//   errValidateseat(String? value) {
//     return (value) {
//       if (value.isEmpty) {
//         return 'Seat Capacity is required';
//       }
//       return null;
//     };
//   }

//   errValidatevehiclenumber(String? value) {
//     return (value) {
//       if (value.isEmpty) {
//         return 'vehicle number is required';
//       }
//       return null;
//     };
//   }

//   XFile? imageFile;
//   File? imageSrc;
//   String? liveimgSrc;

//   getImage(ImageSource source) async {
//     try {
//       Navigator.pop(context);
//       final pickedImage = await ImagePicker().pickImage(source: source);
//       if (pickedImage != null) {
//         imageFile = pickedImage;
//         imageSrc = File(pickedImage.path);
//         getRecognizedText(pickedImage);
//         setState(() {});
//       }
//     } catch (e) {
//       setState(() {});
//     }
//   }

//   void getRecognizedText(image) async {
//     try {
//       final inputImage = InputImage.fromFilePath(image.path);

//       final textDetector = TextRecognizer();
//       RecognizedText recognisedText =
//           await textDetector.processImage(inputImage);
//       final resVal = recognisedText.blocks.toList();
//       List allDates = [];
//       for (TextBlock block in resVal) {
//         for (TextLine line in block.lines) {
//           String recognizedLine = line.text;
//           RegExp dateRegex = RegExp(r"\b\d{1,2}/\d{1,2}/\d{2,4}\b");
//           Iterable<Match> matches = dateRegex.allMatches(recognizedLine);

//           for (Match match in matches) {
//             allDates.add(match.group(0));
//           }
//         }
//       }

//       await textDetector.close();

//       print(allDates); // For example, print the dates
//     } catch (e) {
//       showInSnackBar(context, e.toString());
//     }
//   }

//   showActionSheet(BuildContext context) {
//     showModalBottomSheet(
//         context: context,
//         builder: (BuildContext context) {
//           return Column(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               ListTile(
//                 leading: const Icon(Icons.photo_library),
//                 title: const Text('Gallery'),
//                 onTap: () async {
//                   await getImage(ImageSource.gallery);
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(Icons.camera_alt),
//                 title: const Text('Camera'),
//                 onTap: () async {
//                   await getImage(ImageSource.camera);
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(Icons.close_rounded),
//                 title: const Text('Close'),
//                 onTap: () {
//                   Navigator.pop(context);
//                 },
//               ),
//             ],
//           );
//         });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//             automaticallyImplyLeading: false,
//             title: Text(
//               widget.carId == null ? "Add Cars" : "Update Cars",
//               // "Add Cars",
//               style: TextStyle(color: Colors.white),
//             ),
//             backgroundColor: Color(0xFF06234C)),
//         body: SingleChildScrollView(
//             child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Form(
//             autovalidateMode: AutovalidateMode.onUserInteraction,
//             key: carsForm,
//             child: Column(
//               children: [
//                 CustomeTextField(
//                   control: brandCtrl,
//                   validator: errValidatebrand(brandCtrl.text),
//                   labelText: 'Brand',
//                   width: MediaQuery.of(context).size.width - 10,
//                 ),
//                 const SizedBox(height: 16.0),
//                 CustomeTextField(
//                   control: modelCtrl,
//                   validator: errValidatemodel(modelCtrl.text),
//                   labelText: 'Model',
//                   width: MediaQuery.of(context).size.width - 10,
//                 ),
//                 const SizedBox(height: 16.0),
//                 CustomeTextField(
//                   control: fuelTypeCtrl,
//                   validator: errValidatefueltype(fuelTypeCtrl.text),
//                   labelText: 'Fuel Type',
//                   width: MediaQuery.of(context).size.width - 10,
//                   // lines: 4,
//                 ),
//                 const SizedBox(height: 16.0),
//                 CustomeTextField(
//                   control: seatCapacityCtrl,
//                   validator: errValidateseat(seatCapacityCtrl.text),
//                   labelText: 'Seat Capacity',
//                   width: MediaQuery.of(context).size.width - 10,
//                 ),
//                 const SizedBox(height: 16.0),
//                 CustomeTextField(
//                   control: vehicleNumberCtrl,
//                   validator: errValidatevehiclenumber(vehicleNumberCtrl.text),
//                   labelText: 'Vehicle Number',
//                   width: MediaQuery.of(context).size.width - 10,
//                 ),
//                 const SizedBox(height: 16.0),
//                 OutlineBtnWidget(
//                     title: 'Upload Image of Car',
//                     icon: Icons.add_circle,
//                     width: MediaQuery.of(context).size.width - 10,
//                     height: 50,
//                     onTap: () {
//                       type = 0;
//                       showActionSheet(context);
//                     }),
//                 SizedBox(height: 10.0),
//                 Center(
//                   child: Stack(
//                     children: [
//                       liveimgSrc != "" && liveimgSrc != null && imageSrc == null
//                           ? ClipRRect(
//                               borderRadius: BorderRadius.circular(16),
//                               child: Container(
//                                 width: 160,
//                                 height: 160,
//                                 decoration: BoxDecoration(
//                                   image: DecorationImage(
//                                     image: NetworkImage(
//                                       AppConstants.imgBaseUrl +
//                                           (liveimgSrc ?? ''),
//                                     ),
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                                 child: liveimgSrc == null
//                                     ? Image.asset(
//                                         AppAssets.user,
//                                         fit: BoxFit.fill,
//                                       )
//                                     : null,
//                               ),
//                             )
//                           : imageSrc != null
//                               ? ClipRRect(
//                                   borderRadius: BorderRadius.circular(
//                                       16), // Adjust the radius as needed
//                                   child: Container(
//                                     width: 160,
//                                     height: 160,
//                                     decoration: BoxDecoration(
//                                       image: DecorationImage(
//                                         image: FileImage(imageSrc!),
//                                         fit: BoxFit.cover,
//                                       ),
//                                     ),
//                                   ),
//                                 )
//                               : SizedBox(),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 16.0),
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       // widget.carId == null ?
//                       saveCar();
//                       // : updateCar();
//                     },
//                     child: Text(
//                       widget.carId == null ? 'Add Now' : 'Update Now',
//                     ),
//                     style: ElevatedButton.styleFrom(
//                       textStyle: TextStyle(color: Colors.white),
//                       backgroundColor: Color(0xFF06234C),
//                       padding: EdgeInsets.symmetric(vertical: 16),
//                       minimumSize: Size(double.infinity, 50),
//                       shape: RoundedRectangleBorder(
//                         borderRadius:
//                             BorderRadius.circular(10), // Rounded corners
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         )));
//   }
// }
