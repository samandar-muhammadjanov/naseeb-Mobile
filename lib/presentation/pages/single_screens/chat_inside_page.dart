// ignore_for_file: deprecated_member_use

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:naseeb/config/app_theme.dart';
import 'package:naseeb/utils/colors.dart';

class ChatInsidePage extends StatelessWidget {
  const ChatInsidePage({super.key});
  static const routeName = "/employee/chat/1";
  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        ThemeModelInheritedNotifier.of(context).theme == AppTheme.darkTheme;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              "assets/svg/dots.svg",
              color: isDarkMode ? white : black,
            ),
          )
        ],
        toolbarHeight: 85,
        titleSpacing: 0,
        title: ListTile(
          title: const Text(
            "Jasur Nigmanov",
            style: TextStyle(
                fontSize: 16, fontFamily: "sfPro", fontWeight: FontWeight.w700),
          ),
          subtitle: const Text(
            "online",
            style: TextStyle(
                color: kprimaryColor, fontSize: 12, fontFamily: "sfPro"),
          ),
          leading: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), color: kgreyColor),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
            left: 16.0,
            right: 16,
            top: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom != 0
                ? MediaQuery.of(context).viewInsets.bottom + 16
                : 16),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                    prefixIcon: IconButton(
                        onPressed: () {},
                        icon: SvgPicture.asset("assets/svg/scirpt.svg")),
                    hintText: "Write your message",
                    hintStyle: const TextStyle(
                        color: kgreyColor, fontSize: 16, fontFamily: "sfPro"),
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(color: kgreyColor),
                        borderRadius: BorderRadius.circular(15))),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            FloatingActionButton(
              onPressed: () {},
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: SvgPicture.asset("assets/svg/send.svg"),
            )
          ],
        ),
      ),
    );
  }
}
