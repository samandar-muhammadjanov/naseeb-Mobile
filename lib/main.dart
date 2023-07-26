import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:naseeb/config/app_route.dart';
import 'package:naseeb/config/app_theme.dart';
import 'package:naseeb/config/theme_service.dart';
import 'package:naseeb/presentation/pages/employee/home_page.dart';
import 'package:naseeb/presentation/pages/employer/home_page.dart';
import 'package:naseeb/presentation/pages/intro/onboarding_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final themeService = await ThemeService.instance;
  var initTheme = themeService.initial;
  await Hive.initFlutter();
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

class MyApp extends StatelessWidget {
  const MyApp(
      {super.key, this.isLogined, this.isEmployee, required this.theme});
  final bool? isLogined;
  final bool? isEmployee;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
        initTheme: theme,
        builder: (context, themee) {
          return MaterialApp(
            title: 'Naseeb',
            theme: themee,
            onGenerateRoute: AppRoute().onGenerateRoute,
            home: ThemeSwitchingArea(
                child: !isLogined!
                    ? const OnboardingPage()
                    : isEmployee!
                        ? const EmployeeHomePage()
                        : const EmployerHomePage()),
          );
        });
  }
}
