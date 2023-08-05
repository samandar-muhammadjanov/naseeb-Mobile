import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:naseeb/blocs/bloc_imports.dart';
import 'package:naseeb/domain/models/get_employee_detail_model.dart';
import 'package:naseeb/domain/models/languages.dart';
import 'package:naseeb/domain/repositories/employee_repo/employee_repo.dart';
import 'package:naseeb/presentation/widgets/w_button.dart';
import 'package:naseeb/presentation/widgets/w_loading.dart';
import 'package:naseeb/presentation/widgets/w_textField.dart';
import 'package:naseeb/utils/colors.dart';

import '../../../../config/app_theme.dart';

class LanguagePage extends StatelessWidget {
  LanguagePage({super.key});
  static const routeName = '/employee/language';
  final box = Hive.box("authData").get("employeeId");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Language",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w700, fontFamily: "sfPro"),
        ),
      ),
      body: BlocProvider(
        create: (context) =>
            EmployerBloc()..add(GetEmployeeById(box.toString())),
        child: BlocBuilder<EmployerBloc, EmployerState>(
          builder: (context, state) {
            if (state is EmployerInitial) {
              return buildLoading();
            } else if (state is EmployerLoading) {
              return buildLoading();
            } else if (state is EmployeeDetailLoaded) {
              return Body(
                language: state.employee!.data.languagesResponse,
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

class Body extends StatefulWidget {
  const Body({
    super.key,
    required this.language,
  });
  final List<LanguagesResponse> language;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  TextEditingController language = TextEditingController();
  TextEditingController level = TextEditingController();
  TextEditingController description = TextEditingController();
  late String langaugeValue;
  late String levelValue;

  bool isChanged = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    langaugeValue = LanguageList.lanuages.first;
    levelValue = LanguageList.levels.first;
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        ThemeModelInheritedNotifier.of(context).theme == AppTheme.darkTheme;
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: wButton(() {
          if (!isChanged) {
            showCupertinoModalPopup(
              context: context,
              builder: (context) {
                return Material(
                  color: Colors.transparent,
                  child: Container(
                      decoration: BoxDecoration(
                          color: isDarkMode ? const Color(0xff2b2d3a) : white),
                      child: Form(
                        key: formKey,
                        child: SingleChildScrollView(
                          padding: EdgeInsets.only(
                              left: 16,
                              right: 16,
                              top: 16,
                              bottom:
                                  MediaQuery.of(context).viewInsets.bottom != 0
                                      ? MediaQuery.of(context)
                                              .viewInsets
                                              .bottom +
                                          16
                                      : 16),
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              fields(isDarkMode, "Language", langaugeValue,
                                  LanguageList.lanuages),
                              const SizedBox(
                                height: 20,
                              ),
                              fields(isDarkMode, "Level", levelValue,
                                  LanguageList.levels),
                              const SizedBox(
                                height: 20,
                              ),
                              WTextField(
                                title: "Enter description",
                                maxLines: 5,
                                controller: description,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Not valid field";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              wButton(() {
                                if (formKey.currentState!.validate()) {
                                  EmployeeRepo().addLanguage(
                                      context,
                                      langaugeValue,
                                      levelValue,
                                      description.text);
                                }
                              }, "Save", color: kprimaryColor)
                            ],
                          ),
                        ),
                      )),
                );
              },
            );
          }
        }, isChanged ? "Save" : "Add", color: kprimaryColor),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        itemCount: widget.language.length,
        itemBuilder: (context, index) {
          final item = widget.language[index];
          print(item);
          return ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text("${item.name} ${item.level}"),
            trailing: IconButton(
              onPressed: () {
                print(item.id);
              },
              icon: const Icon(Icons.delete_outline_rounded),
            ),
          );
        },
      ),
    );
  }

  Widget fields(bool isDarkMode, title, dropdownValue, List list) {
    return StatefulBuilder(builder: (context, setState) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(color: kgreyColor, fontFamily: "sfPro"),
          ),
          const SizedBox(
            height: 10,
          ),
          DropdownButtonFormField<String>(
            validator: (value) {
              if (value!.isEmpty) {
                return "*required";
              }
              return null;
            },
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 17, horizontal: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  color: kgreyColor.withOpacity(.2),
                ),
              ),
            ),
            dropdownColor: isDarkMode ? const Color(0xff2b2d3a) : white,
            value: dropdownValue,
            style: TextStyle(
                fontFamily: "sfPro", color: isDarkMode ? white : black),
            isExpanded: true,
            icon: Transform.rotate(
                angle: 4.7,
                child: const Icon(Icons.arrow_back_ios_new_rounded)),
            elevation: 16,
            onChanged: (String? value) {
              // This is called when the user selects an item.
              setState(() {
                dropdownValue = value!;
              });
            },
            items: list.map<DropdownMenuItem<String>>((dynamic value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: const TextStyle(fontFamily: "sfPro"),
                ),
              );
            }).toList(),
          ),
        ],
      );
    });
  }
}
