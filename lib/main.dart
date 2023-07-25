import 'package:flutter/material.dart';
import 'package:naseeb/config/app_route.dart';
import 'package:naseeb/config/app_theme.dart';
import 'package:naseeb/presentation/pages/intro/onboarding_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.openBox('authData');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Naseeb',
      theme: AppTheme.light,
      onGenerateRoute: AppRoute().onGenerateRoute,
      home: const OnboardingPage(),
    );
  }
}
