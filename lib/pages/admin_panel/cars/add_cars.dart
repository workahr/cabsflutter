import 'package:flutter/material.dart';

import '../../../services/cabs_api_service.dart';
import '../../../services/comFuncService.dart';
import '../../../widgets/custom_text_field.dart';
import 'add_cars_model.dart';

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

  Future saveCar() async {
    await apiService.getBearerToken();

    Map<String, dynamic> postData = {
      //"user_id": selectedUserId,
      "brand": brandCtrl,
      "model": modelCtrl,
      "fueltype": fuelTypeCtrl,
      "seatcapacity": seatCapacityCtrl.text,
      "vechicle": vehicleNumberCtrl.text
    };

    var result = await apiService.saveCar(postData);
    CarAddModel response = carAddModelFromJson(result);

    if (response.status.toString() == 'SUCCESS') {
      showInSnackBar(context, response.message.toString());
      Navigator.pop(context, {'add': true});
    } else {
      print(response.message.toString());
      showInSnackBar(context, response.message.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Add Cars",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color(0xFF06234C)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: brandCtrl,
              decoration: const InputDecoration(
                labelText: 'Brand',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: modelCtrl,
              decoration: const InputDecoration(
                labelText: 'Model',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            CustomeTextField(
              control: fuelTypeCtrl,
              //    validator: errValidateDesc(fuelTypeCtrl.text),
              labelText: 'Description',
              width: MediaQuery.of(context).size.width - 10,
              lines: 4,
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: seatCapacityCtrl,
              decoration: const InputDecoration(
                labelText: 'Seat Capacity',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: vehicleNumberCtrl,
              decoration: const InputDecoration(
                labelText: 'Vehicle Number',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            GestureDetector(
              onTap: () {},
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.image),
                    SizedBox(width: 8.0),
                    Text('Upload Image of Car'),
                  ],
                ),
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
