// ignore_for_file: unused_local_variable, deprecated_member_use

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:naseeb/config/app_theme.dart';
import 'package:naseeb/domain/models/address_model.dart';
import 'package:naseeb/domain/repositories/auth_repo/auth_repo.dart';
import 'package:naseeb/presentation/pages/intro/auth_page.dart';
import 'package:naseeb/presentation/pages/single_screens/map_page.dart';
import 'package:naseeb/presentation/widgets/w_button.dart';
import 'package:naseeb/presentation/widgets/w_date_picker.dart';
import 'package:naseeb/presentation/widgets/w_textField.dart';
import 'package:naseeb/utils/colors.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage(
      {super.key,
      this.address,
      this.firstName,
      this.lastName,
      this.isMale,
      this.birthDate,
      this.email,
      this.description});
  static const routeName = "/auth/registration";
  final AddressModel? address;
  final String? firstName;
  final String? lastName;
  final bool? isMale;
  final String? birthDate;
  final String? email;
  final String? description;
  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  bool isMale = true;
  DateTime date = DateTime.now();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    firstNameController.text = widget.firstName ?? "";
    lastNameController.text = widget.lastName ?? "";
    phoneController.text = widget.email ?? "";
    birthDateController.text = widget.birthDate ?? "";
    descriptionController.text = widget.description ?? "";
    isMale = widget.isMale ?? isMale;
    if (widget.address != null) {
      addressController.text =
          "${widget.address!.region}, ${widget.address!.city}";
    }
  }

  var maskFormatter = MaskTextInputFormatter(
      mask: '+998 ## ### ## ##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);
  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        ThemeModelInheritedNotifier.of(context).theme == AppTheme.darkTheme;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
                context, AuthPage.routeName, (route) => false);
          },
          icon: SvgPicture.asset(
            "assets/svg/Arrow---Left.svg",
            color: isDarkMode ? white : black,
          ),
        ),
        centerTitle: true,
        title: Text(
          "registration".tr(),
          style: TextStyle(
              color: isDarkMode ? white : const Color(0xff1F1F39),
              fontSize: 28,
              fontWeight: FontWeight.w700,
              fontFamily: "sfPro"),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WTextField(
                title: 'enterurfirstname'.tr(),
                controller: firstNameController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "enterurfirstname".tr();
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              WTextField(
                title: "enterurlastname".tr(),
                controller: lastNameController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "enterurlastname".tr();
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              selectGender(),
              const SizedBox(height: 10),
              selectBirthDate(context),
              const SizedBox(height: 10),
              WTextField(
                title: "enterurphonenumber".tr(),
                controller: phoneController,
                formatter: [maskFormatter],
                type: TextInputType.phone,
                validator: (value) {
                  if (value!.isEmpty || value.length < 10) {
                    return "enterurphonenumber".tr();
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              WTextField(
                title: "enterabouturself".tr(),
                maxLines: 5,
                validator: (value) {
                  if (value!.isEmpty || value.length < 10) {
                    return "enterabouturself".tr();
                  }
                  return null;
                },
                controller: descriptionController,
              ),
              const SizedBox(
                height: 10,
              ),
              WTextField(
                controller: addressController,
                title: "enteruraddress".tr(),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Not valid address";
                  }
                  return null;
                },
                suffix: IconButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MapPage(
                            firstName: firstNameController.text,
                            lastName: lastNameController.text,
                            email: phoneController.text,
                            birthDate: birthDateController.text,
                            isMale: isMale,
                            description: descriptionController.text,
                          ),
                        ),
                        (route) => false);
                  },
                  icon: const Icon(Icons.map),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: wButton(() {
          final email = Hive.box("authData").get("email");
          final role = Hive.box("authData").get("role");

          if (formKey.currentState!.validate()) {
            AuthRepo().registration(
                lastNameController.text,
                firstNameController.text,
                email,
                phoneController.text.split(" ").join(),
                isMale ? "MALE" : "FAMALE",
                birthDateController.text,
                descriptionController.text,
                role,
                widget.address!,
                context);
          }
        }, "continue".tr()),
      ),
    );
  }

  Column selectBirthDate(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'enterurbirthdate'.tr(),
          style: const TextStyle(color: kgreyColor, fontFamily: "sfPro"),
        ),
        const SizedBox(
          height: 14,
        ),
        TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return "Not valid birthdate";
            }
            return null;
          },
          onTap: () => showDate(
            date: date,
            context: context,
            dateController: birthDateController,
            lastDate: DateTime.now(),
            firstDate: DateTime(1970),
          ),
          controller: birthDateController,
          keyboardType: TextInputType.datetime,
          decoration: InputDecoration(
            hintText: 'datehint'.tr(),
            hintStyle: const TextStyle(fontFamily: "sfPro"),
            suffixIcon: IconButton(
                onPressed: () {
                  showDate(
                    date: date,
                    context: context,
                    dateController: birthDateController,
                    lastDate: DateTime.now(),
                    firstDate: DateTime(1970),
                  );
                },
                icon: const Icon(Icons.calendar_month)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                color: kgreyColor,
              ),
            ),
            fillColor: fieldFocusColor,
          ),
        ),
      ],
    );
  }

  Column selectGender() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'selecturgender'.tr(),
          style: const TextStyle(color: kgreyColor, fontFamily: "sfPro"),
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
                        color: isMale ? kprimaryColor : kgreyColor, width: 1.5),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text(
                      "male".tr(),
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
                      "female".tr(),
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
      ],
    );
  }
}
