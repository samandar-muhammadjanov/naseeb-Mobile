// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:naseeb/presentation/pages/intro/auth_page.dart';
import 'package:naseeb/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

showLogOutMessage(BuildContext context) {
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
              color: white,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Are you absolutely sure?",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Logging out will end your current session, and you'll need to log in again to access your account.",
                  style: TextStyle(
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
                          child: const Text(
                            "Cansel",
                            style: TextStyle(
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
                        child: const Text(
                          "Log Out",
                          style: TextStyle(
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
