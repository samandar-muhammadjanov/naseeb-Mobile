// ignore_for_file: must_be_immutable, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:naseeb/blocs/bloc_imports.dart';
import 'package:naseeb/presentation/pages/employee/details/category_page.dart';
import 'package:naseeb/presentation/pages/employee/details/certificates_page.dart';
import 'package:naseeb/presentation/pages/employee/details/education_page.dart';
import 'package:naseeb/presentation/pages/employee/details/language_page.dart';
import 'package:naseeb/presentation/pages/employee/details/salary_page.dart';
import 'package:naseeb/presentation/pages/employee/details/work_experience_page.dart';
import 'package:naseeb/presentation/widgets/w_loading.dart';
import 'package:naseeb/utils/colors.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'main_information_page.dart';

class CreateCVPage extends StatelessWidget {
  CreateCVPage({super.key});
  static const routeName = "routeName";
  var box = Hive.box("authData").get("employeeId");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Profile Settings",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            fontFamily: "sfPro",
          ),
        ),
      ),
      body: BlocProvider(
        create: (context) =>
            EmployerBloc()..add(GetEmployeeById(box.toString())),
        child: BlocBuilder<EmployerBloc, EmployerState>(
          builder: (context, state) {
            if (state is EmployerInitial) {
              return buildLoading();
            } else if (state is EmployerLoading) {
              return buildLoading();
            } else if (state is EmployeeDetailLoaded) {
              return buildBody(context, state);
            } else if (state is EmployerError) {
              return Center(
                child: Text(state.error),
              );
            } else {
              return buildLoading();
            }
          },
        ),
      ),
    );
  }

  Column buildBody(BuildContext context, EmployeeDetailLoaded state) {
    final item = state.employee!.data;
    List<Map<String, dynamic>> items = [
      {
        "icon": 'assets/svg/main_info.svg',
        "title": "Main information",
        "routeName": MainInformationPage()
      },
      {
        "icon": 'assets/svg/work_experience.svg',
        "title": "Work experience",
        "routeName": WorkExperiencePage()
      },
      {
        "icon": 'assets/svg/education.svg',
        "title": "Education",
        "routeName": EducationPage()
      },
      {
        "icon": 'assets/svg/language.svg',
        "title": "Language",
        "routeName": LanguagePage()
      },
      {
        "icon": 'assets/svg/certificate.svg',
        "title": "Certificates",
        "routeName": CertificatesPage()
      },
      {
        "icon": 'assets/svg/salary.svg',
        "title": "Salary",
        "routeName": SalaryPage()
      },
      {
        "icon": 'assets/svg/category.svg',
        "title": "Category",
        "routeName": CategoryPage(),
      },
    ];

    double? persentOfComplation = item.languagesResponse.isEmpty &&
            item.experienceResponses.isEmpty &&
            item.educationResponse.isEmpty &&
            item.certificateFile.isEmpty &&
            item.sampleFile.isEmpty
        ? 0.2
        : item.experienceResponses.isEmpty &&
                item.educationResponse.isEmpty &&
                item.certificateFile.isEmpty &&
                item.sampleFile.isEmpty
            ? 0.45
            : item.educationResponse.isEmpty &&
                    item.certificateFile.isEmpty &&
                    item.sampleFile.isEmpty
                ? 0.65
                : item.certificateFile.isEmpty && item.sampleFile.isEmpty
                    ? 0.85
                    : 1;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${(persentOfComplation * 100).toStringAsFixed(0)} %',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  fontFamily: "sfPro",
                ),
              ),
              const Text(
                'Complete your profile',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  fontFamily: "sfPro",
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        LinearPercentIndicator(
          width: MediaQuery.of(context).size.width,
          lineHeight: 10.0,
          percent: persentOfComplation,
          animationDuration: 1000,
          animation: true,
          barRadius: const Radius.circular(15),
          backgroundColor: lightGrey,
          progressColor: kprimaryColor,
        ),
        ListView.separated(
          physics: const BouncingScrollPhysics(),
          separatorBuilder: (context, index) => const SizedBox(
            height: 10,
          ),
          padding: const EdgeInsets.all(16),
          shrinkWrap: true,
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return ListTile(
              onTap: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => item['routeName'],
                    ));
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: const BorderSide(color: kgreyColor)),
              leading: SvgPicture.asset(
                item['icon'],
                width: item["icon"] == "assets/svg/salary.svg" ? 14 : 24,
                color: kprimaryColor,
              ),
              title: Text(
                item['title'],
                style: const TextStyle(
                  fontFamily: "sfPro",
                ),
              ),
              trailing: SvgPicture.asset("assets/svg/Add.svg"),
            );
          },
        )
      ],
    );
  }
}
