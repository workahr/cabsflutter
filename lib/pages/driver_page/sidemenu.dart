import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'expenses/expenses_list.dart';
import 'location/driver_location.dart';
import 'location/driverhome_page..dart';
import 'location/start_trip.dart';
import 'profile/profile_screen.dart';
import 'vehical/add_vehical_status.dart';
import 'vehical/vehicalreport.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
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
    return
        // key: _drawerKey,
        Drawer(
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
                  ))),
          ListTile(
            leading: Icon(Icons.location_on),
            title: Text(
              'Driver Home',
              style: TextStyle(
                  color: const Color(0xFF193358),
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DriverhomePage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.location_history),
            title: Text(
              'Driver Location',
              style: TextStyle(
                  color: const Color(0xFF193358),
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Driver_Location()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.start),
            title: Text(
              'Start Trip',
              style: TextStyle(
                  color: const Color(0xFF193358),
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => start_trip()),
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
            leading: Icon(Icons.file_open),
            title: Text(
              'Expenses',
              style: TextStyle(
                  color: const Color(0xFF193358),
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Expenses_List()),
              );
            },
          ),
          ListTile(
            leading: Image.asset(
              'assets/images/circle-parking.png',
              height: 24,
              width: 24,
            ),
            title: Text(
              'Vehicle Issue Report',
              style: TextStyle(
                  color: const Color(0xFF193358),
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => add_vehical_status()),
              );
            },
          ),
          ListTile(
            leading: Image.asset(
              'assets/images/Document Text.png',
              height: 24,
              width: 24,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => vehicalreport()),
              );
            },
            title: Text(
              'Vehicle report list',
              style: TextStyle(
                  color: const Color(0xFF193358),
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
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
