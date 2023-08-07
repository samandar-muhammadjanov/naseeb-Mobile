// ignore_for_file: deprecated_member_use, unnecessary_this, avoid_single_cascade_in_expression_statements, unnecessary_null_comparison

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:naseeb/blocs/bloc_imports.dart';
import 'package:naseeb/config/app_theme.dart';
import 'package:naseeb/presentation/pages/employer/detail/add_post_page.dart';
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

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        ThemeModelInheritedNotifier.of(context).theme == AppTheme.darkTheme;
    return BlocProvider(
      create: (context) => EmployerBloc()..add(GetEmployees(1, 10)),
      child: Scaffold(
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
                            return Text(
                              label,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "sfPro")
                                  .copyWith(
                                color: isDarkMode ? white : black,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    BlocBuilder<EmployerBloc, EmployerState>(
                      builder: (context, state) {
                        return RangeSlider(
                            values: values,
                            min: 0,
                            max: 100,
                            divisions: 10,
                            onChanged: (value) {
                              setState(() {
                                this.values = value;
                              });
                              if (state is EmployerLoaded) {
                                context.read<EmployerBloc>().add(GetEmployees(
                                    1, value.end.toStringAsFixed(0)));
                              }
                            });
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        body:
            BlocBuilder<EmployerBloc, EmployerState>(builder: (context, state) {
          if (state is EmployerInitial) {
            return buildLoading();
          } else if (state is EmployerLoading) {
            return buildLoading();
          } else if (state is EmployerLoaded) {
            if (state.employees.message == "Posters inactive or not found") {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Sizda e'lon mavjud emas avval\ne'lon joylashtiring",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'sfPro'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: DottedBorder(
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(15),
                        color: kprimaryColor,
                        strokeWidth: 2,
                        child: InkWell(
                          onTap: () {
                            Navigator.pushReplacementNamed(
                                context, AddPostPage.routeName);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 50,
                            decoration: BoxDecoration(
                                color: fieldFocusColor
                                    .withOpacity(isDarkMode ? .2 : 1),
                                borderRadius: BorderRadius.circular(15)),
                            width: double.infinity,
                            child: const Text(
                              "Add Post",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: kprimaryColor,
                                  fontFamily: "sfPro"),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            } else if (state.employees.data.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset("assets/svg/notfound.svg"),
                    const Text(
                      "Xodimlar ushbu radius yoki e'loningiz bo'yicha mavjud emas!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'sfPro'),
                    ),
                  ],
                ),
              );
            } else {
              return _buildEmployees(context, state);
            }
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
            : item.experienceResponses.first.end.year -
                item.experienceResponses.first.begin.year;

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: kgreyColor.withOpacity(.2),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                trailing: BlocBuilder<FavoritesBloc, FavoriteState>(
                  builder: (context, state) {
                    if (state is FavoritesLoaded) {
                      bool isFavorite(int employeeId) {
                        return state.favorites.employee.any((element) {
                          return element.id == employeeId;
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
                ),
              ),
              Row(
                children: [
                  item.experienceResponses.isEmpty
                      ? const SizedBox()
                      : StatusIndicator(
                          background: fieldFocusColor,
                          text: item.experienceResponses.first.asWho,
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
                          text: "$experienceYear years",
                          textColor: MyColor.experience),
                  const SizedBox(
                    width: 5,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  StatusIndicator(
                      background: MyColor.salartBackground,
                      text:
                          "\$${(item.salaryResponse.money as double).toStringAsFixed(0)}",
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
                          state: item,
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
