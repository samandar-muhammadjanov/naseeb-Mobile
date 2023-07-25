import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:naseeb/presentation/pages/employee/details/create_cv_page.dart';
import 'package:naseeb/utils/colors.dart';

class EmployeeProfilePage extends StatelessWidget {
  const EmployeeProfilePage({super.key});

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
                color: fieldFocusColor,
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
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
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
