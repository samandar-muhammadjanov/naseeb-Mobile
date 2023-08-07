// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:naseeb/blocs/bloc_imports.dart';
import 'package:naseeb/domain/models/get_employee_detail_model.dart';
import 'package:naseeb/domain/repositories/employee_repo/employee_repo.dart';
import 'package:naseeb/presentation/widgets/w_button.dart';
import 'package:naseeb/presentation/widgets/w_date_picker.dart';
import 'package:naseeb/presentation/widgets/w_loading.dart';
import 'package:naseeb/presentation/widgets/w_textField.dart';
import 'package:naseeb/utils/colors.dart';

class WorkExperiencePage extends StatelessWidget {
  WorkExperiencePage({super.key});

  static const routeName = '/employee/work-experience';
  var box = Hive.box("authData").get("employeeId");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Work Experience",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            fontFamily: "sfPro",
          ),
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
                experience: state.employee!.data.experienceResponses,
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
  const Body({super.key, required this.experience});
  final List<ExperienceResponse> experience;
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  TextEditingController jobController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  TextEditingController beginController = TextEditingController();
  TextEditingController endController = TextEditingController();
  TextEditingController levelController = TextEditingController();
  TextEditingController descriptionjobController = TextEditingController();
  bool isUntilNow = false;
  final GlobalKey<FormState> formKey = GlobalKey();
  DateTime date = DateTime.now();
  @override
  void initState() {
    super.initState();
    if (widget.experience.isNotEmpty) {
      final item = widget.experience.last;
      levelController.text = item.level;
      jobController.text = item.asWho;
      companyController.text = item.company;
      beginController.text = DateFormat("yyyy-MM-dd").format(item.begin);
      endController.text = DateFormat("yyyy-MM-dd").format(item.end);
      descriptionjobController.text = item.description;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: wButton(() {
          if (formKey.currentState!.validate()) {
            EmployeeRepo().addExperience(
                level: levelController.text,
                asWho: jobController.text,
                company: companyController.text,
                begin: beginController.text,
                end: endController.text,
                description: descriptionjobController.text,
                context: context);
          }
        }, "Save", color: kprimaryColor),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              WTextField(
                title: "Enter your level",
                controller: levelController,
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
              WTextField(
                title: "Enter your job",
                controller: jobController,
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
              WTextField(
                title: "Enter company name",
                controller: companyController,
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
              WTextField(
                title: "Begin",
                controller: beginController,
                suffix: IconButton(
                    onPressed: () {
                      showDate(
                          date: date,
                          context: context,
                          dateController: beginController,
                          lastDate: DateTime.now(),
                          firstDate: DateTime(1970));
                    },
                    icon: const Icon(Icons.date_range_outlined)),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Not valid field";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 5,
              ),
              CheckboxMenuButton(
                value: isUntilNow,
                onChanged: (val) {
                  setState(() {
                    isUntilNow = val!;
                    endController.clear();
                  });
                },
                child: const Text(
                  "Until now",
                  style: TextStyle(
                    fontFamily: "sfPro",
                    fontSize: 16,
                  ),
                ),
              ),
              if (!isUntilNow) ...[
                const SizedBox(
                  height: 5,
                ),
                WTextField(
                  title: "End",
                  controller: endController,
                  validator: isUntilNow
                      ? null
                      : (value) {
                          if (value!.isEmpty) {
                            return "Not valid field";
                          }
                          return null;
                        },
                  suffix: IconButton(
                      onPressed: () {
                        showDate(
                            date: date,
                            context: context,
                            dateController: endController,
                            lastDate: DateTime.now(),
                            firstDate: DateTime(1970));
                      },
                      icon: const Icon(Icons.date_range_outlined)),
                ),
              ],
              const SizedBox(
                height: 20,
              ),
              WTextField(
                title: "Enter description",
                controller: descriptionjobController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Not valid field";
                  }
                  return null;
                },
                maxLines: 5,
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
