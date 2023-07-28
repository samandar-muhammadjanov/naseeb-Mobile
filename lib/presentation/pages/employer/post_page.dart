import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:naseeb/blocs/bloc_imports.dart';
import 'package:naseeb/config/app_theme.dart';
import 'package:naseeb/presentation/pages/employer/detail/add_post_page.dart';
import 'package:naseeb/presentation/pages/employer/detail/inside_post_page.dart';
import 'package:naseeb/presentation/widgets/w_loading.dart';
import 'package:naseeb/utils/colors.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        ThemeModelInheritedNotifier.of(context).theme == AppTheme.darkTheme;
    return BlocProvider(
      create: (context) => EmployerBloc()..add(GetAllPosts()),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Add Posts",
            style: TextStyle(
                fontWeight: FontWeight.w700, fontSize: 18, fontFamily: "sfPro"),
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              BlocBuilder<EmployerBloc, EmployerState>(
                builder: (context, state) {
                  if (state is EmployerInitial) {
                    return buildLoading();
                  } else if (state is EmployerLoading) {
                    return buildLoading();
                  } else if (state is AllPostsLoaded) {
                    return buildPosts(context, state);
                  } else if (state is EmployerError) {
                    return Text(state.error);
                  } else {
                    return buildLoading();
                  }
                },
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
                          color:
                              fieldFocusColor.withOpacity(isDarkMode ? .2 : 1),
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
        ),
      ),
    );
  }

  ListView buildPosts(BuildContext context, AllPostsLoaded state) {
    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(
        height: 10,
      ),
      itemCount: state.posts.data.length,
      shrinkWrap: true,
      padding: const EdgeInsets.all(16),
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        final item = state.posts.data[index];
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
                onTap: () =>
                    Navigator.pushNamed(context, InsidePostPage.routeName),
                contentPadding: EdgeInsets.zero,
                trailing: SizedBox(
                  width: 96,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Image.asset(
                          "assets/images/trash.png",
                          color: kprimaryColor,
                          width: 30,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: SvgPicture.asset(
                          "assets/svg/edit.svg",
                          color: kprimaryColor,
                          width: 30,
                        ),
                      ),
                    ],
                  ),
                ),
                title: Text(
                  item.categoryDto.nameUz,
                  style: const TextStyle(
                      fontFamily: "sfPro", fontWeight: FontWeight.w700),
                ),
                subtitle: Text(
                  "${item.amountMoney}\$",
                  style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: kgreyColor,
                      fontFamily: "sfPro"),
                ),
              ),
              item.responseFiles.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        item.responseFiles[0].url,
                        fit: BoxFit.cover,
                        height: 200,
                        width: double.infinity,
                      ),
                    )
                  : const SizedBox(),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kprimaryColor,
                    elevation: 0,
                    minimumSize: const Size(double.infinity, 30),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, InsidePostPage.routeName);
                  },
                  child: const Text(
                    'View Post',
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        fontFamily: "sfPro"),
                  ))
            ],
          ),
        );
      },
    );
  }
}
