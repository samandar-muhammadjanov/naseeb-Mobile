import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:naseeb/config/app_theme.dart';
import 'package:naseeb/presentation/pages/intro/registration_page.dart';
import 'package:naseeb/presentation/widgets/w_button.dart';
import 'package:naseeb/utils/colors.dart';

class SelectRolePage extends StatefulWidget {
  const SelectRolePage({super.key});
  static const routeName = '/select-role';

  @override
  State<SelectRolePage> createState() => _SelectRolePageState();
}

class _SelectRolePageState extends State<SelectRolePage> {
  bool isEmployee = true;
  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        ThemeModelInheritedNotifier.of(context).theme == AppTheme.darkTheme;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Text(
              "chooseJob".tr(),
              style: TextStyle(
                  color: isDarkMode ? white : const Color(0xff1F1F39),
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  fontFamily: "sfPro"),
            ),
            const SizedBox(
              height: 11,
            ),
            const Text(
              "Lorem ipsum dolor sit amet, consectetur\nadipiscing elit. Ut et massa mi.",
              textAlign: TextAlign.center,
              style: TextStyle(color: kgreyColor, fontFamily: "sfPro"),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          isEmployee = true;
                        });
                      },
                      child: Container(
                        height: 216,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 19, vertical: 30),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: isEmployee
                                  ? MyColor.job
                                  : const Color(0xffEEEEEE)
                                      .withOpacity(isDarkMode ? .2 : 1),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          children: [
                            SvgPicture.asset("assets/svg/employee.svg"),
                            const SizedBox(
                              height: 26,
                            ),
                            Text(
                              "findJob".tr(),
                              style: TextStyle(
                                  color: isDarkMode
                                      ? white
                                      : const Color(0xff171725),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "sfPro"),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Text(
                              "findDreamJob".tr(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: kgreyColor,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "sfPro"),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          isEmployee = false;
                        });
                      },
                      child: Container(
                        height: 216,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 19, vertical: 30),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: !isEmployee
                                  ? MyColor.type
                                  : const Color(0xffeeeeee)
                                      .withOpacity(isDarkMode ? .2 : 1),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          children: [
                            SvgPicture.asset("assets/svg/employer.svg"),
                            const SizedBox(
                              height: 26,
                            ),
                            Text(
                              "findEmployee".tr(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: isDarkMode
                                      ? white
                                      : const Color(0xff171725),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "sfPro"),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Expanded(
                              child: Text("findEmployee".tr(),
                                  style: const TextStyle(
                                      color: kgreyColor,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "sfPro")),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: wButton(() {
                Hive.box("authData").put(
                    'role', isEmployee ? "role_employee" : "role_employer");
                Navigator.pushNamedAndRemoveUntil(
                    context, RegistrationPage.routeName, (route) => false);
              }, "Continue"),
            ),
            const SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }
}
