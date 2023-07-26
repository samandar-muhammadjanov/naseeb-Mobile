// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:naseeb/config/app_theme.dart';
import 'package:naseeb/presentation/pages/employee/home_page.dart';
import 'package:naseeb/presentation/pages/single_screens/app_settings_page.dart';
import 'package:naseeb/presentation/widgets/w_logout_message.dart';
import 'package:naseeb/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmployerProfilePage extends StatelessWidget {
  const EmployerProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        ThemeModelInheritedNotifier.of(context).theme == AppTheme.darkTheme;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                showMenu(
                  context: context,
                  position: const RelativeRect.fromLTRB(10, 100, 0, 0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  elevation: 40,
                  shadowColor: lightGrey.withOpacity(.2),
                  items: [
                    PopupMenuItem(
                      padding: EdgeInsets.zero,
                      child: ListTile(
                        onTap: () async {
                          SharedPreferences preferences =
                              await SharedPreferences.getInstance();
                          await preferences.setBool("isEmployee", true);
                          Navigator.pushNamedAndRemoveUntil(context,
                              EmployeeHomePage.routeName, (route) => false);
                        },
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        leading: const Icon(
                          Icons.rotate_left_outlined,
                          size: 40,
                        ),
                        title: const Text(
                          "Switch to Employee",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                );
              },
              icon: SvgPicture.asset(
                "assets/svg/dots.svg",
                color: isDarkMode ? white : black,
              ))
        ],
        centerTitle: true,
        title: const Text(
          "Profile",
          style: TextStyle(
              fontWeight: FontWeight.w700, fontSize: 18, fontFamily: "sfPro"),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                    height: 140,
                    width: 140,
                    decoration: BoxDecoration(
                      color: kgreyColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Icon(
                      Icons.image,
                      size: 40,
                      color: white,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Jasur Nigmanov",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        fontFamily: "sfPro"),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    "Graphic Designer",
                    style: TextStyle(
                        color: kgreyColor,
                        fontWeight: FontWeight.w600,
                        fontFamily: "sfPro"),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    tileColor: isDarkMode
                        ? const Color(0xff14171e).withOpacity(.6)
                        : lightGrey,
                    minLeadingWidth: 0,
                    leading: const Icon(
                      Icons.account_circle_outlined,
                      size: 30,
                    ),
                    title: const Text(
                      "Profile Settings",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: "sfPro"),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    onTap: () =>
                        Navigator.pushNamed(context, AppSettingsPage.routeName),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    tileColor: isDarkMode
                        ? const Color(0xff14171e).withOpacity(.6)
                        : lightGrey,
                    minLeadingWidth: 0,
                    leading: const Icon(
                      Icons.settings,
                      size: 30,
                    ),
                    title: const Text(
                      "App Settings",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: "sfPro"),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    onTap: () {
                      showLogOutMessage(context);
                    },
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    tileColor: MyColor.salary.withOpacity(.2),
                    minLeadingWidth: 0,
                    leading: const Icon(
                      Icons.power_settings_new_rounded,
                      size: 30,
                      color: MyColor.salary,
                    ),
                    title: const Text(
                      "Log Out",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: MyColor.salary,
                          fontFamily: "sfPro"),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
