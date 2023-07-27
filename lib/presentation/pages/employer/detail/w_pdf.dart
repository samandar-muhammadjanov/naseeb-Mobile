import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:naseeb/config/app_theme.dart';
import 'package:naseeb/domain/models/get_employee_detail_model.dart';
import 'package:naseeb/utils/colors.dart';

class WPdf extends StatelessWidget {
  const WPdf({super.key, this.data});
  final EFile? data;

  @override
  Widget build(BuildContext context) {
    final size = data!.size > 1000000
        ? "${(data!.size / 1048576).toStringAsFixed(2)} Mb"
        : data!.size > 1000
            ? "${(data!.size / 1024).toStringAsFixed(2)} Kb"
            : "${(data!.size).toStringAsFixed(2)} B";
    bool isDarkMode =
        ThemeModelInheritedNotifier.of(context).theme == AppTheme.darkTheme;
    return InkWell(
      onTap: () async {
        // final url = data!.url;
        // if (await canLaunch(url)) {
        //   await launch(url, );
        // } else {
        //   throw 'Could not launch $url';
        // }
      },
      child: Container(
        height: 75,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: lightBlue.withOpacity(isDarkMode ? 0.2 : 1),
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              "assets/svg/PDF.svg",
              height: 44,
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sertifikat - ${data!.name}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 1,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$size. ${DateFormat('dd MMM yyyy').format(data!.date)}',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: kgreyColor,
                    ),
                    maxLines: 1,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
