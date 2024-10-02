import 'package:cabs/constants/app_assets.dart';
import 'package:cabs/pages/admin_panel/cars/car_list_page.dart';
import 'package:cabs/pages/main_container.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bookings/admin_all_booking.dart';
import 'cars/add_cars.dart';
import 'driver/add_drivers.dart';
import 'driver/driver_list_page.dart';
import 'profile/profile_screen.dart';
import 'thirdparty_details/add_thirdparty_details.dart';
import 'thirdparty_details/thirdparty_list_page.dart';

class Admin_SideMenu extends StatefulWidget {
  const Admin_SideMenu({super.key});

  @override
  State<Admin_SideMenu> createState() => _Admin_SideMenuState();
}

class _Admin_SideMenuState extends State<Admin_SideMenu> {
  // final GlobalKey<ScaffoldState> _drawerKey = GlobalKey<ScaffoldState>();

  Future<void> _handleLogout() async {
    // Clear SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    // Navigate to Login Page
    Navigator.pushNamedAndRemoveUntil(
        context, '/login', ModalRoute.withName('/login'));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Colors.white),
            accountName: Text(
              'Shivakumar',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF193358)),
            ),
            accountEmail: Text(
              '+91 856325241',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF616161)),
            ),
            currentAccountPictureSize: Size.fromRadius(30),
            currentAccountPicture: CircleAvatar(
                backgroundColor: const Color(0xFFF3F8FF),
                child: Icon(
                  Icons.person_2_outlined,
                  size: 24,
                  color: const Color(0xFF193358),
                )),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text(
              'Home ',
              style: TextStyle(
                  color: const Color(0xFF193358),
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MainContainerAdmin()),
              );
            },
          ),
          ListTile(
            leading: Image.asset(
              'assets/images/User.png',
              height: 24,
              width: 24,
            ),
            title: Text(
              'Profile Manage',
              style: TextStyle(
                  color: const Color(0xFF193358),
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            },
          ),
          ListTile(
            leading: Image.asset(
              AppAssets.carIcon,
              height: 24,
              width: 24,
            ),
            title: Text(
              'My Car List',
              style: TextStyle(
                  color: const Color(0xFF193358),
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => car_list()),
              );
            },
          ),
          // ListTile(
          //   leading: Image.asset(
          //     AppAssets.bookmarkIcon,
          //     height: 24,
          //     width: 24,
          //   ),
          //   title: Text(
          //     'Add Car',
          //     style: TextStyle(
          //         color: const Color(0xFF193358),
          //         fontSize: 18,
          //         fontWeight: FontWeight.w500),
          //   ),
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => AddCarScreen()),
          //     );
          //   },
          // ),
          ListTile(
            leading: Icon(
              Icons.person_outline,
              // height: 24,
              // width: 24,
            ),
            title: Text(
              'Driver List',
              style: TextStyle(
                  color: const Color(0xFF193358),
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DriverList()),
              );
            },
          ),
          ListTile(
            leading: Image.asset(
              AppAssets.bookmarkIcon,
              height: 24,
              width: 24,
            ),
            title: Text(
              'Third Party Details',
              style: TextStyle(
                  color: const Color(0xFF193358),
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Third_party_List()),
              );
            },
          ),
          ListTile(
            leading: Image.asset(
              'assets/images/log-out.png',
              height: 24,
              width: 24,
            ),
            title: Text(
              'Log Out',
              style: TextStyle(
                  color: const Color(0xFF193358),
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
            onTap: () async {
              await _handleLogout();
            },
          ),
        ],
      ),
    );
  }
}
