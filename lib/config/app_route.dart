import 'package:flutter/material.dart';
import 'package:naseeb/presentation/pages/employee/details/certificates_page.dart';
import 'package:naseeb/presentation/pages/single_screens/chat_inside_page.dart';
import 'package:naseeb/presentation/pages/employee/details/create_cv_page.dart';
import 'package:naseeb/presentation/pages/employee/details/education_page.dart';
import 'package:naseeb/presentation/pages/single_screens/indside_post_page.dart';
import 'package:naseeb/presentation/pages/employee/details/language_page.dart';
import 'package:naseeb/presentation/pages/employee/details/main_information_page.dart';
import 'package:naseeb/presentation/pages/employee/details/salary_page.dart';
import 'package:naseeb/presentation/pages/employee/details/work_experience_page.dart';
import 'package:naseeb/presentation/pages/employee/home_page.dart';
import 'package:naseeb/presentation/pages/employer/home_page.dart';
import 'package:naseeb/presentation/pages/intro/auth_page.dart';
import 'package:naseeb/presentation/pages/intro/onboarding_page.dart';
import 'package:naseeb/presentation/pages/intro/registration_page.dart';
import 'package:naseeb/presentation/pages/intro/select_role_page.dart';
import 'package:naseeb/presentation/pages/single_screens/app_settings_page.dart';
import 'package:naseeb/presentation/pages/single_screens/map_page.dart';

class AppRoute {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case OnboardingPage.routeName:
        return MaterialPageRoute(
          builder: (context) => const OnboardingPage(),
        );
      case AuthPage.routeName:
        return MaterialPageRoute(
          builder: (context) => const AuthPage(),
        );
      case RegistrationPage.routeName:
        return MaterialPageRoute(
          builder: (context) => const RegistrationPage(),
        );
      case MapPage.routeName:
        return MaterialPageRoute(
          builder: (context) => const MapPage(),
        );
      case SelectRolePage.routeName:
        return MaterialPageRoute(
          builder: (context) => const SelectRolePage(),
        );
      case EmployeeHomePage.routeName:
        return MaterialPageRoute(
          builder: (context) => const EmployeeHomePage(),
        );
      case CreateCVPage.routeName:
        return MaterialPageRoute(
          builder: (context) => const CreateCVPage(),
        );
      case MainInformationPage.routeName:
        return MaterialPageRoute(
          builder: (context) => const MainInformationPage(),
        );
      case WorkExperiencePage.routeName:
        return MaterialPageRoute(
          builder: (context) => const WorkExperiencePage(),
        );
      case EducationPage.routeName:
        return MaterialPageRoute(
          builder: (context) => const EducationPage(),
        );
      case LanguagePage.routeName:
        return MaterialPageRoute(
          builder: (context) => const LanguagePage(),
        );
      case CertificatesPage.routeName:
        return MaterialPageRoute(
          builder: (context) => const CertificatesPage(),
        );
      case SalaryPage.routeName:
        return MaterialPageRoute(
          builder: (context) => const SalaryPage(),
        );
      case ChatInsidePage.routeName:
        return MaterialPageRoute(
          builder: (context) => const ChatInsidePage(),
        );
      case InsidePostPage.routeName:
        return MaterialPageRoute(
          builder: (context) => const InsidePostPage(),
        );
      case EmployerHomePage.routeName:
        return MaterialPageRoute(
          builder: (context) => const EmployerHomePage(),
        );
      case AppSettingsPage.routeName:
        return MaterialPageRoute(
          builder: (context) => const AppSettingsPage(),
        );
      default:
        break;
    }
    return null;
  }
}
