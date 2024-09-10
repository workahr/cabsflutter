import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/app_assets.dart';
import '../../services/cabs_api_service.dart';
import '../../services/comFuncService.dart';
import '../../widgets/custom_text_field.dart';
import 'auth_validations.dart';
import 'login_model.dart';
import 'otp_verification_page.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _phoneController = TextEditingController();
  AuthValidation authValidation = AuthValidation();
  final CabsApiService apiService = CabsApiService();




  Future login() async {
    try {
       showInSnackBar(context, 'Processing...');
      
    
      if (_phoneController.text != "") {
        Map<String, dynamic> postData = {
          'mobile': _phoneController.text,
          'otp': "",
        };
        var result = await apiService.userLoginWithOtp(postData);
        LoginOtpModel response = loginOtpModelFromJson(result);

        closeSnackBar(context: context);


        if (response.status.toString() == 'SUCCESS') {
          setState(() {
          Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OtpVerificationPage(
                              phoneNumber: _phoneController.text,
                            ),
                          ),
                        );
          });
        
          // final prefs = await SharedPreferences.getInstance();
          
          
          // //prefs.setString('fullname', response.fullname ?? '');

    

          //   if(response.authToken != null){
          //     Navigator.pushNamed(context, '/');
          //     prefs.setString('auth_token', response.authToken ?? '');
          //     prefs.setBool('isLoggedin', true);
          //   }
          
        } else {
          showInSnackBar(context, response.message.toString());
        }
      } else {
        showInSnackBar(context, "Please fill required fields");
      }
    } catch (error) {
      showInSnackBar(context, error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Logo and header section
           
                  Image.asset(
                  AppAssets.logo,
                  width: double.infinity,
                  height: 280.0,
                  fit: BoxFit.cover,
                ),
                  //const SizedBox(height: 10.0),

            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  const Text(
                    'Enter your mobile number to proceed',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                 CustomeTextField(
                        labelText: 'Mobile Number',
                        control: _phoneController,
                        validator: authValidation
                            .errValidateMobileNo(_phoneController.text),
                        width: MediaQuery.of(context).size.width / 1.1,
                        type: const TextInputType.numberWithOptions(),
                        inputFormaters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^-?(\d+)?\.?\d{0,11}'))
                        ],
                      ),
                  const SizedBox(height: 20.0),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                       login();
                        print(
                            'Get OTP tapped with number: ${_phoneController.text}');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF06234C),
                        padding: const EdgeInsets.symmetric(vertical: 14.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: const Text(
                        'Get OTP',
                        style: TextStyle(fontSize: 16.0, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}