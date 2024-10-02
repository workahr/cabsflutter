import 'package:cabs/constants/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'admin_panel/booking_histroy/booking_histroy.dart';
import 'admin_panel/bookings/admin_all_booking.dart';
import 'admin_panel/vehical_report/vehical_reports.dart';
import 'booking/my_bookings_page.dart';
import 'cars/add_cars_page.dart';
import 'driver_page/trips/driver_mytrip.dart';
import 'home/home_page.dart';
import 'user_panel/booking/add_booking.dart';
import 'user_panel/booking/user_my_booking.dart';

class MainContainer extends StatefulWidget {
  MainContainer({super.key, this.childWidget});

  final Widget? childWidget;

  @override
  State<MainContainer> createState() => _MainContainerState();
}

class _MainContainerState extends State<MainContainer>
    with WidgetsBindingObserver {
  int _selectedIndex = 0;
  bool navBack = false;

  final List pageId = [1, 5, 8, 12, 15];
  static List<Widget> pageOptions = <Widget>[
    add_booking(),
    UserMyBookings(),
  ];

  void _onItemTapped(int index) async {
    if (index == 2) {
      // Handle logout
      await _handleLogout();
    } else {
      // Handle other navigation
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  initState() {
    super.initState();
  }

  @protected
  void didUpdateWidget(oldWidget) {
    print('oldWidget');
    print(oldWidget);
    super.didUpdateWidget(oldWidget);
  }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   setState(() {
  //     // print('state l $state');

  //     if (AppLifecycleState.detached == state && navBack == false) {
  //       baseCtrl.player.stop();
  //       // print(
  //       //     ' audioplayer state ${baseCtrl.audioHandler.playbackState.value} ');
  //       // print(' playerState  ${baseCtrl.player.playerState} ');
  //     }
  //   });
  // }

  Future<void> _onPop() async {
    // Handle back button press, you can add custom logic here.
    // For example, you could show a dialog or exit the app.
    // Exit the app or return to the home page:
    if (_selectedIndex == 0) {
      // Exit the app if already on the home page.
      return;
    } else {
      // Otherwise, navigate back to the first tab (home page).
      setState(() {
        _selectedIndex = 0;
      });
    }
  }

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
    return PopScope(
      onPopInvoked: (popDisposition) async {
        await _onPop();
      },
      child: Scaffold(
        // appBar: CustomAppBar(title: '', leading: SizedBox(), showSearch: true,showCart: false, backgroundColor: [0,2].contains(_selectedIndex) ? AppColors.light: null ,),
        // onPressed: widget.onThemeToggle),
        // drawer: SideMenu(),
        body: pageOptions[_selectedIndex],

        bottomNavigationBar: BottomNavigationBar(
          // onTap: onTabTapped,
          // currentIndex: currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                AppAssets.carIcon,
              ),
              //icon: Icon(Icons.book),
              label: 'My Booking',
            ),
            // BottomNavigationBarItem(
            //   icon: Image.asset(
            //     AppAssets.bookmarkIcon,
            //   ),
            //   //  icon: Icon(Icons.add),
            //   label: 'Add Cars',
            // ),
            BottomNavigationBarItem(
              icon: Icon(Icons.logout), // Correct logout icon
              label: 'Logout',
            ),
          ],
          currentIndex: _selectedIndex,

          showUnselectedLabels: true,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}

class MainContainerAdmin extends StatefulWidget {
  MainContainerAdmin({super.key, this.childWidget});

  final Widget? childWidget;

  @override
  State<MainContainerAdmin> createState() => _MainContainerAdminState();
}

class _MainContainerAdminState extends State<MainContainerAdmin>
    with WidgetsBindingObserver {
  int _selectedIndex = 0;

  static List<Widget> pageOptions = <Widget>[
    Admin_All_Bookings(),
    Vechical_ReportsPage(),
    BookingHistory(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        body: pageOptions[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          // onTap: onTabTapped,
          // currentIndex: currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                AppAssets.carIcon,
              ),
              label: 'Bookings',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                AppAssets.reportfile,
              ),
              label: 'Reports',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                AppAssets.bookmarkIcon,
              ),
              label: 'Histroy',
            ),
          ],
          currentIndex: _selectedIndex,
          showUnselectedLabels: true,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}
