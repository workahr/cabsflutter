import 'package:flutter/material.dart';

import '../../../constants/app_assets.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController nameController =
      TextEditingController(text: 'Vetrimaran');
  final TextEditingController mobileController =
      TextEditingController(text: '+91 856325241');
  final TextEditingController addressController = TextEditingController(
      text:
          'No.2/6, Phase 4, Sri Menga Garden, Tallar Nagar Ramathapuram 621361');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Profile',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color(0xFF06234C),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 80,
                  backgroundImage: AssetImage(AppAssets.profileimg),
                ),
                SizedBox(height: 15),
                Text(
                  'Vetrimaran',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF06234C),
                  ),
                ),
                SizedBox(height: 5),
                Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color(0xFF06234C),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: TextButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.edit_outlined, color: Colors.white),
                      label: Text('Edit Profile',
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                    )),
                SizedBox(height: 30),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    'Name',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  SizedBox(height: 5),
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      //  labelText: 'Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Mobile number',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  SizedBox(height: 5),
                  TextField(
                    controller: mobileController,
                    decoration: InputDecoration(
                      // labelText: 'Mobile number',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Address',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  SizedBox(height: 5),
                  TextField(
                    controller: addressController,
                    decoration: InputDecoration(
                      // labelText: 'Address',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                  )
                ]),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(300, 70),
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    backgroundColor: Color(0xFF06234C),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                ),
                SizedBox(height: 60),
                TextButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    Icons.logout,
                    color: Color(0xFF06234C),
                  ),
                  label: Text('Log out',
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xFF06234C),
                      )),
                ),
              ],
            ),
          ),
        ));
  }
}
