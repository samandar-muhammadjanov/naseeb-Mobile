// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:naseeb/blocs/bloc_imports.dart';
import 'package:naseeb/presentation/pages/employer/detail/inside_employee_profile_page.dart';
import 'package:naseeb/presentation/widgets/w_indicator.dart';
import 'package:naseeb/presentation/widgets/w_loading.dart';
import 'package:naseeb/utils/colors.dart';
import 'package:naseeb/utils/utils.dart';

class EmployerSearchPage extends StatefulWidget {
  const EmployerSearchPage({super.key});

  @override
  State<EmployerSearchPage> createState() => _EmployerSearchPageState();
}

class _EmployerSearchPageState extends State<EmployerSearchPage> {
  RangeValues values = const RangeValues(1, 10);

  final labels = ['0', '15', '25', '45', '65', '85', '100'];

  Widget buildLabel({
    required String label,
    required Color color,
  }) =>
      Text(
        label,
        textAlign: TextAlign.center,
        style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, fontFamily: "sfPro")
            .copyWith(color: color),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Search",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18,
            fontFamily: "sfPro",
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size(double.infinity, 80),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 18),
                child: Text(
                  "Select Radius (km)",
                  style: TextStyle(
                      fontSize: 16,
                      color: kgreyColor,
                      fontWeight: FontWeight.w700,
                      fontFamily: "sfPro"),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: Utils.modelBuilder(
                        labels,
                        (index, label) {
                          const selectedColor = Colors.black;
                          final unselectedColor = Colors.black.withOpacity(0.3);
                          final isSelected =
                              index >= values.start && index <= values.end;
                          final color =
                              isSelected ? selectedColor : unselectedColor;

                          return buildLabel(label: label, color: color);
                        },
                      ),
                    ),
                  ),
                  RangeSlider(
                      values: values,
                      min: 0,
                      max: 100,
                      divisions: 10,
                      onChanged: (value) {
                        setState(() {
                          this.values = value;
                        });
                        context.read<EmployerBloc>()
                          ..add(GetEmployees(4, value.end.toStringAsFixed(0)));
                      }),
                ],
              )
            ],
          ),
        ),
      ),
      body: BlocProvider(
        create: (context) => EmployerBloc()..add(GetEmployees(4, 10)),
        child:
            BlocBuilder<EmployerBloc, EmployerState>(builder: (context, state) {
          if (state is EmployerInitial) {
            return buildLoading();
          } else if (state is EmployerLoading) {
            return buildLoading();
          } else if (state is EmployerLoaded) {
            return _buildEmployees(context, state);
          } else if (state is EmployerError) {
            return Center(child: Text(state.error));
          } else {
            return buildLoading();
          }
        }),
      ),
    );
  }

  Widget _buildEmployees(BuildContext context, EmployerLoaded state) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16),
      itemCount: state.employees.data.length,
      separatorBuilder: (context, index) => const SizedBox(
        height: 10,
      ),
      itemBuilder: (context, index) {
        final item = state.employees.data[index];
        final experienceYear = item.experienceResponses.isEmpty
            ? ''
            : item.experienceResponses[0].end.year -
                item.experienceResponses[0].begin.year;
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: kgreyColor.withOpacity(.2),
            ),
          ),
          child: Column(
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: kgreyColor),
                  child: item.registerResponse.responseFile != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(
                            item.registerResponse.responseFile["url"],
                            fit: BoxFit.cover,
                          ),
                        )
                      : const Icon(
                          Icons.image,
                          color: white,
                        ),
                ),
                title: Text(
                  "${item.registerResponse.firstName} ${item.registerResponse.lastName}",
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      fontFamily: "sfPro"),
                ),
                subtitle: Text(
                  item.categoryResponse.nameUz,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: kgreyColor,
                      fontFamily: "sfPro"),
                ),
                trailing: IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    "assets/svg/bookmark.svg",
                    color: kprimaryColor,
                  ),
                ),
              ),
              Row(
                children: [
                  item.experienceResponses.isEmpty
                      ? const SizedBox()
                      : StatusIndicator(
                          background: fieldFocusColor,
                          text: item.experienceResponses[0].asWho,
                          textColor: kprimaryColor,
                        ),
                  const SizedBox(
                    width: 5,
                  ),
                  StatusIndicator(
                      background: MyColor.typeBk,
                      text: item.workType,
                      textColor: MyColor.type),
                  const SizedBox(
                    width: 5,
                  ),
                  item.experienceResponses.isEmpty
                      ? const SizedBox()
                      : StatusIndicator(
                          background: MyColor.experienceBackground,
                          text: "${experienceYear} years",
                          textColor: MyColor.experience),
                  const SizedBox(
                    width: 5,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  StatusIndicator(
                      background: MyColor.salartBackground,
                      text: "\$${item.salaryResponse.money.toStringAsFixed(0)}",
                      textColor: MyColor.salary),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                item.description,
                style: const TextStyle(color: kgreyColor, fontFamily: "sfPro"),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: kprimaryColor,
                  elevation: 0,
                  minimumSize: const Size(double.infinity, 30),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => InsideEmployeeProfilePage(
                          id: item.id.toString(),
                        ),
                      ));
                },
                child: const Text(
                  'View Profile',
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      fontFamily: "sfPro"),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
