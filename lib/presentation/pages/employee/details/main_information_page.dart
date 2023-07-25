// ignore_for_file: unnecessary_null_comparison

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:naseeb/presentation/widgets/w_button.dart';
import 'package:naseeb/presentation/widgets/w_textField.dart';
import 'package:naseeb/utils/colors.dart';

class MainInformationPage extends StatefulWidget {
  const MainInformationPage({super.key});
  static const routeName = "/employee/main-informations";

  @override
  State<MainInformationPage> createState() => _MainInformationPageState();
}

class _MainInformationPageState extends State<MainInformationPage> {
  bool isMale = true;
  File? image;
  Future pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final imageTemporary = File(image.path);
    setState(() => this.image = imageTemporary);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Main informations",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  pickImage();
                },
                child: image != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.file(
                          image!,
                          fit: BoxFit.cover,
                          height: 342,
                          width: double.infinity,
                        ),
                      )
                    : Container(
                        height: 342,
                        alignment: Alignment.center,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: kprimaryColor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset("assets/svg/camera.svg"),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              "Choose photo from \nyour gallery",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: white,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ],
                        ),
                      ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Your Gender',
                style: TextStyle(color: kgreyColor),
              ),
              const SizedBox(
                height: 14,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          isMale = true;
                        });
                      },
                      child: Ink(
                        height: 56,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: isMale ? kprimaryColor : kgreyColor,
                              width: 1.5),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Text(
                            "Male",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: isMale ? kprimaryColor : kgreyColor),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 22,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          isMale = false;
                        });
                      },
                      child: Ink(
                        height: 56,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: !isMale ? MyColor.salary : kgreyColor,
                                width: 1.5),
                            borderRadius: BorderRadius.circular(15)),
                        child: Center(
                          child: Text(
                            "Female",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: !isMale ? MyColor.salary : kgreyColor),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const WTextField(title: "Your First Name"),
              const SizedBox(
                height: 20,
              ),
              const WTextField(title: "Your Last Name"),
              const SizedBox(
                height: 20,
              ),
              const WTextField(title: "Your Birth Date"),
              const SizedBox(
                height: 20,
              ),
              const WTextField(title: "Your email"),
              const SizedBox(
                height: 20,
              ),
              const WTextField(title: "Your Address"),
              const SizedBox(
                height: 20,
              ),
              const WTextField(
                title: "Your Description",
                maxLines: 5,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: wButton(() => null, "Save", color: kgreyColor),
      ),
    );
  }
}
