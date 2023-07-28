// ignore_for_file: deprecated_member_use

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:naseeb/config/app_theme.dart';
import 'package:naseeb/domain/repositories/auth_repo/auth_repo.dart';
import 'package:naseeb/utils/colors.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});
  static const routeName = "/auth";

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isFocused = false;
  bool isLoading = false;
  var maskFormatter = MaskTextInputFormatter(
      mask: '+998 ## ### ## ##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController authController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        ThemeModelInheritedNotifier.of(context).theme == AppTheme.darkTheme;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            SystemNavigator.pop();
          },
          icon: SvgPicture.asset(
            "assets/svg/Arrow---Left.svg",
            color: isDarkMode ? white : black,
          ),
        ),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Authentication",
                  style: TextStyle(
                      color: isDarkMode ? white : const Color(0xff1F1F39),
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      fontFamily: "sfPro"),
                ),
              ),
              const SizedBox(
                height: 27,
              ),
              const Text(
                'Enter your email',
                style: TextStyle(color: kgreyColor, fontFamily: "sfPro"),
              ),
              const SizedBox(
                height: 14,
              ),
              TextFormField(
                validator: (value) =>
                    EmailValidator.validate(value!) ? null : "Not Valid Email",
                keyboardType: TextInputType.emailAddress,
                controller: authController,
                onTap: () => setState(() => isFocused = true),
                onFieldSubmitted: (va) => setState(() => isFocused = false),
                style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    fontFamily: "sfPro"),
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        color: kgreyColor,
                      ),
                    ),
                    fillColor: fieldFocusColor.withOpacity(isDarkMode ? .2 : 1),
                    filled: isFocused),
              ),
              const Spacer(),
              InkWell(
                borderRadius: BorderRadius.circular(15),
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    Hive.box("authData")
                        .put('email', authController.text);
                    loading();
                  }
                },
                child: Ink(
                  height: 56,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: const Color(0xff3498DB),
                      borderRadius: BorderRadius.circular(15)),
                  child: Center(
                    child: isLoading
                        ? const SpinKitPulse(
                            color: white,
                          )
                        : const Text(
                            "Continue",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: white,
                                fontFamily: "sfPro"),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  loading() {
    setState(() {
      isLoading = true;
    });
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
      AuthRepo.codeSend(authController.text, context);
    });
  }
}
