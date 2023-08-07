// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:naseeb/domain/models/post_for_employee.dart';
import 'package:naseeb/presentation/pages/single_screens/chat_inside_page.dart';
import 'package:naseeb/utils/colors.dart';

class InsidePostForEmployeePage extends StatelessWidget {
  const InsidePostForEmployeePage({super.key, this.item});
  static const routeName = "/employee/post";
  final Datum? item;
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
                fontFamily: "sfPro",
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
            if (item!.responseFiles.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  item!.responseFiles.first.url,
                  height: 180,
                  fit: BoxFit.cover,
                ),
              )
            else
              const SizedBox(),
            const SizedBox(
              height: 10,
            ),
            Text(
              item!.description,
              style: TextStyle(fontFamily: "sfPro", fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Amount: " + item!.amountMoney.toStringAsFixed(0),
              style: TextStyle(
                  fontFamily: "sfPro",
                  fontSize: 16,
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "E'lon beruvchi",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  fontFamily: "sfPro"),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15), color: kgreyColor),
              ),
              title: Text(
                "${item!.id} Nigmanov",
                style:
                    TextStyle(fontWeight: FontWeight.w700, fontFamily: "sfPro"),
              ),
              subtitle: const Text(
                "Yunusobod t. Toshkent sh. O'zbekiston",
                style: TextStyle(fontFamily: "sfPro"),
              ),
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
                          fontFamily: "sfPro",
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
                          fontFamily: "sfPro",
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
