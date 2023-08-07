import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:naseeb/blocs/bloc_imports.dart';
import 'package:naseeb/config/app_theme.dart';
import 'package:naseeb/presentation/pages/employee/details/indside_post_page.dart';
import 'package:naseeb/presentation/widgets/w_loading.dart';
import 'package:naseeb/utils/colors.dart';
import 'package:naseeb/utils/utils.dart';

class EmployeeSearchPage extends StatefulWidget {
  const EmployeeSearchPage({super.key});

  @override
  State<EmployeeSearchPage> createState() => _EmployeeSearchPageState();
}

class _EmployeeSearchPageState extends State<EmployeeSearchPage> {
  RangeValues values = const RangeValues(1, 10);

  final labels = ['0', '15', '25', '45', '65', '85', '100'];
  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        ThemeModelInheritedNotifier.of(context).theme == AppTheme.darkTheme;
    return BlocProvider(
      create: (context) =>
          EmployerBloc()..add(GetPostsForEmployee(15.toString())),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Search",
            style: TextStyle(
                fontWeight: FontWeight.w700, fontSize: 18, fontFamily: 'sfPro'),
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
                                if (state is PostsForEmployeeLoaded) {
                                  context.read<EmployerBloc>().add(
                                      GetPostsForEmployee(
                                          value.end.toStringAsFixed(0)));
                                }
                              });
                            });
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        body: BlocBuilder<EmployerBloc, EmployerState>(
          builder: (context, state) {
            print(state);
            if (state is PostsForEmployeeLoaded) {
              return Body(
                state: state,
              );
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
}

class Body extends StatelessWidget {
  const Body({
    super.key,
    required this.state,
  });
  final PostsForEmployeeLoaded state;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      physics: const BouncingScrollPhysics(),
      itemCount: state.posts.data.length,
      separatorBuilder: (context, index) => const SizedBox(
        height: 10,
      ),
      itemBuilder: (context, index) {
        final item = state.posts.data[index];
        final money = item.amountMoney.nameCode == "UZS"
            ? "so'm"
            : item.amountMoney.nameCode == "USD"
                ? "\$"
                : "₽";
        return Container(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: kgreyColor.withOpacity(.2),
            ),
          ),
          child: Column(
            children: [
              ListTile(
                onTap: () => Navigator.pushNamed(
                    context, InsidePostForEmployeePage.routeName),
                contentPadding: EdgeInsets.zero,
                trailing: BlocBuilder<FavoritesBloc, FavoriteState>(
                  builder: (context, state) {
                    if (state is FavoritesLoaded) {
                      bool isFavorite(int postId) {
                        return state.favorites.posts.any((element) {
                          return element.id == postId;
                        });
                      }

                      return IconButton(
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
                      );
                    } else {
                      return SvgPicture.asset("assets/svg/bookmark.svg");
                    }
                  },
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
                  ))
            ],
          ),
        );
      },
    );
  }
}
