import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:naseeb/blocs/bloc_imports.dart';
import 'package:naseeb/domain/models/address_model.dart';
import 'package:naseeb/domain/repositories/user_repo/user_repo.dart';
import 'package:naseeb/presentation/pages/single_screens/map_page.dart';
import 'package:naseeb/presentation/widgets/w_button.dart';
import 'package:naseeb/presentation/widgets/w_date_picker.dart';
import 'package:naseeb/presentation/widgets/w_loading.dart';
import 'package:naseeb/presentation/widgets/w_textField.dart';
import 'package:naseeb/utils/colors.dart';

class ProfileSettingsPage extends StatelessWidget {
  const ProfileSettingsPage({super.key, this.address});
  static const routeName = '/employer/profile-settings';
  final AddressModel? address;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Profile Settings",
          style: TextStyle(
              fontWeight: FontWeight.w700, fontSize: 18, fontFamily: "sfPro"),
        ),
      ),
      body: BlocProvider(
        create: (context) => UserBloc()..add(GetUserDataEvent()),
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoaded) {
              return Body(
                state: state,
                address: address,
              );
            } else if (state is UserError) {
              context.read<UserBloc>().add(GetUserDataEvent());
              return Text(state.error);
            } else {
              return buildLoading();
            }
          },
        ),
      ),
    );
  }
}

class Body extends StatefulWidget {
  const Body({super.key, required this.state, this.address});
  final UserLoaded state;
  final AddressModel? address;
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool isMale = true;
  XFile? image;
  bool isChanged = false;
  Future pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final imageTemporary = image;
    setState(() {
      this.image = imageTemporary;
      isChanged = true;
    });
  }

  DateTime date = DateTime.now();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  @override
  void initState() {
    final item = widget.state.user.data;
    // TODO: implement initState
    super.initState();
    isMale = item.gender == "MALE" ? true : false;
    firstNameController.text = item.firstName;
    lastNameController.text = item.lastName;
    dateController.text = DateFormat('yyyy-MM-dd').format(item.bornYear);
    addressController.text = "${item.address.region}, ${item.address.city}";
    descriptionController.text = item.description;
    phoneController.text = item.phone;
    if (widget.address != null) {
      addressController.text =
          "${widget.address!.region}, ${widget.address!.city}";
      isChanged = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.state.user.data;
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: wButton(
          () {
            UserRepo().updateUser(
                item.id.toString(),
                firstNameController.text,
                lastNameController.text,
                isMale ? "MALE" : "FAMALE",
                dateController.text,
                descriptionController.text,
                widget.address ??
                    AddressModel(
                        item.address.region,
                        item.address.city,
                        item.address.latitude.toString(),
                        item.address.longitude.toString()),
                phoneController.text,
                context);
            if (image != null) {
              UserRepo().uploadUserPhoto(image!.path);
            }
          },
          "Save",
          color: isChanged ? kprimaryColor : kgreyColor,
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
                          File(image!.path),
                          fit: BoxFit.cover,
                          height: 342,
                          width: double.infinity,
                        ),
                      )
                    : widget.state.user.data.responseFile != null
                        ? Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(
                                widget.state.user.data.responseFile['url'],
                                height: 342,
                                fit: BoxFit.cover,
                              ),
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
                                      fontFamily: "sfPro"),
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
                style: TextStyle(color: kgreyColor, fontFamily: "sfPro"),
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
                          isChanged = true;
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
                                color: isMale ? kprimaryColor : kgreyColor,
                                fontFamily: "sfPro"),
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
                          isChanged = true;
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
                                color: !isMale ? MyColor.salary : kgreyColor,
                                fontFamily: "sfPro"),
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
              WTextField(
                title: "Your First Name",
                controller: firstNameController,
                onChanged: (p0) {
                  setState(() {
                    isChanged = true;
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              WTextField(
                title: "Your Last Name",
                controller: lastNameController,
                onChanged: (p0) {
                  setState(() {
                    isChanged = true;
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              WTextField(
                title: "Your Birth Date",
                controller: dateController,
                suffix: IconButton(
                    onPressed: () {
                      showDate(
                          date: date,
                          context: context,
                          dateController: dateController,
                          lastDate: DateTime.now(),
                          firstDate: DateTime(1970));
                    },
                    icon: const Icon(Icons.date_range_outlined)),
                onChanged: (p0) {
                  setState(() {
                    isChanged = true;
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              WTextField(
                title: "Your Phone Number",
                controller: phoneController,
                type: TextInputType.phone,
                onChanged: (p0) {
                  setState(() {
                    isChanged = true;
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              WTextField(
                title: "Your Address",
                controller: addressController,
                suffix: IconButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MapPage(
                              isForUser: true,
                            ),
                          ));
                    },
                    icon: const Icon(Icons.map)),
                onChanged: (p0) {
                  setState(() {
                    isChanged = true;
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              WTextField(
                title: "Your Description",
                onChanged: (p0) {
                  setState(() {
                    isChanged = true;
                  });
                },
                maxLines: 5,
                controller: descriptionController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
