import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:naseeb/config/app_theme.dart';
import 'package:naseeb/config/theme_service.dart';
import 'package:naseeb/presentation/pages/single_screens/about_app_page.dart';
import 'package:naseeb/presentation/pages/single_screens/help_page.dart';
import 'package:naseeb/presentation/pages/single_screens/privacy_policy_page.dart';
import 'package:naseeb/utils/colors.dart';

class AppSettingsPage extends StatefulWidget {
  const AppSettingsPage({super.key});
  static const routeName = '/settings';

  @override
  State<AppSettingsPage> createState() => _AppSettingsPageState();
}

class _AppSettingsPageState extends State<AppSettingsPage> {
  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        ThemeModelInheritedNotifier.of(context).theme == AppTheme.darkTheme;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "App Settings",
          style: TextStyle(
              fontWeight: FontWeight.w700, fontSize: 18, fontFamily: "sfPro"),
        ),
      ),
      body: Column(
        children: [
          const ListTile(
            leading: Icon(
              Icons.translate_rounded,
            ),
            minLeadingWidth: 0,
            title: Text(
              "Language",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  fontFamily: "sfPro"),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.dark_mode_outlined,
            ),
            minLeadingWidth: 0,
            title: const Text(
              "Dark Mode",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  fontFamily: "sfPro"),
            ),
            trailing: ThemeSwitcher(builder: (context) {
              return CupertinoSwitch(
                activeColor: kprimaryColor,
                value: isDarkMode,
                onChanged: (value) async {
                  final themeSwitcher = ThemeSwitcher.of(context);
                  final themeName = ThemeModelInheritedNotifier.of(context)
                              .theme
                              .brightness ==
                          Brightness.light
                      ? 'dark'
                      : 'light';
                  final service = await ThemeService.instance
                    ..save(themeName);
                  final theme = service.getByName(themeName);

                  themeSwitcher.changeTheme(theme: theme);
                },
              );
            }),
          ),
          ListTile(
            leading: const Icon(
              Icons.notifications_none_rounded,
            ),
            minLeadingWidth: 0,
            title: const Text(
              "Notifications",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  fontFamily: "sfPro"),
            ),
            trailing: CupertinoSwitch(
              activeColor: kprimaryColor,
              value: true,
              onChanged: (value) {},
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, HelpScreen.routeName);
            },
            leading: const Icon(
              Icons.support_agent_rounded,
            ),
            minLeadingWidth: 0,
            title: const Text(
              "Help",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  fontFamily: "sfPro"),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, AboutAppScreen.routeName);
            },
            leading: const Icon(
              Icons.info_outline_rounded,
            ),
            minLeadingWidth: 0,
            title: const Text(
              "About App",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  fontFamily: "sfPro"),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, PrivacyPolicyPage.routeName);
            },
            leading: const Icon(
              Icons.privacy_tip_outlined,
            ),
            minLeadingWidth: 0,
            title: const Text(
              "Privacy Policy",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  fontFamily: "sfPro"),
            ),
          ),
        ],
      ),
    );
  }
}
