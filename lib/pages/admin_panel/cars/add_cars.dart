import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../constants/app_assets.dart';
import '../../../constants/app_constants.dart';
import '../../../services/cabs_api_service.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import '../../../services/comFuncService.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/outline_btn_widget.dart';
import 'add_cars_model.dart';
import 'package:image_picker/image_picker.dart';

class AddCarScreen extends StatefulWidget {
  const AddCarScreen({Key? key}) : super(key: key);

  @override
  State<AddCarScreen> createState() => _AddCarScreenState();
}

class _AddCarScreenState extends State<AddCarScreen> {
  final CabsApiService apiService = CabsApiService();

  final TextEditingController brandCtrl = TextEditingController();
  final TextEditingController modelCtrl = TextEditingController();
  final TextEditingController fuelTypeCtrl = TextEditingController();
  final TextEditingController seatCapacityCtrl = TextEditingController();
  final TextEditingController vehicleNumberCtrl = TextEditingController();

  Uint8List data = Uint8List(0);

  // List<BatchListData>? batchList = [];
  String? selectedBatch;
  int type = 0; // 0- car tag image, 1- car weight image

  Future saveCar() async {
    await apiService.getBearerToken();
    if (imageFile == null) {
      showInSnackBar(context, 'Car image is required');
      return;
    }
    Map<String, dynamic> postData = {
      //"user_id": selectedUserId,
      "brand": brandCtrl,
      "model": modelCtrl,
      "fueltype": fuelTypeCtrl,
      "seatcapacity": seatCapacityCtrl.text,
      "vechicle": vehicleNumberCtrl.text
    };
    print('postData $postData');

    String url = 'mortality/create-mortality';

    var result = await apiService.saveCar(url, postData, imageFile);
    CarAddModel response = carAddModelFromJson(result);

    if (response.status.toString() == 'SUCCESS') {
      showInSnackBar(context, response.message.toString());
      Navigator.pop(context, {'type': 1});
    } else {
      print(response.message.toString());
      showInSnackBar(context, response.message.toString());
    }
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
        setState(() {});
      }
    } catch (e) {
      setState(() {});
    }
  }

  void getRecognizedText(image) async {
    try {
      // Convert image file path to InputImage
      final inputImage = InputImage.fromFilePath(image.path);

      // Initialize the TextRecognizer
      final textDetector = TextRecognizer();

      // Process the image to get recognized text
      RecognizedText recognisedText =
          await textDetector.processImage(inputImage);

      // Convert the blocks of recognized text to a list
      final resVal = recognisedText.blocks.toList();

      // Prepare a list to store all dates found in the recognized text
      List allDates = [];

      // Iterate through the recognized text blocks
      for (TextBlock block in resVal) {
        for (TextLine line in block.lines) {
          // Add logic to find and store dates, e.g., using RegExp for date matching
          String recognizedLine = line.text;
          RegExp dateRegex = RegExp(
              r"\b\d{1,2}/\d{1,2}/\d{2,4}\b"); // Adjust regex to your date format
          Iterable<Match> matches = dateRegex.allMatches(recognizedLine);

          // Store matched dates
          for (Match match in matches) {
            allDates.add(match.group(0)); // Add the recognized date to the list
          }
        }
      }

      // Close the text recognizer
      await textDetector.close();

      // Now you can handle the recognized dates or other text here
      print(allDates); // For example, print the dates

      // You could also display a message to the user with the recognized dates
      // showInSnackBar(context, 'Recognized dates: ${allDates.join(', ')}');
    } catch (e) {
      // Handle any errors by showing a snackbar
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
                onTap: () {
                  getImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () {
                  getImage(ImageSource.camera);
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
            "Add Cars",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color(0xFF06234C)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomeTextField(
              control: brandCtrl,
              labelText: 'Brand',
              width: MediaQuery.of(context).size.width - 10,
            ),
            const SizedBox(height: 16.0),
            CustomeTextField(
              control: modelCtrl,
              labelText: 'Model',
              width: MediaQuery.of(context).size.width - 10,
            ),
            const SizedBox(height: 16.0),
            CustomeTextField(
              control: fuelTypeCtrl,
              //    validator: errValidateDesc(fuelTypeCtrl.text),
              labelText: 'Fuel Type',
              width: MediaQuery.of(context).size.width - 10,
              // lines: 4,
            ),
            const SizedBox(height: 16.0),
            CustomeTextField(
              control: seatCapacityCtrl,
              labelText: 'Seat Capacity',
              width: MediaQuery.of(context).size.width - 10,
            ),
            const SizedBox(height: 16.0),
            CustomeTextField(
              control: vehicleNumberCtrl,
              labelText: 'Vehicle Number',
              width: MediaQuery.of(context).size.width - 10,
            ),
            const SizedBox(height: 16.0),
            OutlineBtnWidget(
                title: 'Upload Image',
                icon: Icons.add_circle,
                width: MediaQuery.of(context).size.width - 10,
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
                                  AppConstants.imgBaseUrl + (liveimgSrc ?? ''),
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
                onPressed: () {},
                child: Text('Add Now'),
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
            ),
          ],
        ),
      ),
    );
  }
}
