// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:naseeb/blocs/bloc_imports.dart';
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
              decoration: const BoxDecoration(
                  color: fieldFocusColor,
                  borderRadius: BorderRadius.all(Radius.circular(6))),
              child: const Center(
                child: Text(
                  "Active job finding",
                  style: TextStyle(
                      color: kprimaryColor,
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
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(15),
                    onTap: () {},
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
            child: const Icon(
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
            style: TextStyle(
                color: kprimaryColor,
                fontSize: 28,
                fontWeight: FontWeight.w700,
                fontFamily: "sfPro"),
          ),
          Text(
            item.categoryResponse.nameUz,
            style: TextStyle(
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
          WWorkExperience(item: item),
          const SizedBox(
            height: 10,
          ),
          WEducation(
            item: item,
          ),
          const SizedBox(
            height: 10,
          ),
          WLanguage(
            item: item,
          ),
          const SizedBox(
            height: 10,
          ),
           WCertificate(item: item,),
          const SizedBox(
            height: 10,
          ),
          const WSalary()
        ],
      ),
    );
  }
}
