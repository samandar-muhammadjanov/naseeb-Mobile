import 'package:flutter/material.dart';
import 'package:naseeb/utils/colors.dart';

class WMainInformation extends StatefulWidget {
  const WMainInformation({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.body,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final String body;

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
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          Text(widget.subtitle),
          const SizedBox(height: 15),
          ShaderMask(
            blendMode: BlendMode.srcIn,
            shaderCallback: (Rect bounds) => LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [black, (isShort) ? black.withOpacity(0.1) : black])
                .createShader(bounds),
            child: Text(
              'Lorem ipsum dolor sit amet. Qui dicta sequi aut ipsa aliquid qui nulla reprehenderit At tenetur placeat ab inventore nihil. Cum soluta consequatur cum sint facere sed voluptatibus dolores qui iusto alias ad optio aspernatur eos obcaecati doloribus et galisum quasi. Est distinctio quam nam quia impedit ut velit dolores. Non quia dolore aut nulla architecto qui nobis iusto et rerum placeat et dolore laborum qui quae voluptatum.A adipisci suscipit et perspiciatis minima et tempore velit. Aut iste esse sit nobis omnis ut aliquid harum aut voluptatem assumenda eos unde voluptates qui dolorem sint et repellat saepe. awfiu fwaifhaw ',
              style: TextStyle(fontSize: 14),
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
                  color: kprimaryColor,
                  fontSize: 14,
                ),
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
                  color: kprimaryColor,
                  fontSize: 14,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class WWorkExperience extends StatefulWidget {
  const WWorkExperience({super.key});

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
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
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
              text: TextSpan(
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                children: [
                  TextSpan(text: 'Graphic Designer\n'),
                  TextSpan(text: '“PALONCHI” IT COMPANY\n'),
                  TextSpan(
                    text: '2 years • 2020 November - 2022 July\n\n',
                    style: TextStyle(color: kgreyColor),
                  ),
                  TextSpan(
                    text:
                        'Lorem ipsum dolor sit amet. Qui dicta sequi aut ipsa aliquid qui nulla reprehenderit At tenetur placeat ab inventore nihil. Cum soluta consequatur cum sint facere sed voluptatibus dolores qui iusto alias ad optio aspernatur eos obcaecati doloribus et galisum quasi. Est distinctio quam nam quia impedit ut velit dolores. Non quia dolore aut nulla architecto qui nobis iusto et rerum placeat et dolore laborum qui quae voluptatum.A adipisci suscipit et perspiciatis minima et tempore velit. Aut iste esse sit nobis omnis ut aliquid harum aut voluptatem assumenda eos unde voluptates qui dolorem sint et repellat saepe. awfiu fwaifhaw ',
                  )
                ],
              ),
              maxLines: (isFullVisible) ? null : 7,
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
                  color: kprimaryColor,
                  fontSize: 14,
                ),
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
                  color: kprimaryColor,
                  fontSize: 14,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class WEducation extends StatefulWidget {
  const WEducation({super.key});

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
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
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
              text: TextSpan(
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                children: [
                  TextSpan(text: 'Kamoliddin Bekzod rassomchilik instituti\n'),
                  TextSpan(text: 'Specialization - Dizayner rassom\n'),
                  TextSpan(
                    text: '2-kurs • 2020 - 2024\n\n',
                    style: TextStyle(color: kgreyColor),
                  ),
                  TextSpan(
                    text:
                        'Lorem ipsum dolor sit amet. Qui dicta sequi aut ipsa aliquid qui nulla reprehenderit At tenetur placeat ab inventore nihil. Cum soluta consequatur cum sint facere sed voluptatibus dolores qui iusto alias ad optio aspernatur eos obcaecati doloribus et galisum quasi. Est distinctio quam nam quia impedit ut velit dolores. Non quia dolore aut nulla architecto qui nobis iusto et rerum placeat et dolore laborum qui quae voluptatum.A adipisci suscipit et perspiciatis minima et tempore velit. Aut iste esse sit nobis omnis ut aliquid harum aut voluptatem assumenda eos unde voluptates qui dolorem sint et repellat saepe. awfiu fwaifhaw ',
                  )
                ],
              ),
              maxLines: (isFullVisible) ? null : 6,
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
                  color: kprimaryColor,
                  fontSize: 14,
                ),
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
                  color: kprimaryColor,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WLanguage extends StatefulWidget {
  const WLanguage({super.key});

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
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
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
              text: TextSpan(
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                children: [
                  TextSpan(text: 'Uzbek - Mother language\n'),
                  TextSpan(text: 'Russian - Intermediate\n'),
                  TextSpan(text: 'English - Beginner\n\n'),
                  TextSpan(
                    text:
                        'Lorem ipsum dolor sit amet. Qui dicta sequi aut ipsa aliquid qui nulla reprehenderit At tenetur placeat ab inventore nihil. Cum soluta consequatur cum sint facere sed voluptatibus dolores qui iusto alias ad optio aspernatur eos obcaecati doloribus et galisum quasi. Est distinctio quam nam quia impedit ut velit dolores. Non quia dolore aut nulla architecto qui nobis iusto et rerum placeat et dolore laborum qui quae voluptatum.A adipisci suscipit et perspiciatis minima et tempore velit. Aut iste esse sit nobis omnis ut aliquid harum aut voluptatem assumenda eos unde voluptates qui dolorem sint et repellat saepe. awfiu fwaifhaw ',
                  )
                ],
              ),
              maxLines: (isFullVisible) ? null : 6,
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
                  color: kprimaryColor,
                  fontSize: 14,
                ),
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
                  color: kprimaryColor,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WCertificate extends StatefulWidget {
  const WCertificate({super.key});

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
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          RichText(
            text: TextSpan(
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
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
          // WPdf(),
          const SizedBox(height: 10),
          Visibility(
              visible: isFullVisible,
              child: Text(
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
                  color: kprimaryColor,
                  fontSize: 14,
                ),
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
                  color: kprimaryColor,
                  fontSize: 14,
                ),
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
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
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
              text: TextSpan(
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
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
                  color: kprimaryColor,
                  fontSize: 14,
                ),
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
                  color: kprimaryColor,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
