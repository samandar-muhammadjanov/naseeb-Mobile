import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
import 'package:file_picker/file_picker.dart';
import 'package:easy_localization/easy_localization.dart';

class CertificatesPage extends StatelessWidget {
  CertificatesPage({super.key});
  static const routeName = "/employee/certificates";
  final box = Hive.box("authData").get("employeeId");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "certificate".tr(),
          style: const TextStyle(
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
                certificates: state.employee!.data.certificateFile,
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
    required this.certificates,
  });
  final List<EFile> certificates;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    super.initState();
    if (widget.certificates.isNotEmpty) {
      final item = widget.certificates.last;
      name.text = item.name;
      time.text = DateFormat("yyyy-MM-dd").format(item.date);
      url = item.url;
      pathName = item.name;
      size = item.size;
      date = item.date;
    }
  }

  selectCertificate() async {
    result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      PlatformFile file = result!.files.first;
      setState(() {
        url = file.path ?? "";
        pathName = file.name;
        size = file.size;
        isFileEmpty = true;
      });
    } else {
      return;
    }
  }

  FilePickerResult? result;
  String? url;
  String? pathName;
  int? size;
  TextEditingController name = TextEditingController();
  TextEditingController time = TextEditingController();
  DateTime date = DateTime.now();
  bool isFileEmpty = true;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: wButton(() {
          if (formKey.currentState!.validate() && isFileEmpty) {
            EmployeeRepo().addCertificate(context, time.text, name.text, url);
            print(url);
          } else {
            setState(() {
              isFileEmpty = false;
            });
          }
        }, "save".tr(), color: kprimaryColor),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WTextField(
                title: "certificateName".tr(),
                controller: name,
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
                title: "date".tr(),
                suffix: IconButton(
                    onPressed: () {
                      showDate(
                          date: date,
                          context: context,
                          dateController: time,
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
                controller: time,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "file".tr(),
                style: TextStyle(
                  color: kgreyColor,
                  fontFamily: "sfPro",
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: kgreyColor),
                    borderRadius: BorderRadius.circular(15)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                child: Column(
                  children: [
                    if (widget.certificates.isNotEmpty) ...[
                      pdf(),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                    GestureDetector(
                      onTap: () {
                        selectCertificate();
                      },
                      child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(15),
                          color: !isFileEmpty ? MyColor.salary : kprimaryColor,
                          child: Container(
                            decoration: BoxDecoration(
                                color: !isFileEmpty
                                    ? MyColor.salartBackground
                                    : fieldFocusColor,
                                borderRadius: BorderRadius.circular(15)),
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  "assets/svg/upload.svg",
                                  color: !isFileEmpty ? MyColor.salary : null,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "uploadCertificate".tr(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "sfPro",
                                      color: !isFileEmpty
                                          ? MyColor.salary
                                          : black),
                                )
                              ],
                            ),
                          )),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  ListTile pdf() {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      tileColor: fieldFocusColor,
      leading: SvgPicture.asset('assets/svg/PDF.svg'),
      title: Text(
        pathName!,
        style: const TextStyle(
          fontFamily: "sfPro",
        ),
      ),
      subtitle: Text(
        "${(size! / 1000).toStringAsFixed(2)} Kb .${DateFormat("dd MMM yyyy").format(date)} at ${DateFormat("").add_Hm().format(date)}",
        style: const TextStyle(
          fontFamily: "sfPro",
        ),
      ),
    );
  }
}
