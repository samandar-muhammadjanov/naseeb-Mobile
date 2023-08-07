import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:naseeb/config/app_theme.dart';
import 'package:naseeb/config/theme_service.dart';
import 'package:naseeb/presentation/pages/single_screens/about_app_page.dart';
import 'package:naseeb/presentation/pages/single_screens/help_page.dart';
import 'package:naseeb/presentation/pages/single_screens/privacy_policy_page.dart';
import 'package:naseeb/utils/colors.dart';
import 'package:easy_localization/easy_localization.dart';

class AppSettingsPage extends StatefulWidget {
  const AppSettingsPage({super.key});
  static const routeName = '/settings';

  @override
  State<AppSettingsPage> createState() => _AppSettingsPageState();
}

class _AppSettingsPageState extends State<AppSettingsPage> {
  @override
  Widget build(BuildContext context) {
    bool isUz = context.locale == const Locale("uz", "UZ") ? true : false;
    bool isRu = context.locale == const Locale("ru", "RU") ? true : false;
    bool isEn = context.locale == const Locale("en", "US") ? true : false;
    bool isDarkMode =
        ThemeModelInheritedNotifier.of(context).theme == AppTheme.darkTheme;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "appSettings".tr(),
          style: const TextStyle(
              fontWeight: FontWeight.w700, fontSize: 18, fontFamily: "sfPro"),
        ),
      ),
      body: Column(
        children: [
          ListTile(
            onTap: () {
              showCupertinoModalPopup(
                context: context,
                builder: (context) {
                  return StatefulBuilder(builder: (context, setState) {
                    return Material(
                      color: Colors.transparent,
                      child: Container(
                        margin: const EdgeInsets.all(16),
                        padding: const EdgeInsets.all(16),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: isDarkMode ? darkModeColor : white,
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              onTap: () {
                                setState(() {
                                  isUz = true;
                                  isRu = false;
                                  isEn = false;
                                  context.setLocale(const Locale("uz", "UZ"));
                                });
                                Navigator.pop(context);
                              },
                              leading: Container(
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: kprimaryColor,
                                    width: 2,
                                  ),
                                ),
                                child: FractionallySizedBox(
                                  heightFactor: 0.7,
                                  widthFactor: 0.7,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: isUz
                                            ? kprimaryColor
                                            : Colors.transparent),
                                  ),
                                ),
                              ),
                              minLeadingWidth: 0,
                              title: const Text(
                                "O'zbek tili",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "sfPro"),
                              ),
                            ),
                            ListTile(
                              onTap: () {
                                setState(() {
                                  isUz = false;
                                  isRu = true;
                                  isEn = false;
                                  context.setLocale(const Locale("ru", "RU"));
                                });
                                Navigator.pop(context);
                              },
                              leading: Container(
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: kprimaryColor,
                                    width: 2,
                                  ),
                                ),
                                child: FractionallySizedBox(
                                  heightFactor: 0.7,
                                  widthFactor: 0.7,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: isRu
                                            ? kprimaryColor
                                            : Colors.transparent),
                                  ),
                                ),
                              ),
                              minLeadingWidth: 0,
                              title: const Text(
                                "Русский язык",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "sfPro"),
                              ),
                            ),
                            ListTile(
                              onTap: () {
                                setState(() {
                                  isUz = false;
                                  isRu = false;
                                  isEn = true;
                                  context.setLocale(const Locale("en", "US"));
                                });
                                Navigator.pop(context);
                              },
                              leading: Container(
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: kprimaryColor,
                                    width: 2,
                                  ),
                                ),
                                child: FractionallySizedBox(
                                  heightFactor: 0.7,
                                  widthFactor: 0.7,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: isEn
                                            ? kprimaryColor
                                            : Colors.transparent),
                                  ),
                                ),
                              ),
                              minLeadingWidth: 0,
                              title: const Text(
                                "English",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "sfPro"),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  });
                },
              );
            },
            leading: const Icon(
              Icons.translate_rounded,
            ),
            minLeadingWidth: 0,
            title: Text(
              "language".tr(),
              style: const TextStyle(
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
            title: Text(
              "darkMode".tr(),
              style: const TextStyle(
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
            title: Text(
              "notification".tr(),
              style: const TextStyle(
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
            title: Text(
              "help".tr(),
              style: const TextStyle(
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
            title: Text(
              "aboutApp".tr(),
              style: const TextStyle(
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
            title: Text(
              "privacyPolicy".tr(),
              style: const TextStyle(
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
