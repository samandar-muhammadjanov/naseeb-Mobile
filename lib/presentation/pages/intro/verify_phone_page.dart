import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:naseeb/presentation/pages/intro/select_role_page.dart';
import 'package:naseeb/presentation/widgets/w_button.dart';
import 'package:naseeb/utils/colors.dart';
import 'package:pinput/pinput.dart';

class VerifyPhonePage extends StatefulWidget {
  const VerifyPhonePage(
      {super.key, required this.phoneNumber, required this.code});
  static const routeName = "/auth/verify";
  final String phoneNumber;
  final String code;
  @override
  State<VerifyPhonePage> createState() => _VerifyPhonePageState();
}

class _VerifyPhonePageState extends State<VerifyPhonePage> {
  bool isVerifying = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: SvgPicture.asset("assets/svg/Arrow---Left.svg")),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Center(
                child: Text(
                  "Verify Phone",
                  style: TextStyle(
                      color: Color(0xff1F1F39),
                      fontSize: 28,
                      fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              Text(
                "Code is sent to ${widget.phoneNumber}",
                style: const TextStyle(color: kgreyColor),
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
                preFilledWidget: const Text('0'),
                separator: const SizedBox(width: 21),
                autofocus: true,
                length: 5,
                onCompleted: (value) async {
                  showVerifyDialog(context);
                },
                focusedPinTheme: PinTheme(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    height: 65,
                    width: 57,
                    decoration: BoxDecoration(
                        color: fieldFocusColor,
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
                onTap: () {},
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
                  showVerifyDialog(context);
                }
              }, "Verify and Continue")
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> showVerifyDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          Future.delayed(const Duration(seconds: 2), () {
            if (mounted) {
              setState(() {
                isVerifying = true;
              });
            }
          });
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
            child: AlertDialog(
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              contentPadding: EdgeInsets.zero,
              title: isVerifying
                  ? SvgPicture.asset("assets/svg/success.svg")
                  : const SpinKitCircle(
                      color: korangeColor,
                      size: 70,
                    ),
              content: SizedBox(
                height: 82,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 13,
                    ),
                    Text(
                      isVerifying ? "Success" : "Verifying",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff1F1F39),
                      ),
                    ),
                    const SizedBox(
                      height: 9,
                    ),
                    Text(
                      isVerifying
                          ? "Congratulations, you have\ncompleted your registration!"
                          : "Verifying your phone",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xff858597),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 36),
                  child: wButton(() {
                    if (isVerifying) {
                      Navigator.pushNamedAndRemoveUntil(
                          context, SelectRolePage.routeName, (route) => false);
                    }
                  }, "Done",
                      color: isVerifying ? MyColor.kSuccessColor : kgreyColor),
                )
              ],
            ),
          );
        });
      },
    );
  }
}
