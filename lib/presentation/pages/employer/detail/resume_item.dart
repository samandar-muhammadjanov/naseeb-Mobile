import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:naseeb/config/app_theme.dart';
import 'package:naseeb/domain/models/get_employee_model.dart';
import 'package:naseeb/presentation/pages/employer/detail/w_pdf.dart';
import 'package:naseeb/utils/colors.dart';

class WMainInformation extends StatefulWidget {
  const WMainInformation({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.body,
    required this.state,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final String body;
  final EmployeeDatum state;
  @override
  State<WMainInformation> createState() => _WMainInformationState();
}

class _WMainInformationState extends State<WMainInformation> {
  bool isShort = true;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        ThemeModelInheritedNotifier.of(context).theme == AppTheme.darkTheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 25,
        vertical: 20,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: lightGrey),
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: TextStyle(
                color: isDarkMode ? white : black,
                fontSize: 16,
                fontWeight: FontWeight.w700,
                fontFamily: "sfPro"),
          ),
          const SizedBox(height: 12),
          Text(
            widget.subtitle,
            style: TextStyle(
                color: isDarkMode ? white : black, fontFamily: "sfPro"),
          ),
          const SizedBox(height: 15),
          ShaderMask(
            blendMode: BlendMode.srcIn,
            shaderCallback: (Rect bounds) => LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  isDarkMode ? white : black,
                  (isShort)
                      ? isDarkMode
                          ? white.withOpacity(0.1)
                          : black.withOpacity(0.1)
                      : isDarkMode
                          ? white
                          : black,
                ]).createShader(bounds),
            child: Text(
              widget.state.registerResponse.description,
              style: TextStyle(
                  color: isDarkMode ? white : black,
                  fontSize: 14,
                  fontFamily: "sfPro"),
              maxLines: (isShort) ? 5 : null,
            ),
          ),
          const SizedBox(height: 12),
          Visibility(
            visible: isShort,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isShort = false;
                });
              },
              child: const Text(
                'See More',
                style: TextStyle(
                    color: kprimaryColor, fontSize: 14, fontFamily: "sfPro"),
              ),
            ),
          ),
          Visibility(
            visible: !isShort,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isShort = true;
                });
              },
              child: const Text(
                'Hide More',
                style: TextStyle(
                    color: kprimaryColor, fontSize: 14, fontFamily: "sfPro"),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class WWorkExperience extends StatefulWidget {
  const WWorkExperience({super.key, required this.item});
  final EmployeeDatum item;
  @override
  State<WWorkExperience> createState() => _WWorkExperienceState();
}

class _WWorkExperienceState extends State<WWorkExperience> {
  bool isFullVisible = false;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        ThemeModelInheritedNotifier.of(context).theme == AppTheme.darkTheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 25,
        vertical: 20,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: lightGrey),
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Work Experience',
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w700, fontFamily: "sfPro"),
          ),
          const SizedBox(height: 12),
          ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (Rect bounds) => LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        isDarkMode ? white : black,
                        (isFullVisible)
                            ? isDarkMode
                                ? white.withOpacity(0.1)
                                : black.withOpacity(0.1)
                            : isDarkMode
                                ? white
                                : black,
                      ]).createShader(bounds),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(widget.item.experienceResponses.length,
                    (index) {
                  final item = widget.item.experienceResponses[index];
                  final experienceYear = widget.item.experienceResponses.isEmpty
                      ? ''
                      : item.end.year - item.begin.year;
                  return RichText(
                    text: TextSpan(
                      style: TextStyle(
                          color: isDarkMode ? white : black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: "sfPro"),
                      children: [
                        TextSpan(text: '${item.asWho}\n'),
                        TextSpan(text: '${item.company}\n'),
                        TextSpan(
                          text:
                              '$experienceYear years • ${DateFormat("yyyy MMMM").format(item.begin)} - ${DateFormat("yyyy MMMM").format(item.end)}\n\n',
                          style: const TextStyle(color: kgreyColor),
                        ),
                        TextSpan(
                          text: item.description,
                        )
                      ],
                    ),
                    maxLines: (isFullVisible) ? null : 7,
                  );
                }),
              )),
          const SizedBox(height: 10),
          Visibility(
            visible: !isFullVisible,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isFullVisible = true;
                });
              },
              child: const Text(
                'See More',
                style: TextStyle(
                    color: kprimaryColor, fontSize: 14, fontFamily: "sfPro"),
              ),
            ),
          ),
          Visibility(
            visible: isFullVisible,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isFullVisible = false;
                });
              },
              child: const Text(
                'Hide More',
                style: TextStyle(
                    color: kprimaryColor, fontSize: 14, fontFamily: "sfPro"),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class WEducation extends StatefulWidget {
  const WEducation({super.key, required this.item});
  final EmployeeDatum item;
  @override
  State<WEducation> createState() => _WEducationState();
}

class _WEducationState extends State<WEducation> {
  bool isFullVisible = false;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        ThemeModelInheritedNotifier.of(context).theme == AppTheme.darkTheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 25,
        vertical: 20,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: lightGrey),
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Education',
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w700, fontFamily: "sfPro"),
          ),
          const SizedBox(height: 12),
          ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (Rect bounds) => LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        isDarkMode ? white : black,
                        (isFullVisible)
                            ? isDarkMode
                                ? white.withOpacity(0.1)
                                : black.withOpacity(0.1)
                            : isDarkMode
                                ? white
                                : black,
                      ]).createShader(bounds),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(widget.item.educationResponse.length,
                    (index) {
                  final item = widget.item.educationResponse[index];
                  return RichText(
                    text: TextSpan(
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: "sfPro"),
                      children: [
                        TextSpan(text: '${item["institution"]}\n'),
                        TextSpan(
                            text: 'Specialization - ${item["description"]}\n'),
                        const TextSpan(
                          text: '2-kurs • 2020 - 2024\n\n',
                          style: TextStyle(color: kgreyColor),
                        ),
                      ],
                    ),
                    maxLines: (isFullVisible) ? null : 6,
                  );
                }),
              )),
          const SizedBox(height: 10),
          Visibility(
            visible: !isFullVisible,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isFullVisible = true;
                });
              },
              child: const Text(
                'See More',
                style: TextStyle(
                    color: kprimaryColor, fontSize: 14, fontFamily: "sfPro"),
              ),
            ),
          ),
          Visibility(
            visible: isFullVisible,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isFullVisible = false;
                });
              },
              child: const Text(
                'Hide More',
                style: TextStyle(
                    color: kprimaryColor, fontSize: 14, fontFamily: "sfPro"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WLanguage extends StatefulWidget {
  const WLanguage({super.key, required this.item});
  final EmployeeDatum item;
  @override
  State<WLanguage> createState() => _WLanguageState();
}

class _WLanguageState extends State<WLanguage> {
  bool isFullVisible = false;
  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        ThemeModelInheritedNotifier.of(context).theme == AppTheme.darkTheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 25,
        vertical: 20,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: lightGrey),
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Language',
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w700, fontFamily: "sfPro"),
          ),
          const SizedBox(height: 12),
          ShaderMask(
            blendMode: BlendMode.srcIn,
            shaderCallback: (Rect bounds) => LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  isDarkMode ? white : black,
                  (isFullVisible)
                      ? isDarkMode
                          ? white.withOpacity(0.1)
                          : black.withOpacity(0.1)
                      : isDarkMode
                          ? white
                          : black,
                ]).createShader(bounds),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                widget.item.languagesResponse.length,
                (index) {
                  final item = widget.item.languagesResponse[index];

                  return Text("${item["name"]} - ${item["level"]}");
                },
              ),
            ),
          ),
          const SizedBox(height: 10),
          Visibility(
            visible: !isFullVisible,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isFullVisible = true;
                });
              },
              child: const Text(
                'See More',
                style: TextStyle(
                    color: kprimaryColor, fontSize: 14, fontFamily: "sfPro"),
              ),
            ),
          ),
          Visibility(
            visible: isFullVisible,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isFullVisible = false;
                });
              },
              child: const Text(
                'Hide More',
                style: TextStyle(
                    color: kprimaryColor, fontSize: 14, fontFamily: "sfPro"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WCertificate extends StatefulWidget {
  const WCertificate({super.key, required this.item});
  final EmployeeDatum item;
  @override
  State<WCertificate> createState() => _WCertificateState();
}

class _WCertificateState extends State<WCertificate> {
  bool isFullVisible = false;
  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        ThemeModelInheritedNotifier.of(context).theme == AppTheme.darkTheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 25,
        vertical: 20,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: lightGrey),
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Certificates',
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w700, fontFamily: "sfPro"),
          ),
          const SizedBox(height: 12),
          Column(
            children:
                List.generate(widget.item.certificateFile.length, (index) {
              final item = widget.item.certificateFile[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                          color: isDarkMode ? white : black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: "sfPro"),
                      children: [
                        TextSpan(text: '${item["name"]}\n'),
                        TextSpan(
                          text:
                              '${DateFormat("dd MMMM yyyy").format(DateTime.parse(item["date"]))} year',
                          style: const TextStyle(color: kgreyColor),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  WPdf(data: item),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}

class WSalary extends StatefulWidget {
  const WSalary({super.key, required this.item});
  final EmployeeDatum item;
  @override
  State<WSalary> createState() => _WSalaryState();
}

class _WSalaryState extends State<WSalary> {
  bool isFullVisible = false;
  @override
  Widget build(BuildContext context) {
    final item = widget.item.salaryResponse;
    bool isDarkMode =
        ThemeModelInheritedNotifier.of(context).theme == AppTheme.darkTheme;
    final money = item.nameCode == "UZS"
        ? "so'm"
        : item.nameCode == "USD"
            ? "\$"
            : "₽";
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 25,
        vertical: 20,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: lightGrey),
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Salary',
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w700, fontFamily: "sfPro"),
          ),
          const SizedBox(height: 12),
          ShaderMask(
            blendMode: BlendMode.srcIn,
            shaderCallback: (Rect bounds) => LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  isDarkMode ? white : black,
                  (isFullVisible)
                      ? isDarkMode
                          ? white.withOpacity(0.1)
                          : black.withOpacity(0.1)
                      : isDarkMode
                          ? white
                          : black,
                ]).createShader(bounds),
            child: RichText(
              text: TextSpan(
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontFamily: "sfPro"),
                children: [
                  TextSpan(
                      text:
                          '${widget.item.salaryResponse.money.toStringAsFixed(0)} $money\n'),
                ],
              ),
              maxLines: (isFullVisible) ? null : 4,
            ),
          ),
        ],
      ),
    );
  }
}
