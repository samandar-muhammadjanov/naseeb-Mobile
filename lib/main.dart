import 'package:flutter/material.dart';
import 'package:naseeb/app/app.dart';
import 'package:naseeb/config/theme_service.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:naseeb/domain/models/get_employee_model.dart';
import 'package:naseeb/domain/models/post_for_employee.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final themeService = await ThemeService.instance;
  var initTheme = themeService.initial;
  await Hive.initFlutter();
  Hive.registerAdapter(DatumAdapter());
  Hive.registerAdapter(AddressDtoAdapter());
  Hive.registerAdapter(ResponseFileAdapter());
  Hive.registerAdapter(CategoryDtoAdapter());
  Hive.registerAdapter(CategoryResponseAdapter());
  Hive.registerAdapter(ExperienceResponseAdapter());
  Hive.registerAdapter(RegisterResponseAdapter());
  Hive.registerAdapter(AddressAdapter());
  Hive.registerAdapter(SalaryResponseAdapter());
  Hive.registerAdapter(EmployeeDatumAdapter());
  Hive.openBox('authData');
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  var isLoggedIn =
      (prefs.getBool('isLogined') == null) ? false : prefs.getBool('isLogined');

  var isEmployee = (prefs.getBool('isEmployee') == null)
      ? false
      : prefs.getBool('isEmployee');
  runApp(MyApp(
    isLogined: isLoggedIn,
    isEmployee: isEmployee,
    theme: initTheme,
  ));
}
