import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:naseeb/blocs/bloc_imports.dart';
import 'package:naseeb/config/app_route.dart';
import 'package:naseeb/presentation/pages/employee/home_page.dart';
import 'package:naseeb/presentation/pages/employer/home_page.dart';
import 'package:naseeb/presentation/pages/intro/onboarding_page.dart';
import 'package:naseeb/storage/local_storage_repository.dart';

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
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => EmployerBloc(),
              ),
              BlocProvider(
                create: (context) => UserBloc()..add(GetUserDataEvent()),
              ),
              BlocProvider(
                create: (context) => FavoritesBloc(
                    localstorageRepository: LocalstorageRepository(),
                    employeeLocalstorageRepository:
                        EmployeeLocalstorageRepository())
                  ..add(
                    StartFavorites(),
                  ),
              )
            ],
            child: MaterialApp(
              title: 'Naseeb',
              theme: themee,
              onGenerateRoute: AppRoute().onGenerateRoute,
              home: ThemeSwitchingArea(
                  child: !isLogined!
                      ? const OnboardingPage()
                      : isEmployee!
                          ? const EmployeeHomePage()
                          : const EmployerHomePage()),
            ),
          );
        });
  }
}
