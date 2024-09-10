import 'package:cabs/constants/app_assets.dart';
import 'package:flutter/material.dart';

import 'booking/my_bookings_page.dart';
import 'cars/add_cars_page.dart';
import 'home/home_page.dart';


class MainContainer extends StatefulWidget {
  MainContainer({super.key, this.childWidget});

  final Widget? childWidget;

  @override
  State<MainContainer> createState() => _MainContainerState();
}

class _MainContainerState extends State<MainContainer>
    with WidgetsBindingObserver {
  int _selectedIndex = 0;

  final List pageId = [1, 5, 8, 12, 15];
  static List<Widget> pageOptions = <Widget>[
    // DashboardPage(),

    HomePage(),

    MyBookingsPage(),
    AddCarsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // print(baseCtrl.player);
        // print('out');
        // setState(() {
        //   navBack = true;
        // });
        // showInSnackBar(context, "back");
        return true;
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
            BottomNavigationBarItem(
              icon: Image.asset(
                AppAssets.bookmarkIcon,
              ),
              //  icon: Icon(Icons.add),
              label: 'Add Cars',
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