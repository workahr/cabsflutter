import 'dart:async';
import 'dart:convert';
import 'package:cabs/controllers/base_controller.dart';
import 'package:cabs/pages/auth/otp_verification_page.dart';
import 'package:cabs/pages/main_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/app_constants.dart';
import 'driver_page/trips/driver_mytrip.dart';

class LoginManagement extends StatefulWidget with WidgetsBindingObserver {
  const LoginManagement({Key? key}) : super(key: key);

  @override
  State<LoginManagement> createState() => _MyAppState();
}

class _MyAppState extends State<LoginManagement> with WidgetsBindingObserver {
  BaseController baseCtrl = Get.put(BaseController());

  _MyAppState() {}

  @override
  void initState() {
    // WidgetsBinding.instance.addObserver(this);
    getLoginScreen();
    super.initState();
  }

  String? loginuser;

  Future getLoginScreen() async {
    final prefs = await SharedPreferences.getInstance();
    loginuser = prefs.getString('role_name' ?? '');
    if (loginuser == "User") {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => MainContainer()),
        (Route<dynamic> route) => false,
      );
    } else if (loginuser == "Driver") {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => DriverMyTrip()),
        (Route<dynamic> route) => false,
      );
    } else {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => MainContainerAdmin()),
        (Route<dynamic> route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
        data:
            MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1.0)),
        child: MaterialApp());
  }
}
