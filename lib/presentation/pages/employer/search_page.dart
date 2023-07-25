// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:naseeb/presentation/widgets/w_indicator.dart';
import 'package:naseeb/utils/colors.dart';

class EmployerSearchPage extends StatelessWidget {
  const EmployerSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Search",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: kgreyColor.withOpacity(.2),
              ),
            ),
            child: Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
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
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff171725)),
                  ),
                  subtitle: const Text(
                    "Graphic Designer",
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: kgreyColor),
                  ),
                  trailing: IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset(
                      "assets/svg/bookmark.svg",
                      color: kprimaryColor,
                    ),
                  ),
                ),
                const Row(
                  children: [
                    StatusIndicator(
                        background: fieldFocusColor,
                        text: "Design",
                        textColor: kprimaryColor),
                    SizedBox(
                      width: 5,
                    ),
                    StatusIndicator(
                        background: MyColor.typeBk,
                        text: "Full-time",
                        textColor: MyColor.type),
                    SizedBox(
                      width: 5,
                    ),
                    StatusIndicator(
                        background: MyColor.experienceBackground,
                        text: "3 years",
                        textColor: MyColor.experience),
                    SizedBox(
                      width: 5,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    StatusIndicator(
                        background: MyColor.salartBackground,
                        text: "\$500-\$700",
                        textColor: MyColor.salary),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut et massa mi. sit amet, consectetur adipiscing elit...",
                  style: TextStyle(color: kgreyColor),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kprimaryColor,
                    elevation: 0,
                    minimumSize: const Size(double.infinity, 30),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'View Post',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
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
