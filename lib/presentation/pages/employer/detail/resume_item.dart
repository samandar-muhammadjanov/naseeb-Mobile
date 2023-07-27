import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:naseeb/presentation/pages/employer/detail/w_pdf.dart';
import 'package:naseeb/utils/colors.dart';
import '../../../../domain/models/get_employee_detail_model.dart';

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
  final Data state;
  @override
  State<WMainInformation> createState() => _WMainInformationState();
}

class _WMainInformationState extends State<WMainInformation> {
  bool isShort = true;

  @override
  Widget build(BuildContext context) {
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
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.w700, fontFamily: "sfPro"),
          ),
          const SizedBox(height: 12),
          Text(
            widget.subtitle,
            style: const TextStyle(fontFamily: "sfPro"),
          ),
          const SizedBox(height: 15),
          ShaderMask(
            blendMode: BlendMode.srcIn,
            shaderCallback: (Rect bounds) => LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [black, (isShort) ? black.withOpacity(0.1) : black])
                .createShader(bounds),
            child: Text(
              widget.state.registerResponse.description,
              style: const TextStyle(fontSize: 14, fontFamily: "sfPro"),
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
  final Data item;
  @override
  State<WWorkExperience> createState() => _WWorkExperienceState();
}

class _WWorkExperienceState extends State<WWorkExperience> {
  bool isFullVisible = false;

  @override
  Widget build(BuildContext context) {
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
                        black,
                        (isFullVisible) ? black : black.withOpacity(0.1)
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
                      style: const TextStyle(
                          color: Colors.black,
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
  final Data item;
  @override
  State<WEducation> createState() => _WEducationState();
}

class _WEducationState extends State<WEducation> {
  bool isFullVisible = false;

  @override
  Widget build(BuildContext context) {
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
                        black,
                        (isFullVisible) ? black : black.withOpacity(0.1)
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
                        TextSpan(text: '${item.institution}\n'),
                        TextSpan(
                            text: 'Specialization - ${item.description}\n'),
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
  final Data item;
  @override
  State<WLanguage> createState() => _WLanguageState();
}

class _WLanguageState extends State<WLanguage> {
  bool isFullVisible = false;
  @override
  Widget build(BuildContext context) {
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
                  black,
                  (isFullVisible) ? black : black.withOpacity(0.1)
                ]).createShader(bounds),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                widget.item.languagesResponse.length,
                (index) {
                  final item = widget.item.languagesResponse[index];
                  final lang = item.name == "UZB"
                      ? "Uzbek"
                      : item.name == "ENG"
                          ? "English"
                          : "Russian";
                  return Text("$lang - ${item.level}");
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
  final Data item;
  @override
  State<WCertificate> createState() => _WCertificateState();
}

class _WCertificateState extends State<WCertificate> {
  bool isFullVisible = false;
  @override
  Widget build(BuildContext context) {
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
          RichText(
            text: const TextSpan(
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontFamily: "sfPro"),
              children: [
                TextSpan(text: 'Graphic design\n'),
                TextSpan(text: 'Course teacher - Palonchi Pistonchiyev\n'),
                TextSpan(
                  text: '16 February 2022 year',
                  style: TextStyle(color: kgreyColor),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          WPdf(data: widget.item.certificateFile.first),
          const SizedBox(height: 10),
          Visibility(
              visible: isFullVisible,
              child: const Text(
                'descri[tiopn',
                style: TextStyle(
                  fontSize: 14,
                ),
              )),
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

class WSalary extends StatefulWidget {
  const WSalary({super.key});

  @override
  State<WSalary> createState() => _WSalaryState();
}

class _WSalaryState extends State<WSalary> {
  bool isFullVisible = false;
  @override
  Widget build(BuildContext context) {
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
                  black,
                  (isFullVisible) ? black : black.withOpacity(0.1)
                ]).createShader(bounds),
            child: RichText(
              text: const TextSpan(
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontFamily: "sfPro"),
                children: [
                  TextSpan(text: '800\$\n\n'),
                  TextSpan(
                    text:
                        'Lorem ipsum dolor sit amet. Qui dicta sequi aut ipsa aliquid qui nulla reprehenderit At tenetur placeat ab inventore nihil. Cum soluta consequatur cum sint facere sed voluptatibus dolores qui iusto alias ad optio aspernatur eos obcaecati doloribus et galisum quasi. Est distinctio quam nam quia impedit ut velit dolores. Non quia dolore aut nulla architecto qui nobis iusto et rerum placeat et dolore laborum qui quae voluptatum.A adipisci suscipit et perspiciatis minima et tempore velit. Aut iste esse sit nobis omnis ut aliquid harum aut voluptatem assumenda eos unde voluptates qui dolorem sint et repellat saepe. awfiu fwaifhaw ',
                  )
                ],
              ),
              maxLines: (isFullVisible) ? null : 4,
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
