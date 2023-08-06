import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:naseeb/blocs/bloc_imports.dart';
import 'package:naseeb/domain/models/get_employee_detail_model.dart';
import 'package:naseeb/presentation/widgets/w_button.dart';
import 'package:naseeb/presentation/widgets/w_loading.dart';
import 'package:naseeb/presentation/widgets/w_textField.dart';
import 'package:naseeb/utils/colors.dart';

class SalaryPage extends StatelessWidget {
  SalaryPage({super.key});
  static const routeName = '/employee/salary';
  final box = Hive.box("authData").get("employeeId");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Salary",
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
                salary: state.employee!.data.salaryResponse,
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
    required this.salary,
  });
  final SalaryResponse salary;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    super.initState();
    final item = widget.salary;
    priceController.text = item.money.toStringAsFixed(0);
    currentIndex = item.nameCode == valuta.first
        ? 0
        : item.nameCode == valuta[1]
            ? 1
            : 2;
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController priceController = TextEditingController();
  int currentIndex = 0;
  String valutaItem = '';
  List<String> valuta = ["USD", "SOM", "RUBL"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: wButton(() => null, "Save", color: kprimaryColor),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              WTextField(
                controller: priceController,
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
                                  valutaItem = item;
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
      ),
    );
  }
}
