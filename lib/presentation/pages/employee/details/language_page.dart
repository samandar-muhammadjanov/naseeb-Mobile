import 'package:flutter/material.dart';
import 'package:naseeb/presentation/widgets/w_button.dart';
import 'package:naseeb/presentation/widgets/w_textField.dart';
import 'package:naseeb/utils/colors.dart';

class LanguagePage extends StatelessWidget {
  const LanguagePage({super.key});
  static const routeName = '/employee/language';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Language",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16),
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            WTextField(title: "Language"),
            SizedBox(
              height: 20,
            ),
            WTextField(title: "Level"),
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
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: wButton(() => null, "Save", color: kgreyColor),
      ),
    );
  }
}
