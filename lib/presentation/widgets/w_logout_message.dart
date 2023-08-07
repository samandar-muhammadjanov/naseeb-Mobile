// ignore_for_file: use_build_context_synchronously

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:naseeb/config/app_theme.dart';
import 'package:naseeb/presentation/pages/intro/auth_page.dart';
import 'package:naseeb/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

showLogOutMessage(BuildContext context) {
  bool isDarkMode =
      ThemeModelInheritedNotifier.of(context).theme == AppTheme.darkTheme;
  showCupertinoDialog(
    context: context,
    builder: (context) {
      return Material(
        color: Colors.transparent,
        child: Center(
          child: Container(
            margin: const EdgeInsets.all(16),
            height: 165,
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            decoration: BoxDecoration(
              color: isDarkMode ? const Color(0xff2b2d3a) : white,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "logoutMessageOne".tr(),
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "logoutMessageTwo".tr(),
                  style: const TextStyle(
                    color: kgreyColor,
                  ),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                          alignment: Alignment.center,
                          width: 80,
                          height: 35,
                          decoration: BoxDecoration(
                            color: lightGrey,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            "cansel".tr(),
                            style: const TextStyle(
                                color: kgreyColor, fontWeight: FontWeight.bold),
                          )),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () async {
                        SharedPreferences preferences =
                            await SharedPreferences.getInstance();
                        preferences.clear();
                        Navigator.pushNamedAndRemoveUntil(
                            context, AuthPage.routeName, (route) => false);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 80,
                        height: 35,
                        decoration: BoxDecoration(
                          color: MyColor.salartBackground,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          "logout".tr(),
                          style: const TextStyle(
                              color: MyColor.salary,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}
