import 'package:flutter/material.dart';

import 'completed.dart';
import 'livetrip.dart';

class TabBarPage extends StatefulWidget {
  const TabBarPage({super.key});

  @override
  State<TabBarPage> createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Column(
          children: [
            TabBar(
              dividerColor: Colors.transparent,
              indicatorColor: Color(0xFF193358),
              labelStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF193358)),
              unselectedLabelStyle: TextStyle(
                  color: Color(0xFF777777),
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
              tabs: [
                Tab(
                  text: ('Live Trip'),
                ),
                Tab(
                  text: ('Completed'),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                // <-- Your TabBarView
                children: [
                  livetrippage(),
                  completedPage(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
