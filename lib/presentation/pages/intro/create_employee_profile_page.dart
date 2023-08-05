import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:naseeb/config/app_theme.dart';
import 'package:naseeb/domain/repositories/employee_repo/employee_repo.dart';
import 'package:naseeb/domain/repositories/unic_repo/unic_repo.dart';
import 'package:naseeb/presentation/widgets/w_button.dart';
import 'package:naseeb/presentation/widgets/w_textField.dart';
import 'package:naseeb/utils/colors.dart';

class CreateEmployeeProfilePage extends StatefulWidget {
  const CreateEmployeeProfilePage({super.key});
  static const routeName = "/employer/create-employer";

  @override
  State<CreateEmployeeProfilePage> createState() =>
      _CreateEmployeeProfilePageState();
}

class _CreateEmployeeProfilePageState extends State<CreateEmployeeProfilePage> {
  List<String> list = ["ONLAIN", "FULLTIME", "PARTTIME"];
  List<String> valuta = ["USD", "SUM", "RUBL"];
  late String dropdownValue; // Declare the variable here
  String categoryID = '';
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController salaryController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    dropdownValue = list.first;
  }

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        ThemeModelInheritedNotifier.of(context).theme == AppTheme.darkTheme;
    return Form(
      key: formKey,
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              "Create Employee Profile",
              style: TextStyle(
                  color: isDarkMode ? white : const Color(0xff1F1F39),
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  fontFamily: "sfPro"),
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WTextField(
                title: "Descript what do you do",
                maxLines: 5,
                controller: descriptionController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "*required";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Select category",
                style: TextStyle(color: kgreyColor, fontFamily: "sfPro"),
              ),
              const SizedBox(
                height: 10,
              ),
              TypeAheadFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "*required";
                  }
                  return null;
                },
                textFieldConfiguration: TextFieldConfiguration(
                    onChanged: (value) async {
                      await UnicRepo().getCategories(value);
                      setState(() {});
                    },
                    controller: categoryController,
                    style: const TextStyle(fontFamily: "sfPro"),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          color: kgreyColor,
                        ),
                      ),
                      fillColor: fieldFocusColor,
                    )),
                suggestionsCallback: (pattern) async {
                  return await UnicRepo().getCategories(pattern);
                },
                noItemsFoundBuilder: (context) {
                  return Container(
                    width: double.infinity,
                    height: 50,
                    alignment: Alignment.center,
                    child: const Text(
                      "No Category",
                      style: TextStyle(fontFamily: "sfPro"),
                    ),
                  );
                },
                itemBuilder: (context, suggestion) {
                  return ListTile(
                      title: Text(
                    suggestion.nameUz,
                    style: const TextStyle(fontFamily: "sfPro"),
                  ));
                },
                onSuggestionSelected: (suggestion) {
                  setState(() {
                    categoryController.text = suggestion.nameUz;
                    categoryID = suggestion.id.toString();
                  });
                },
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Select job type",
                style: TextStyle(color: kgreyColor, fontFamily: "sfPro"),
              ),
              const SizedBox(
                height: 10,
              ),
              GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (context, index) {
                  return Container();
                },
              ),
              // DropdownButtonFormField<String>(
              //   validator: (value) {
              //     if (value!.isEmpty) {
              //       return "*required";
              //     }
              //     return null;
              //   },
              //   decoration: InputDecoration(
              //     contentPadding:
              //         const EdgeInsets.symmetric(vertical: 17, horizontal: 10),
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(15),
              //       borderSide: BorderSide(
              //         color: kgreyColor.withOpacity(.2),
              //       ),
              //     ),
              //   ),
              //   value: dropdownValue,
              //   style: TextStyle(
              //       fontFamily: "sfPro", color: isDarkMode ? white : black),
              //   isExpanded: true,
              //   icon: Transform.rotate(
              //       angle: 4.7,
              //       child: const Icon(Icons.arrow_back_ios_new_rounded)),
              //   elevation: 16,
              //   onChanged: (String? value) {
              //     // This is called when the user selects an item.
              //     setState(() {
              //       dropdownValue = value!;
              //     });
              //   },
              //   items: list.map<DropdownMenuItem<String>>((String value) {
              //     return DropdownMenuItem<String>(
              //       value: value,
              //       child: Text(
              //         value,
              //         style: const TextStyle(fontFamily: "sfPro"),
              //       ),
              //     );
              //   }).toList(),
              // ),
              const SizedBox(
                height: 10,
              ),
              WTextField(
                controller: salaryController,
                title: "Set your salary",
                suffix: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 1),
                    child: SizedBox(
                      width: 240,
                      height: 57,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: List.generate(
                          valuta.length,
                          (index) {
                            final item = valuta[index];
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  currentIndex = index;
                                });
                              },
                              child: Container(
                                width: 60,
                                decoration: BoxDecoration(
                                  color: currentIndex == index
                                      ? kprimaryColor
                                      : white,
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  item,
                                  style: TextStyle(
                                      fontSize: 18,
                                      color:
                                          currentIndex == index ? white : black,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "sfPro"),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                type: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "*required";
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(
              left: 16,
              top: 16,
              right: 16,
              bottom: MediaQuery.of(context).viewInsets.bottom != 0
                  ? MediaQuery.of(context).viewInsets.bottom + 16
                  : 16),
          child: wButton(() {
            if (formKey.currentState!.validate()) {
              // EmployeeRepo().createEmployeeProfile(descriptionController.text,
              //     dropdownValue, salaryController.text, categoryID, context);
            }
          }, "Next"),
        ),
      ),
    );
  }
}
