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
    if (state.favorites.posts.isEmpty) {
      return const Center(
        child: Text(
          "Sizda saqlangan e'lonlar mavjud emas",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'sfPro'),
        ),
      );
    }
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16),
      itemCount: state.favorites.posts.length,
      separatorBuilder: (context, index) => const SizedBox(
        height: 10,
      ),
      itemBuilder: (context, index) {
        final item = state.favorites.posts[index];
        final money = item.amountMoney.nameCode == "UZS"
            ? "so'm"
            : item.amountMoney.nameCode == "USD"
                ? "\$"
                : "₽";
        bool isFavorite(int postId) {
          return state.favorites.posts.any((element) {
            return element.id == postId;
          });
        }

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
                  onPressed: () {
                    isFavorite(item.id)
                        ? context
                            .read<FavoritesBloc>()
                            .add(RemoveFavoritePost(item))
                        : context
                            .read<FavoritesBloc>()
                            .add(AddFavoritePost(item));
                  },
                  icon: SvgPicture.asset(
                    !isFavorite(item.id)
                        ? "assets/svg/bookmark.svg"
                        : "assets/svg/bookmark-filled.svg",
                    color: kprimaryColor,
                  ),
                ),
                title: Text(
                  item.description,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, fontFamily: "sfPro"),
                ),
                subtitle: Text(
                  "${item.amountMoney.money.toStringAsFixed(0)} $money",
                  style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: kgreyColor,
                      fontFamily: "sfPro"),
                ),
              ),
              if (item.responseFiles.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    item.responseFiles.first.url,
                    height: 180,
                    fit: BoxFit.cover,
                  ),
                )
              else
                const SizedBox(),
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
                      builder: (context) => InsidePostForEmployeePage(
                        item: item,
                      ),
                    ),
                  );
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
