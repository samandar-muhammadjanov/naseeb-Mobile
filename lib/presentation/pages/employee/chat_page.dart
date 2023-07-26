// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:naseeb/presentation/pages/single_screens/chat_inside_page.dart';
import 'package:naseeb/utils/colors.dart';

class EmployeeChatPage extends StatelessWidget {
  const EmployeeChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Chats",
          style: TextStyle(
              fontWeight: FontWeight.w700, fontSize: 18, fontFamily: "sfPro"),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                  prefixIcon: IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset(
                      "assets/svg/search.svg",
                      color: kgreyColor,
                    ),
                  ),
                  hintText: "Search...",
                  hintStyle: const TextStyle(
                      color: kgreyColor, fontSize: 16, fontFamily: "sfPro"),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: kgreyColor.withOpacity(.2),
                      ),
                      borderRadius: BorderRadius.circular(15))),
            ),
            const SizedBox(
              height: 20,
            ),
            ListView(
              shrinkWrap: true,
              children: [
                ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, ChatInsidePage.routeName);
                  },
                  contentPadding: const EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(
                      color: kgreyColor.withOpacity(.2),
                    ),
                  ),
                  leading: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: kgreyColor),
                    child: const Icon(
                      Icons.image,
                      color: white,
                    ),
                  ),
                  title: const Text(
                    "Jasur Nigmanov",
                    style: TextStyle(
                        fontFamily: "sfPro", fontWeight: FontWeight.w700),
                  ),
                  subtitle: const Text("Lorem ipsum dolor sit amet...",
                      style: TextStyle(fontFamily: "sfPro")),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        '09:41',
                        style: TextStyle(
                            color: kgreyColor,
                            fontSize: 12,
                            fontFamily: "sfPro",
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 13,
                        width: 13,
                        decoration: const BoxDecoration(
                            color: kprimaryColor, shape: BoxShape.circle),
                        child: const Text(
                          "2",
                          style: TextStyle(
                              fontSize: 8,
                              color: white,
                              fontWeight: FontWeight.w600),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
