import 'package:flutter/material.dart';

class AddDrivers extends StatefulWidget {
  @override
  _AddDriverState createState() => _AddDriverState();
}

class _AddDriverState extends State<AddDrivers> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController userIdController = TextEditingController();
  TextEditingController vehicleIdController = TextEditingController();
  TextEditingController licenseNumberController = TextEditingController();
  TextEditingController licenseExpiryDateController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController emailIdController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Add Drivers",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color(0xFF06234C)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: userIdController,
                decoration: InputDecoration(
                  labelText: 'User ID',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the User ID';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: vehicleIdController,
                decoration: InputDecoration(
                  labelText: 'Vehicle ID',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the Vehicle ID';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: licenseNumberController,
                decoration: InputDecoration(
                  labelText: 'License Number',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the License Number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: licenseExpiryDateController,
                decoration: InputDecoration(
                  labelText: 'License Expiry Date',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the License Expiry Date';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: mobileNumberController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Mobile Number',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the Mobile Number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: emailIdController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email ID',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the Email ID';
                  } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                      .hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: addressController,
                decoration: InputDecoration(
                  labelText: 'Address',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the Address';
                  }
                  return null;
                },
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    print('Form Submitted');
                  }
                },
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
            ],
          ),
        ),
      ),
    );
  }
}
