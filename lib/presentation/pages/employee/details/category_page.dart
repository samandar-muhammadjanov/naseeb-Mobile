import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:naseeb/blocs/bloc_imports.dart';
import 'package:naseeb/domain/models/get_employee_detail_model.dart';
import 'package:naseeb/presentation/widgets/w_button.dart';
import 'package:naseeb/presentation/widgets/w_loading.dart';
import 'package:naseeb/presentation/widgets/w_textField.dart';
import 'package:naseeb/utils/colors.dart';

class CategoryPage extends StatelessWidget {
  CategoryPage({super.key});
  final box = Hive.box("authData").get("employeeId");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Certificates",
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
                category: state.employee!.data.categoryResponse,
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
  const Body({super.key, required this.category});
  final CategoryResponse category;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<bool>? _isOpen;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: wButton(() {}, "Save", color: kprimaryColor),
      ),
      body: Column(
        children: [
          ExpansionPanelList(
            children: [
              ExpansionPanel(
                isExpanded: _isOpen?[0] ?? false,
                headerBuilder: (context, isExpanded) => Text("Hello"),
                body: Text("Open"),
              )
            ],
            expansionCallback: (panelIndex, isExpanded) {
              setState(() {
                _isOpen?[panelIndex] = isExpanded;
              });
            },
          )
        ],
      ),
    );
  }
}
