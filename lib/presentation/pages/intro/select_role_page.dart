import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/adapters.dart';
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
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            const Text(
              "Choose Job Type",
              style: TextStyle(
                  color: Color(0xff1F1F39),
                  fontSize: 28,
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 11,
            ),
            const Text(
              "Lorem ipsum dolor sit amet, consectetur\nadipiscing elit. Ut et massa mi.",
              textAlign: TextAlign.center,
              style: TextStyle(color: kgreyColor),
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 19, vertical: 30),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: isEmployee
                                  ? MyColor.job
                                  : const Color(0xffEEEEEE),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          children: [
                            SvgPicture.asset("assets/svg/employee.svg"),
                            const SizedBox(
                              height: 26,
                            ),
                            const Text(
                              "Find a job",
                              style: TextStyle(
                                  color: Color(0xff171725),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            const Text(
                              "Find your dream\njobs",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: kgreyColor,
                                  fontWeight: FontWeight.w400),
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 19, vertical: 30),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: !isEmployee
                                  ? MyColor.type
                                  : const Color(0xffeeeeee),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          children: [
                            SvgPicture.asset("assets/svg/employer.svg"),
                            const SizedBox(
                              height: 26,
                            ),
                            const Text(
                              "Find a employee",
                              style: TextStyle(
                                  color: Color(0xff171725),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            const Text("Find eployees\n",
                                style: TextStyle(
                                    color: kgreyColor,
                                    fontWeight: FontWeight.w400))
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            wButton(() {
              Hive.box("authData")
                  .put('role', isEmployee ? "role_employee" : "role_employer");
              Navigator.pushNamedAndRemoveUntil(
                  context, RegistrationPage.routeName, (route) => false);
            }, "Continue"),
            const SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }
}
