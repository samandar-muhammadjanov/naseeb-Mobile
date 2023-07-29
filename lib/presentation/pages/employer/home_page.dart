// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:naseeb/presentation/pages/employer/post_page.dart';
import 'package:naseeb/presentation/pages/employer/chat_page.dart';
import 'package:naseeb/presentation/pages/employer/profile_page.dart';
import 'package:naseeb/presentation/pages/employer/saved_page.dart';
import 'package:naseeb/presentation/pages/employer/search_page.dart';
import 'package:naseeb/utils/colors.dart';

class EmployerHomePage extends StatefulWidget {
  const EmployerHomePage({super.key, this.index});
  static const routeName = '/home/employer';
  final int? index;
  @override
  State<EmployerHomePage> createState() => _EmployerHomePageState();
}

class _EmployerHomePageState extends State<EmployerHomePage> {
  int currentIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.index != null) {
      currentIndex = widget.index!;
    }
  }

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
      const BottomNavigationBarItem(icon: Icon(Icons.add), label: "Add Post"),
      BottomNavigationBarItem(
          icon: SvgPicture.asset("assets/svg/Chat.svg",
              color: currentIndex == 3 ? kprimaryColor : kgreyColor),
          label: "Chat"),
      BottomNavigationBarItem(
          icon: SvgPicture.asset("assets/svg/profile.svg",
              color: currentIndex == 4 ? kprimaryColor : kgreyColor),
          label: "Profile"),
    ];

    List pages = [
      const EmployerSearchPage(),
      const EmployerSavedPage(),
      const PostPage(),
      const EmployerChatPage(),
      const EmployerProfilePage()
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
            type: BottomNavigationBarType.fixed,
            items: items),
      ),
    );
  }
}
