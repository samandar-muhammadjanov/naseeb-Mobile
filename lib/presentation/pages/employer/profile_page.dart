import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:naseeb/utils/colors.dart';

class EmployerProfilePage extends StatelessWidget {
  const EmployerProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {}, icon: SvgPicture.asset("assets/svg/dots.svg"))
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
