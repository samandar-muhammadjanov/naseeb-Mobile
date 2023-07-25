import 'package:flutter/material.dart';
import 'package:naseeb/presentation/widgets/w_button.dart';
import 'package:naseeb/presentation/widgets/w_textField.dart';
import 'package:naseeb/utils/colors.dart';

class WorkExperiencePage extends StatelessWidget {
  const WorkExperiencePage({super.key});
  static const routeName = '/employee/work-experience';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Work Experience",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: wButton(() => null, "Save", color: kgreyColor),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16),
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            WTextField(title: "Enter your job"),
            SizedBox(
              height: 20,
            ),
            WTextField(title: "Enter company name"),
            SizedBox(
              height: 20,
            ),
            WTextField(title: "Period"),
            SizedBox(
              height: 20,
            ),
            WTextField(
              title: "Enter description",
              maxLines: 5,
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
