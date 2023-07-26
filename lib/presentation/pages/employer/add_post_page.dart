import 'dart:io';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:naseeb/config/app_theme.dart';
import 'package:naseeb/presentation/pages/employer/detail/inside_post_page.dart';
import 'package:naseeb/presentation/widgets/w_textField.dart';
import 'package:naseeb/utils/colors.dart';

class AddPostPageF extends StatefulWidget {
  const AddPostPageF({super.key});

  @override
  State<AddPostPageF> createState() => _AddPostPageFState();
}

class _AddPostPageFState extends State<AddPostPageF> {
  File? image;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        ThemeModelInheritedNotifier.of(context).theme == AppTheme.darkTheme;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Add Posts",
          style: TextStyle(
              fontWeight: FontWeight.w700, fontSize: 18, fontFamily: "sfPro"),
        ),
      ),
      body: Column(
        children: [
          ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(16),
            physics: const BouncingScrollPhysics(),
            children: [
              Container(
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
                          context, InsidePostPage.routeName),
                      contentPadding: EdgeInsets.zero,
                      trailing: IconButton(
                        onPressed: () {},
                        icon: Image.asset(
                          "assets/images/trash.png",
                          color: kprimaryColor,
                          width: 30,
                        ),
                      ),
                      title: const Text(
                        "Mexanik kerak",
                        style: TextStyle(
                            fontFamily: "sfPro", fontWeight: FontWeight.w700),
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
                          borderRadius: BorderRadius.circular(15),
                          color: kgreyColor),
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
                              context, InsidePostPage.routeName);
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
              )
            ],
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
                  showCupertinoModalPopup(
                    context: context,
                    barrierDismissible: true,
                    builder: (context) {
                      return StatefulBuilder(builder: (context, setState) {
                        Future pickImage() async {
                          final image = await ImagePicker()
                              .pickImage(source: ImageSource.gallery);
                          if (image == null) return;
                          final imageTemporary = File(image.path);
                          setState(() => this.image = imageTemporary);
                        }

                        return SafeArea(
                          child: Material(
                            color: Colors.transparent,
                            child: Container(
                              color:
                                  isDarkMode ? const Color(0xff2b2d3a) : white,
                              width: double.infinity,
                              child: ListView(
                                padding: const EdgeInsets.all(16),
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "Add Post",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18,
                                            fontFamily: "sfPro"),
                                      ),
                                      IconButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          icon: const Icon(Icons.close))
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const WTextField(title: "Descrition"),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const WTextField(title: "Amount"),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const WTextField(title: "Time"),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const WTextField(title: "Address"),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const WTextField(title: "Category"),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    "Photo",
                                    style: TextStyle(color: kgreyColor),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      pickImage();
                                    },
                                    child: Container(
                                      height: 200,
                                      width: double.infinity,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: kgreyColor,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: image != null
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              child: Image.file(
                                                image!,
                                                fit: BoxFit.cover,
                                                width: double.infinity,
                                                height: 200,
                                              ),
                                            )
                                          : Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SvgPicture.asset(
                                                    "assets/svg/camera.svg"),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                const Text(
                                                  "Choose photo from \nyour gallery",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: white,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontFamily: "sfPro"),
                                                )
                                              ],
                                            ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      setState(() {
                                        image = null;
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                        minimumSize:
                                            const Size(double.infinity, 50),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15))),
                                    child: const Text(
                                      "Add",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          fontFamily: "sfPro"),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                    },
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  decoration: BoxDecoration(
                      color: fieldFocusColor.withOpacity(isDarkMode ? .2 : 1),
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
  }
}
