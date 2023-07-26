// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:naseeb/presentation/pages/single_screens/chat_inside_page.dart';
import 'package:naseeb/utils/colors.dart';

class InsidePostForEmployeePage extends StatelessWidget {
  const InsidePostForEmployeePage({super.key});
  static const routeName = "/employee/post";
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
          width: 70,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
              color: fieldFocusColor,
              borderRadius: BorderRadius.all(Radius.circular(6))),
          child: const Center(
            child: Text(
              "Active job",
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
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15), color: kgreyColor),
              child: const Icon(
                Icons.image,
                color: white,
                size: 40,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Mexanik Kerak',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
                'Pariatur irure anim esse in excepteur do qui aliquip qui qui. Velit tempor cupidatat veniam consectetur reprehenderit sit magna tempor. Eiusmod est elit incididunt sunt dolor occaecat cillum duis id proident culpa. Aliquip exercitation exercitation magna eiusmod dolore elit commodo anim deserunt dolor nulla. Fugiat ipsum sint est minim nostrud labore aliqua magna exercitation minim et. Dolor ullamco voluptate nisi occaecat ut. Commodo amet sint amet culpa elit aliqua culpa do.'),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "E'lon beruvchi",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15), color: kgreyColor),
              ),
              title: const Text(
                "Jasur Nigmanov",
                style: TextStyle(
                    color: Color(0xff171725), fontWeight: FontWeight.w700),
              ),
              subtitle: const Text("Yunusobod t. Toshkent sh. O'zbekiston"),
            )
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
