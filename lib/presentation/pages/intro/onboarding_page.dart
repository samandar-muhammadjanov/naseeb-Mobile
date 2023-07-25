import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:naseeb/presentation/pages/intro/auth_page.dart';
import 'package:naseeb/presentation/widgets/w_button.dart';
import 'package:naseeb/utils/colors.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});
  static const routeName = '/onboarding';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            SvgPicture.asset("assets/svg/onboarding.svg"),
            const SizedBox(
              height: 20,
            ),
            RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                style: TextStyle(
                    fontFamily: "sfPro",
                    color: Color(0xff171725),
                    fontSize: 28,
                    fontWeight: FontWeight.w700),
                children: [
                  TextSpan(text: "The best app to find\n"),
                  TextSpan(
                      text: " Your Dream Job",
                      style: TextStyle(color: kprimaryColor))
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Lorem ipsum dolor sit amet, consectetur\nadipiscing elit. Ut et massa mi.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xff9CA4AB)),
            ),
            const Spacer(),
            wButton(() {
              Navigator.pushNamedAndRemoveUntil(
                  context, AuthPage.routeName, (route) => false);
            }, "Get started"),
            const SizedBox(
              height: 81 / 2,
            )
          ],
        ),
      ),
    );
  }
}
