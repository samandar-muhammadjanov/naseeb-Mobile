// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:naseeb/presentation/pages/employee/chat_page.dart';
import 'package:naseeb/presentation/pages/employee/profile_page.dart';
import 'package:naseeb/presentation/pages/employee/saved_page.dart';
import 'package:naseeb/presentation/pages/employee/search_page.dart';
import 'package:naseeb/utils/colors.dart';

class EmployeeHomePage extends StatefulWidget {
  const EmployeeHomePage({super.key});
  static const routeName = "/home/employee";

  @override
  State<EmployeeHomePage> createState() => _EmployeeHomePageState();
}

class _EmployeeHomePageState extends State<EmployeeHomePage> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    List<BottomNavigationBarItem> items = [
      BottomNavigationBarItem(
          icon: SvgPicture.asset(
            "assets/svg/search.svg",
            color: currentIndex == 0 ? kprimaryColor : kgreyColor,
          ),
          label: "Search"),
      BottomNavigationBarItem(
          icon: SvgPicture.asset("assets/svg/bookmark.svg",
              color: currentIndex == 1 ? kprimaryColor : kgreyColor),
          label: "Saved"),
      // BottomNavigationBarItem(
      //     icon: SvgPicture.asset("assets/svg/Chat.svg",
      //         color: currentIndex == 2 ? kprimaryColor : kgreyColor),
      //     label: "Chat"),
      BottomNavigationBarItem(
          icon: SvgPicture.asset("assets/svg/profile.svg",
              color: currentIndex == 2 ? kprimaryColor : kgreyColor),
          label: "Profile"),
    ];
    List pages = [
      const EmployeeSearchPage(),
      const EmployeeSavedPage(),
      // const EmployeeChatPage(),
      const EmployeeProfilePage()
    ];
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: SizedBox(
        height: 88,
        child: BottomNavigationBar(
            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            currentIndex: currentIndex,
            selectedFontSize: 12,
            unselectedFontSize: 12,
            selectedItemColor: kprimaryColor,
            unselectedItemColor: kgreyColor,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            items: items),
      ),
    );
  }
}
