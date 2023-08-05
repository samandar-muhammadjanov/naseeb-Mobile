// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:naseeb/blocs/bloc_imports.dart';
import 'package:naseeb/domain/models/get_employee_detail_model.dart';
import 'package:naseeb/domain/repositories/employee_repo/employee_repo.dart';
import 'package:naseeb/presentation/widgets/w_button.dart';
import 'package:naseeb/presentation/widgets/w_loading.dart';
import 'package:naseeb/presentation/widgets/w_textField.dart';
import 'package:naseeb/utils/colors.dart';

class EducationPage extends StatelessWidget {
  EducationPage({super.key});
  static const routeName = '/employee/education';
  final box = Hive.box("authData").get("employeeId");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Education",
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
                education: state.employee!.data.educationResponse,
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
    required this.education,
  });
  final List<EducationResponse> education;
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    super.initState();
    if (widget.education.isNotEmpty) {
      final item = widget.education.last;
      university.text = item.institution;
      degree.text = item.level;
      spelizaation.text = item.description;
    }
  }

  TextEditingController university = TextEditingController();
  TextEditingController degree = TextEditingController();
  TextEditingController spelizaation = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: wButton(() {
          if (formKey.currentState!.validate()) {
            EmployeeRepo().addEducation(
                context: context,
                institution: university.text,
                level: degree.text,
                description: spelizaation.text);
          }
        }, "Save", color: kprimaryColor),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              WTextField(
                title: "University/college",
                controller: university,
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
                title: "Degree",
                controller: degree,
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
                title: "Specialization",
                controller: spelizaation,
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
            ],
          ),
        ),
      ),
    );
  }
}
