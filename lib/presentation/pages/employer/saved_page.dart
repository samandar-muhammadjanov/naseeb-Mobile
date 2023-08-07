// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:naseeb/blocs/bloc_imports.dart';
import 'package:naseeb/presentation/pages/employer/detail/inside_employee_profile_page.dart';
import 'package:naseeb/presentation/widgets/w_indicator.dart';
import 'package:naseeb/presentation/widgets/w_loading.dart';
import 'package:naseeb/utils/colors.dart';

class EmployerSavedPage extends StatelessWidget {
  const EmployerSavedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Liked Workers",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18,
            fontFamily: "sfPro",
          ),
        ),
      ),
      body: BlocBuilder<FavoritesBloc, FavoriteState>(
        builder: (context, state) {
          if (state is FavoritesLoading) {
            return buildLoading();
          } else if (state is FavoritesLoaded) {
            return Body(
              state: state,
            );
          } else if (state is FavoritesError) {
            return Center(
              child: Text(state.error),
            );
          } else {
            return buildLoading();
          }
        },
      ),
    );
  }
}

class Body extends StatelessWidget {
  const Body({
    super.key,
    required this.state,
  });
  final FavoritesLoaded state;
  @override
  Widget build(BuildContext context) {
    if (state.favorites.employee.isEmpty) {
      return const Center(
        child: Text(
          "Sizda saqlangan xodimlar mavjud emas",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'sfPro'),
        ),
      );
    }
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16),
      itemCount: state.favorites.employee.length,
      separatorBuilder: (context, index) => const SizedBox(
        height: 10,
      ),
      itemBuilder: (context, index) {
        final item = state.favorites.employee[index];
        final experienceYear = item.experienceResponses.isEmpty
            ? ''
            : item.experienceResponses.first.end.year -
                item.experienceResponses.first.begin.year;
        bool isFavorite(int postId) {
          return state.favorites.employee.any((element) {
            return element.id == postId;
          });
        }

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
                leading: item.registerResponse.responseFile == null
                    ? null
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          item.registerResponse.responseFile["url"],
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
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
