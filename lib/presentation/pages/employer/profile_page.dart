// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:naseeb/presentation/pages/employee/home_page.dart';
import 'package:naseeb/presentation/pages/single_screens/app_settings_page.dart';
import 'package:naseeb/presentation/widgets/w_logout_message.dart';
import 'package:naseeb/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmployerProfilePage extends StatelessWidget {
  const EmployerProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                showMenu(
                  context: context,
                  color: lightGrey,
                  position: const RelativeRect.fromLTRB(10, 120, 0, 0),
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
              icon: SvgPicture.asset("assets/svg/dots.svg"))
        ],
        centerTitle: true,
        title: const Text(
          "Profile",
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
        ),
      ),
      body: Column(
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
                      color: Color(0xff171725)),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  "Graphic Designer",
                  style:
                      TextStyle(color: kgreyColor, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(7),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    tileColor: lightGrey,
                    leading: CircleAvatar(
                      backgroundColor: kgreyColor,
                      radius: 30,
                      child: SvgPicture.asset(
                        "assets/svg/profile.svg",
                        width: 23,
                        color: white,
                      ),
                    ),
                    title: const Text(
                      "Profile Settings",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ListTile(
                    onTap: () =>
                        Navigator.pushNamed(context, AppSettingsPage.routeName),
                    contentPadding: const EdgeInsets.all(7),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    tileColor: lightGrey,
                    leading: const CircleAvatar(
                      backgroundColor: kgreyColor,
                      radius: 30,
                      child: Icon(
                        Icons.settings,
                        size: 34,
                        color: white,
                      ),
                    ),
                    title: const Text(
                      "App Settings",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 16),
                  child: ListTile(
                    onTap: () {
                      showLogOutMessage(context);
                    },
                    contentPadding: const EdgeInsets.all(7),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    tileColor: MyColor.salartBackground,
                    leading: CircleAvatar(
                      backgroundColor: MyColor.salary.withOpacity(.3),
                      radius: 30,
                      child: const Icon(
                        Icons.power_settings_new_rounded,
                        size: 34,
                        color: MyColor.salary,
                      ),
                    ),
                    title: const Text(
                      "Log Out",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: MyColor.salary),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
