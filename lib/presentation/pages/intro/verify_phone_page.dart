// ignore_for_file: deprecated_member_use

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:naseeb/config/app_theme.dart';
import 'package:naseeb/domain/repositories/auth_repo/auth_repo.dart';
import 'package:naseeb/presentation/widgets/w_button.dart';
import 'package:naseeb/utils/colors.dart';
import 'package:pinput/pinput.dart';

class VerifyPhonePage extends StatefulWidget {
  const VerifyPhonePage(
      {super.key,
      required this.phoneNumber,
      required this.code,
      required this.user});
  static const routeName = "/auth/verify";
  final String phoneNumber;
  final String code;
  final String user;
  @override
  State<VerifyPhonePage> createState() => _VerifyPhonePageState();
}

class _VerifyPhonePageState extends State<VerifyPhonePage> {
  bool isVerifying = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController codeController = TextEditingController();
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 4),
            content: Text("Your code ${widget.code}"),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        ThemeModelInheritedNotifier.of(context).theme == AppTheme.darkTheme;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: SvgPicture.asset(
              "assets/svg/Arrow---Left.svg",
              color: isDarkMode ? white : black,
            )),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Center(
                child: Text(
                  "Verify Phone",
                  style: TextStyle(
                      color: isDarkMode ? white : const Color(0xff1F1F39),
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      fontFamily: "sfPro"),
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              Text(
                "Code is sent to ${widget.phoneNumber}",
                style: const TextStyle(color: kgreyColor, fontFamily: "sfPro"),
              ),
              const SizedBox(
                height: 35.8,
              ),
              Pinput(
                validator: (value) {
                  if (value!.isEmpty || value.length < 5) {
                    return "Not valid phone number";
                  }
                  return null;
                },
                controller: codeController,
                preFilledWidget: const Text(
                  '0',
                  style: TextStyle(fontFamily: "sfPro"),
                ),
                separator: const SizedBox(width: 21),
                autofocus: true,
                length: 5,
                onCompleted: (value) async {
                  // showVerifyDialog(context);
                  AuthRepo.codeVerify(widget.phoneNumber, codeController.text,
                      context, widget.user);
                },
                focusedPinTheme: PinTheme(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    height: 65,
                    width: 57,
                    decoration: BoxDecoration(
                        color: fieldFocusColor.withOpacity(isDarkMode ? .2 : 1),
                        border: Border.all(color: kprimaryColor),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(17)))),
                defaultPinTheme: PinTheme(
                  height: 65,
                  width: 57,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: kgreyColor,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(17),
                    ),
                  ),
                ),
                androidSmsAutofillMethod:
                    AndroidSmsAutofillMethod.smsUserConsentApi,
              ),
              const SizedBox(
                height: 28.42,
              ),
              GestureDetector(
                onTap: () {
                  AuthRepo.resendCode(widget.phoneNumber, context);
                },
                child: SizedBox(
                  height: 30,
                  child: Center(
                    child: RichText(
                      text: const TextSpan(
                        style: TextStyle(
                            color: kgreyColor,
                            fontSize: 16,
                            fontFamily: 'sfPro'),
                        children: [
                          TextSpan(text: "Didn't recieve code? "),
                          TextSpan(
                              text: "Resend Code",
                              style: TextStyle(color: kprimaryColor))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              wButton(() {
                if (formKey.currentState!.validate()) {
                  AuthRepo.codeVerify(widget.phoneNumber, codeController.text,
                      context, widget.user);
                }
              }, "Verify and Continue")
            ],
          ),
        ),
      ),
    );
  }
}
