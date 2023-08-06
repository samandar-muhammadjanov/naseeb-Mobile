// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:naseeb/blocs/bloc_imports.dart';
import 'package:naseeb/presentation/pages/employee/details/indside_post_page.dart';
import 'package:naseeb/presentation/widgets/w_loading.dart';
import 'package:naseeb/utils/colors.dart';

class EmployeeSavedPage extends StatelessWidget {
  const EmployeeSavedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Saved Posts",
          style: TextStyle(
              fontWeight: FontWeight.w700, fontSize: 18, fontFamily: "sfPro"),
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
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16),
      itemCount: state.favorites.posts.length,
      separatorBuilder: (context, index) => const SizedBox(
        height: 10,
      ),
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: kgreyColor.withOpacity(.2))),
          child: Column(
            children: [
              ListTile(
                onTap: () => Navigator.pushNamed(
                    context, InsidePostForEmployeePage.routeName),
                contentPadding: EdgeInsets.zero,
                trailing: IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    "assets/svg/bookmark-filled.svg",
                    color: kprimaryColor,
                  ),
                ),
                title: const Text(
                  "Mexanik kerak",
                  style: TextStyle(
                      fontWeight: FontWeight.w700, fontFamily: "sfPro"),
                ),
                subtitle: const Text(
                  "500 000 so'm",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: kgreyColor,
                      fontFamily: "sfPro"),
                ),
              ),
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15), color: kgreyColor),
                child: const Icon(
                  Icons.image,
                  color: white,
                  size: 40,
                ),
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
                  Navigator.pushNamed(
                      context, InsidePostForEmployeePage.routeName);
                },
                child: const Text(
                  'View Post',
                  style: TextStyle(
                    fontSize: 10,
                    fontFamily: "sfPro",
                    fontWeight: FontWeight.w500,
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
