import 'package:flutter/material.dart';
import 'package:manage_my_horse/utils/colors.dart';


import '../Home/home_screen.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int currentPageIndex = 0;
  final pages = const[
    HomeScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      if(index== 0)
        currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages.elementAt(currentPageIndex),
      bottomNavigationBar: NavigationBar(
        indicatorShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        height: MediaQuery.of(context).size.height*.10,
        indicatorColor: appColors.indicatorColor,
        selectedIndex: currentPageIndex,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide ,
        onDestinationSelected: _onItemTapped,
        backgroundColor: appColors.navBarColor,
        surfaceTintColor: appColors.navBarColor,
        destinations: [
          NavigationDestination(icon: Image.asset('assets/icons/home.png'), label: ''),
          NavigationDestination(icon: Image.asset('assets/icons/chat.png'), label: ''),
          NavigationDestination(icon: Image.asset('assets/icons/notification.png'), label: ''),
          NavigationDestination(icon: Image.asset('assets/icons/calendar.png'), label: ''),
          NavigationDestination(icon: Image.asset('assets/icons/profile.png'), label: ''),
        ],


      ),
    );
  }
}
