// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:naseeb/presentation/pages/employer/detail/resume_item.dart';
import 'package:naseeb/presentation/pages/single_screens/chat_inside_page.dart';
import 'package:naseeb/utils/colors.dart';

class InsideEmployeeProfilePage extends StatelessWidget {
  const InsideEmployeeProfilePage({super.key});
  static const routeName = '/employer/inside-employee';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              "assets/svg/bookmark.svg",
              color: kprimaryColor,
            ),
          )
        ],
        centerTitle: true,
        title: Container(
          height: 22,
          width: 96,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
              color: fieldFocusColor,
              borderRadius: BorderRadius.all(Radius.circular(6))),
          child: const Center(
            child: Text(
              "Active job finding",
              style: TextStyle(
                color: kprimaryColor,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 344,
              decoration: BoxDecoration(
                  color: kgreyColor, borderRadius: BorderRadius.circular(15)),
              child: const Icon(
                Icons.image,
                color: white,
                size: 50,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Jasur Nigmanov",
              style: TextStyle(
                  color: kprimaryColor,
                  fontSize: 28,
                  fontWeight: FontWeight.w700),
            ),
            const Text(
              "Graphic Designer",
              style: TextStyle(color: kgreyColor, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 17,
            ),
            WMainInformation(
                title: "Main Informations",
                subtitle: "Male • 25 years old • Tashkent",
                body: ""),
            SizedBox(
              height: 10,
            ),
            WWorkExperience(),
            SizedBox(
              height: 10,
            ),
            WEducation(),
            SizedBox(
              height: 10,
            ),
            WLanguage(),
            SizedBox(
              height: 10,
            ),
            WCertificate(),
            SizedBox(
              height: 10,
            ),
            WSalary()
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                borderRadius: BorderRadius.circular(15),
                onTap: () {},
                child: Ink(
                  height: 56,
                  width: 343,
                  decoration: BoxDecoration(
                      border: Border.all(color: kprimaryColor),
                      borderRadius: BorderRadius.circular(15)),
                  child: const Center(
                    child: Text(
                      "Call / SMS",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: kprimaryColor),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: InkWell(
                borderRadius: BorderRadius.circular(15),
                onTap: () {
                  Navigator.pushNamed(context, ChatInsidePage.routeName);
                },
                child: Ink(
                  height: 56,
                  width: 343,
                  decoration: BoxDecoration(
                      color: kprimaryColor,
                      borderRadius: BorderRadius.circular(15)),
                  child: const Center(
                    child: Text(
                      "Chat",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: white),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
