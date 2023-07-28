// ignore_for_file: avoid_returning_null_for_void, use_build_context_synchronously, file_names

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart';
import 'package:naseeb/domain/repositories/auth_repo/auth_repo.dart';
import 'package:naseeb/presentation/pages/employee/home_page.dart';
import 'package:naseeb/presentation/pages/employer/home_page.dart';
import 'package:naseeb/presentation/pages/intro/select_role_page.dart';
import 'package:naseeb/utils/colors.dart';

showSuccessOrError(BuildContext context, Response response, String user,
    String email, dynamic body) async {
  bool isLoading = false;
  isLoading = true;
  const spinKit = SpinKitCircle(
    size: 70,
    color: Colors.orange,
  );
  if (isLoading) {
    showCustomDialog(
        context: context,
        status: spinKit,
        title: "Verifying",
        body: "Verifying your phone",
        textButton: "Done",
        onTap: () => null,
        btnColor: kgreyColor);
  }
  Future.delayed(
    const Duration(seconds: 4),
    () {
      Navigator.pop(context);

      isLoading = false;

      if (response.statusCode == 200) {
        showCustomDialog(
            context: context,
            barierDismissible: false,
            status: SvgPicture.asset("assets/svg/success.svg"),
            title: "Success",
            body: "Congratulations, you have completed your registration!",
            textButton: "Done",
            onTap: () async {
              if (user == "new user") {
                Navigator.pushNamedAndRemoveUntil(
                    context, SelectRolePage.routeName, (route) => false);
              } else if (user == "OK") {
                final data = await AuthRepo().auth(email);
                final role = data["data"]["user"]["roles"][0];
                Navigator.pushNamedAndRemoveUntil(
                    context,
                    role == "role_employer"
                        ? EmployerHomePage.routeName
                        : EmployeeHomePage.routeName,
                    (route) => false);
              }
            },
            btnColor: MyColor.kSuccessColor);
      } else {
        showCustomDialog(
            context: context,
            status: Image.asset(
              "assets/images/close.png",
              width: 70,
            ),
            title: "Error!",
            body: body["message"],
            textButton: "Done",
            onTap: () => Navigator.pop(context),
            btnColor: MyColor.kErrorColor);
      }
    },
  );
}

void showCustomDialog(
        {required BuildContext context,
        bool barierDismissible = true,
        required Widget status,
        required String title,
        required String body,
        required String textButton,
        required VoidCallback onTap,
        required Color btnColor}) =>
    showDialog(
      barrierDismissible: barierDismissible,
      context: context,
      builder: (_) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
        child: AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          content: Container(
            padding: const EdgeInsets.only(top: 48),
            height: 185,
            child: Column(
              children: [
                status,
                const SizedBox(height: 13),
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      fontFamily: "sfPro"),
                ),
                const SizedBox(height: 5),
                Expanded(
                  child: Text(
                    body,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: kgreyColor, fontSize: 14, fontFamily: "sfPro"),
                  ),
                ),
              ],
            ),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: InkWell(
                customBorder: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                onTap: onTap,
                child: Ink(
                  // width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    color: btnColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      textButton,
                      style: const TextStyle(
                          fontSize: 16, color: white, fontFamily: "sfPro"),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
