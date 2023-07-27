// ignore_for_file: deprecated_member_use, unnecessary_null_comparison

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:naseeb/blocs/bloc_imports.dart';
import 'package:naseeb/config/app_theme.dart';
import 'package:naseeb/presentation/pages/employer/detail/resume_item.dart';
import 'package:naseeb/presentation/pages/single_screens/chat_inside_page.dart';
import 'package:naseeb/presentation/widgets/w_loading.dart';
import 'package:naseeb/utils/colors.dart';

class InsideEmployeeProfilePage extends StatelessWidget {
  const InsideEmployeeProfilePage({super.key, this.id});
  final String? id;
  static const routeName = '/employer/inside-employee';
  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        ThemeModelInheritedNotifier.of(context).theme == AppTheme.darkTheme;
    return BlocProvider(
      create: (context) => EmployerBloc()..add(GetEmployeeById(id)),
      child: Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(
                  "assets/svg/bookmark.svg",
                  color: kprimaryColor,
                ),
              )
            ],
            centerTitle: true,
            title: Container(
              height: 22,
              width: 96,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: fieldFocusColor.withOpacity(isDarkMode ? .2 : 1),
                  borderRadius: const BorderRadius.all(Radius.circular(6))),
              child: Center(
                child: Text(
                  "Active job finding",
                  style: TextStyle(
                      color: isDarkMode ? white : kprimaryColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      overflow: TextOverflow.ellipsis,
                      fontFamily: "sfPro"),
                ),
              ),
            ),
          ),
          body: BlocBuilder<EmployerBloc, EmployerState>(
            builder: (context, state) {
              if (state is EmployerInitial) {
                return buildLoading();
              } else if (state is EmployerLoading) {
                return buildLoading();
              } else if (state is EmployeeDetailLoaded) {
                return buildBody(state);
              } else if (state is EmployerError) {
                return Center(
                  child: Text(state.error),
                );
              } else {
                return buildLoading();
              }
            },
          ),
          bottomNavigationBar: BlocBuilder<EmployerBloc, EmployerState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(15),
                        onTap: () {
                          if (state is EmployeeDetailLoaded) {
                            showCupertinoModalPopup(
                              context: context,
                              builder: (context) {
                                return Material(
                                  color: Colors.transparent,
                                  child: Container(
                                    margin: const EdgeInsets.all(16),
                                    width: double.infinity,
                                    height: MediaQuery.of(context).size.height *
                                        0.3,
                                    decoration: BoxDecoration(
                                        color: isDarkMode
                                            ? const Color(0xff2b2d3a)
                                            : white,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          'Phone Number',
                                          style: TextStyle(
                                              color: kgreyColor,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: "sfPro"),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          state.employee!.data.registerResponse
                                              .phone,
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: "sfPro"),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        ElevatedButton(
                                            onPressed: () {},
                                            style: ElevatedButton.styleFrom(
                                                minimumSize: Size(
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        .6,
                                                    50),
                                                primary: MyColor.kSuccessColor,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                shadowColor: isDarkMode
                                                    ? const Color(0xff2b2d3a)
                                                    : white,
                                                elevation: 0),
                                            child: const Text(
                                              "Call",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: "sfPro"),
                                            )),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        ElevatedButton(
                                          onPressed: () {},
                                          style: ElevatedButton.styleFrom(
                                              minimumSize: Size(
                                                  MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .6,
                                                  50),
                                              primary: Colors.yellow,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              shadowColor: isDarkMode
                                                  ? const Color(0xff2b2d3a)
                                                  : white,
                                              elevation: 0),
                                          child: const Text(
                                            "SMS",
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: black,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: "sfPro"),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        },
                        child: Ink(
                          height: 56,
                          width: 343,
                          decoration: BoxDecoration(
                              border: Border.all(color: kprimaryColor),
                              borderRadius: BorderRadius.circular(15)),
                          child: const Center(
                            child: Text(
                              "Call / SMS",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: kprimaryColor,
                                  fontFamily: "sfPro"),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(15),
                        onTap: () {
                          Navigator.pushNamed(
                              context, ChatInsidePage.routeName);
                        },
                        child: Ink(
                          height: 56,
                          width: 343,
                          decoration: BoxDecoration(
                              color: kprimaryColor,
                              borderRadius: BorderRadius.circular(15)),
                          child: const Center(
                            child: Text(
                              "Chat",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: white,
                                  fontFamily: "sfPro"),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          )),
    );
  }

  SingleChildScrollView buildBody(EmployeeDetailLoaded state) {
    final item = state.employee!.data;
    final bornYear = DateTime.now().year - item.registerResponse.bornYear.year;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 344,
            decoration: BoxDecoration(
                color: kgreyColor, borderRadius: BorderRadius.circular(15)),
            child: item.registerResponse.responseFile != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      item.registerResponse.responseFile.url,
                      fit: BoxFit.cover,
                    ),
                  )
                : const Icon(
                    Icons.image,
                    color: white,
                    size: 50,
                  ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "${item.registerResponse.firstName} ${item.registerResponse.lastName}",
            style: const TextStyle(
                color: kprimaryColor,
                fontSize: 28,
                fontWeight: FontWeight.w700,
                fontFamily: "sfPro"),
          ),
          Text(
            item.categoryResponse.nameUz,
            style: const TextStyle(
                color: kgreyColor,
                fontWeight: FontWeight.w600,
                fontFamily: "sfPro"),
          ),
          const SizedBox(
            height: 17,
          ),
          WMainInformation(
              state: item,
              title: "Main Informations",
              subtitle:
                  "${item.registerResponse.gender == "MALE" ? "Male" : "Female"} • $bornYear years old • ${item.registerResponse.address.region}",
              body: ""),
          const SizedBox(
            height: 10,
          ),
          item.experienceResponses.isEmpty
              ? const SizedBox()
              : WWorkExperience(item: item),
          SizedBox(
            height: item.educationResponse.isEmpty ? 0 : 10,
          ),
          item.educationResponse.isEmpty
              ? const SizedBox()
              : WEducation(
                  item: item,
                ),
          SizedBox(
            height: item.languagesResponse.isEmpty ? 0 : 10,
          ),
          item.languagesResponse.isEmpty
              ? const SizedBox()
              : WLanguage(
                  item: item,
                ),
          SizedBox(
            height: item.certificateFile.isEmpty ? 0 : 10,
          ),
          item.certificateFile.isEmpty
              ? const SizedBox()
              : WCertificate(
                  item: item,
                ),
          SizedBox(
            height: item.salaryResponse == null ? 0 : 10,
          ),
          item.salaryResponse == null ? const SizedBox() : WSalary(item: item)
        ],
      ),
    );
  }
}
