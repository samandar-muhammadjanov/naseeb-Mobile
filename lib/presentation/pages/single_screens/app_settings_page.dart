import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:naseeb/utils/colors.dart';

class AppSettingsPage extends StatelessWidget {
  const AppSettingsPage({super.key});
  static const routeName = '/settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "App Settings",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
      ),
      body: Column(
        children: [
          const ListTile(
            leading: Icon(
              Icons.translate_rounded,
              color: black,
            ),
            minLeadingWidth: 0,
            title: Text(
              "Language",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.dark_mode_outlined,
              color: black,
            ),
            minLeadingWidth: 0,
            title: const Text(
              "Dark Mode",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            trailing: CupertinoSwitch(
              activeColor: kprimaryColor,
              value: false,
              onChanged: (value) {},
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.notifications_none_rounded,
              color: black,
            ),
            minLeadingWidth: 0,
            title: const Text(
              "Notifications",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            trailing: CupertinoSwitch(
              activeColor: kprimaryColor,
              value: true,
              onChanged: (value) {},
            ),
          ),
          const ListTile(
            leading: Icon(
              Icons.support_agent_rounded,
              color: black,
            ),
            minLeadingWidth: 0,
            title: Text(
              "Help",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
          ),
          const ListTile(
            leading: Icon(
              Icons.info_outline_rounded,
              color: black,
            ),
            minLeadingWidth: 0,
            title: Text(
              "About App",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
          ),
          const ListTile(
            leading: Icon(
              Icons.privacy_tip_outlined,
              color: black,
            ),
            minLeadingWidth: 0,
            title: Text(
              "Privacy Policy",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}
