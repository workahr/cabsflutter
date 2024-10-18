import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/app_colors.dart';
import '../../services/cabs_api_service.dart';
import '../../services/comFuncService.dart';
import '../../widgets/sub_heading_widget.dart';
import 'display_content_page.dart';
import 'package:pinput/pinput.dart';

import 'login_model.dart';

class OtpVerificationPage extends StatefulWidget {
  final String? phoneNumber;
  final int? otp;

  OtpVerificationPage({Key? key, this.phoneNumber, this.otp}) : super(key: key);

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  final List<TextEditingController> _otpControllers =
      List.generate(6, (_) => TextEditingController());
  TextEditingController otpCtrl = TextEditingController();

  final CabsApiService apiService = CabsApiService();
  final GlobalKey<FormState> loginForm = GlobalKey<FormState>();

  final otpFocusNode = FocusNode();
  // @override
  // void dispose() {
  //   _timer?.cancel(); // Cancel the timer when the widget is disposed
  //   for (var controller in _otpControllers) {
  //     controller.dispose();
  //   }
  //   super.dispose();
  // }

  @override
void dispose() {
  _timer?.cancel(); // Cancel the timer when the widget is disposed
  otpCtrl.dispose(); // Dispose the controller as well
  super.dispose();
}

  @override
  void initState() {
    //  setState(() {
    //    otpCtrl.text = widget.otp.toString();
    //  });

    super.initState();
    startTimer();
  }

  Timer? _timer;
  int _start = 60; // 60 seconds countdown
  bool _isResendButtonEnabled = false;

  // Function to start the timer
  // void startTimer() {
  //   const oneSec = Duration(seconds: 1);
  //   _timer = Timer.periodic(
  //     oneSec,
  //     (Timer timer) {
  //       if (_start == 0) {
  //         setState(() {
  //           timer.cancel();
  //           _isResendButtonEnabled = true;
  //         });
  //       } else {
  //         setState(() {
  //           _start--;
  //         });
  //       }
  //     },
  //   );
  // }

  void startTimer() {
  const oneSec = Duration(seconds: 1);
  _timer = Timer.periodic(
    oneSec,
    (Timer timer) {
      if (_start == 0) {
        if (mounted) {
          setState(() {
            timer.cancel();
            _isResendButtonEnabled = true;
          });
        }
      } else {
        if (mounted) {
          setState(() {
            _start--;
          });
        }
      }
    },
  );
}

  // Function to resend the OTP
  void resendOTP() {
    if (_isResendButtonEnabled) {
      setState(() {
        _start = 60; // Reset the timer
        _isResendButtonEnabled = false;
        otpCtrl.text = "";
      });
      //startTimer();
      login();
    }
  }

  Future login() async {
    try {
      //  showInSnackBar(context, 'Processing...');
      showSnackBar(context: context, showClose: false);
      startTimer();
      if (loginForm.currentState!.validate()) {
        Map<String, dynamic> postData = {
          'mobile': widget.phoneNumber,
          'otp': otpCtrl.text,
        };
        var result = await apiService.userLoginWithOtp(postData);
        LoginOtpModel response = loginOtpModelFromJson(result);

        closeSnackBar(context: context);

        if (response.status.toString() == 'SUCCESS') {
          final prefs = await SharedPreferences.getInstance();

          if (response.authToken != null) {
            //Navigator.pushNamed(context, '/');
            prefs.setString('auth_token', response.authToken ?? '');
            prefs.setString('role_name', response.roleName ?? '');
            prefs.setInt('user_id', response.userId ?? 0);
            prefs.setBool('isLoggedin', true);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DisplayContentPage(),
              ),
            );
          }
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
    const focusedBorderColor = Color.fromRGBO(23, 171, 144, 1);
    const fillColor = Color.fromRGBO(243, 246, 249, 0);
    const borderColor = Color.fromRGBO(23, 171, 144, 0.4);

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: borderColor),
      ),
    );
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: loginForm,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Verify with OTP sent to',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8.0),
                Row(
                  children: [
                    Text(
                      "+91 ",
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    Text(
                      widget.phoneNumber.toString(),
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                    )
                  ],
                ),
                const SizedBox(height: 30.0),

                Pinput(
                  length: 6,
                  controller: otpCtrl,
                  focusNode: otpFocusNode,
                  androidSmsAutofillMethod:
                      AndroidSmsAutofillMethod.smsUserConsentApi,
                  listenForMultipleSmsOnAndroid: true,
                  defaultPinTheme: defaultPinTheme,
                  separatorBuilder: (index) => const SizedBox(width: 8.0),
                  validator: (value) {
                    // return value.toString() == orgOtp.toString()
                    //     ? null
                    //     : 'OTP is incorrect';
                  },
                  // onClipboardFound: (value) {
                  //   debugPrint('onClipboardFound: $value');
                  //   pinController.setText(value);
                  // },
                  hapticFeedbackType: HapticFeedbackType.lightImpact,
                  onCompleted: (pin) {
                    // debugPrint('onCompleted: $pin');
                  },
                  onChanged: (value) {
                    // debugPrint('onChanged: $value');
                  },
                  cursor: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 9.0),
                        width: 22.0,
                        height: 1.0,
                        color: focusedBorderColor,
                      ),
                    ],
                  ),
                  focusedPinTheme: defaultPinTheme.copyWith(
                    decoration: defaultPinTheme.decoration!.copyWith(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: focusedBorderColor),
                    ),
                  ),
                  submittedPinTheme: defaultPinTheme.copyWith(
                    decoration: defaultPinTheme.decoration!.copyWith(
                      color: fillColor,
                      borderRadius: BorderRadius.circular(19),
                      border: Border.all(color: focusedBorderColor),
                    ),
                  ),
                  errorPinTheme: defaultPinTheme.copyBorderWith(
                    border: Border.all(color: AppColors.danger),
                  ),
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: List.generate(6, (index) {
                //     return SizedBox(
                //       width: 40,
                //       child: TextField(
                //         controller: _otpControllers[index],
                //         keyboardType: TextInputType.number,
                //         textAlign: TextAlign.center,
                //         maxLength: 1,
                //         inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                //         decoration: InputDecoration(
                //           counterText: '',
                //           border: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(8.0),
                //             borderSide: const BorderSide(color: Colors.grey),
                //           ),
                //         ),
                //         onChanged: (value) {
                //           if (value.isNotEmpty) {
                //             if (index < 5) {
                //               FocusScope.of(context).nextFocus();
                //             }
                //           } else {
                //             if (index > 0) {
                //               FocusScope.of(context).previousFocus();
                //             }
                //           }
                //         },
                //       ),
                //     );
                //   }),
                // ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (_start == 0)
                      GestureDetector(
                        onTap: _isResendButtonEnabled ? resendOTP : null,
                        child: SubHeadingWidget(
                            title: 'Resend OTP',
                            color: AppColors.primary,
                            vMargin: 2.0),
                      ),
                    if (_start == 0)
                      Align(
                        alignment: Alignment.centerRight,
                        child: SubHeadingWidget(
                            title: 'Please wait $_start seconds',
                            color: AppColors.danger,
                            vMargin: 2.0),
                      ),
                  ],
                ),

                if (_start != 0)
                  Align(
                    alignment: Alignment.centerRight,
                    child: SubHeadingWidget(
                        title: 'Please wait $_start seconds',
                        color: AppColors.danger,
                        vMargin: 2.0),
                  ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     const Text("Didn't get the OTP?"),
                //     TextButton(
                //       onPressed: () {
                //         // Resend OTP
                //       },
                //       child: const Text(
                //         'Resend the SMS',
                //         style: TextStyle(
                //           color: Color(0xFF06234C),
                //           fontWeight: FontWeight.bold,
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                const SizedBox(height: 20.0),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      login();

                      print(
                          'OTP entered: ${_otpControllers.map((c) => c.text).join()}');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF06234C),
                      padding: const EdgeInsets.symmetric(vertical: 14.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Text(
                      'Continue',
                      style: TextStyle(fontSize: 16.0, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                const Center(
                  child: Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
