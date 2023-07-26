// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:naseeb/config/app_theme.dart';
import 'package:naseeb/presentation/pages/employee/details/create_cv_page.dart';
import 'package:naseeb/presentation/pages/employer/home_page.dart';
import 'package:naseeb/presentation/pages/single_screens/app_settings_page.dart';
import 'package:naseeb/presentation/widgets/w_logout_message.dart';
import 'package:naseeb/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmployeeProfilePage extends StatelessWidget {
  const EmployeeProfilePage({super.key});

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
                      onTap: () => Navigator.pushNamed(
                          context, AppSettingsPage.routeName),
                      leading: const Icon(
                        Icons.settings,
                        size: 40,
                      ),
                      title: const Text(
                        "App Settings",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontFamily: "sfPro"),
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    padding: EdgeInsets.zero,
                    child: ListTile(
                      onTap: () async {
                        SharedPreferences preferences =
                            await SharedPreferences.getInstance();
                        await preferences.setBool("isEmployee", false);
                        Navigator.pushNamedAndRemoveUntil(context,
                            EmployerHomePage.routeName, (route) => false);
                      },
                      leading: const Icon(
                        Icons.rotate_left_outlined,
                        size: 40,
                      ),
                      title: const Text(
                        "Switch to Employer",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontFamily: "sfPro"),
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    padding: EdgeInsets.zero,
                    child: ListTile(
                      onTap: () {
                        showLogOutMessage(context);
                      },
                      leading: const Icon(
                        Icons.power_settings_new_rounded,
                        size: 40,
                        color: MyColor.salary,
                      ),
                      title: const Text(
                        "Log Out",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: "sfPro",
                          color: MyColor.salary,
                        ),
                      ),
                    ),
                  )
                ],
              );
            },
            icon: SvgPicture.asset(
              "assets/svg/dots.svg",
              color: isDarkMode ? white : black,
            ),
          )
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
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, CreateCVPage.routeName);
          },
          child: DottedBorder(
            borderType: BorderType.RRect,
            radius: const Radius.circular(12),
            strokeWidth: 2,
            color: kprimaryColor,
            child: Container(
              height: 249,
              width: double.infinity,
              decoration: BoxDecoration(
                color: fieldFocusColor.withOpacity(isDarkMode ? .2 : 1),
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/svg/add_portfolio.svg"),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Create CV/Resume",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        fontFamily: "sfPro"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
