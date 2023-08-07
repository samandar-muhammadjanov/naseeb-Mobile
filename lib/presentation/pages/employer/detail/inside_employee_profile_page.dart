// ignore_for_file: deprecated_member_use, unnecessary_null_comparison

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:naseeb/blocs/bloc_imports.dart';
import 'package:naseeb/config/app_theme.dart';
import 'package:naseeb/domain/models/get_employee_model.dart';
import 'package:naseeb/presentation/pages/employer/detail/resume_item.dart';
import 'package:naseeb/presentation/pages/single_screens/chat_inside_page.dart';
import 'package:naseeb/utils/colors.dart';

class InsideEmployeeProfilePage extends StatelessWidget {
  const InsideEmployeeProfilePage({super.key, this.state});
  final EmployeeDatum? state;
  static const routeName = '/employer/inside-employee';
  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        ThemeModelInheritedNotifier.of(context).theme == AppTheme.darkTheme;
    return Scaffold(
        body: Body(item: state!),
        bottomNavigationBar: BottomBar(isDarkMode: isDarkMode));
  }
}

class BottomBar extends StatelessWidget {
  const BottomBar({
    super.key,
    required this.isDarkMode,
  });

  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmployerBloc, EmployerState>(
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
                              height: MediaQuery.of(context).size.height * 0.3,
                              decoration: BoxDecoration(
                                  color: isDarkMode
                                      ? const Color(0xff2b2d3a)
                                      : white,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
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
                                    state.employee!.data.registerResponse.phone,
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
                                            MediaQuery.of(context).size.width *
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
                    Navigator.pushNamed(context, ChatInsidePage.routeName);
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
    );
  }
}

class Body extends StatelessWidget {
  const Body({super.key, required this.item});
  final EmployeeDatum item;
  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        ThemeModelInheritedNotifier.of(context).theme == AppTheme.darkTheme;

    final bornYear = DateTime.now().year - item.registerResponse.bornYear.year;
    return Scaffold(
        appBar: AppBar(
          actions: [
            BlocBuilder<FavoritesBloc, FavoriteState>(
              builder: (context, state) {
                if (state is FavoritesLoaded) {
                  bool isFavorite(int postId) {
                    return state.favorites.employee.any((element) {
                      return element.id == postId;
                    });
                  }

                  return IconButton(
                    onPressed: () {
                      isFavorite(item.id)
                          ? context
                              .read<FavoritesBloc>()
                              .add(RemoveFavoriteEmployee(item))
                          : context
                              .read<FavoritesBloc>()
                              .add(AddFavoriteEmployee(item));
                    },
                    icon: SvgPicture.asset(
                      !isFavorite(item.id)
                          ? "assets/svg/bookmark.svg"
                          : "assets/svg/bookmark-filled.svg",
                      color: kprimaryColor,
                    ),
                  );
                } else {
                  return SvgPicture.asset("assets/svg/bookmark.svg");
                }
              },
            )
          ],
          centerTitle: true,
          title: Container(
            height: 22,
            width: 96,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: item.registerResponse.active == "true"
                    ? fieldFocusColor.withOpacity(isDarkMode ? .2 : 1)
                    : MyColor.salartBackground,
                borderRadius: const BorderRadius.all(Radius.circular(6))),
            child: Center(
              child: Text(
                item.registerResponse.active == "true"
                    ? "Active job finding"
                    : "Not Active",
                style: TextStyle(
                    color: isDarkMode
                        ? white
                        : item.registerResponse.active == "true"
                            ? kprimaryColor
                            : MyColor.salary,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    overflow: TextOverflow.ellipsis,
                    fontFamily: "sfPro"),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              item.registerResponse.responseFile != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        item.registerResponse.responseFile.url,
                        fit: BoxFit.cover,
                        height: 344,
                        width: double.infinity,
                      ),
                    )
                  : const SizedBox(
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
              item.salaryResponse == null
                  ? const SizedBox()
                  : WSalary(item: item)
            ],
          ),
        ));
  }
}
