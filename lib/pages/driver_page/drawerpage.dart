import 'package:flutter/material.dart';

class Drawerpage extends StatefulWidget {
  const Drawerpage({super.key});

  @override
  State<Drawerpage> createState() => _DrawerpageState();
}

class _DrawerpageState extends State<Drawerpage> {
  // final GlobalKey<ScaffoldState> _drawerKey = GlobalKey<ScaffoldState>();

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
          ),
          ListTile(
            leading: Image.asset(
              'assets/images/Document Text.png',
              height: 24,
              width: 24,
            ),
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
          ),
        ],
      ),
    );
  }
}
