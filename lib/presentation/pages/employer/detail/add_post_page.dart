import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:naseeb/domain/models/address_model.dart';
import 'package:naseeb/presentation/pages/employee/home_page.dart';
import 'package:naseeb/presentation/pages/employer/home_page.dart';
import 'package:naseeb/presentation/pages/employer/post_page.dart';
import 'package:naseeb/presentation/pages/single_screens/map_page.dart';
import 'package:naseeb/presentation/widgets/w_textField.dart';
import 'package:naseeb/utils/colors.dart';
import 'package:naseeb/utils/extantions.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({super.key, this.address});
  static const routeName = "/employer/add_post";
  final AddressModel? address;
  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  File? image;

  TextEditingController addressController = TextEditingController();
  @override
  void initState() {
    super.initState();
    if (widget.address != null) {
      addressController.text =
          "${widget.address!.region}, ${widget.address!.city}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const EmployerHomePage(),
                ));
          },
          icon: const Icon(Icons.arrow_back),
        ),
        centerTitle: true,
        title: const Text(
          "Add Post",
          style: TextStyle(
              fontWeight: FontWeight.w700, fontSize: 18, fontFamily: "sfPro"),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        children: [
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
          WTextField(
            controller: addressController,
            title: "Address",
            suffix: IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MapPage(
                          isForPost: true,
                        ),
                      ));
                },
                icon: const Icon(Icons.map)),
          ),
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
            onTap: () async {
              final image = await pickImage();
              setState(() {
                this.image = image;
              });
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
                      borderRadius: BorderRadius.circular(15),
                      child: Image.file(
                        image!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 200,
                      ),
                    )
                  : Column(
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
              // Navigator.pop(context);
              // setState(() {
              //   image = null;
              // });
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
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
    );
  }
}
