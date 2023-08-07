import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});
  static const routeName = "/about-app";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'About App',
          style: TextStyle(
              fontFamily: "sfPro", fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  // Display app logo here
                  SvgPicture.asset(
                    'assets/svg/logo.svg', // Replace with your app's logo asset
                    width: 100,
                    height: 100,
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Naseeb',
                    style: TextStyle(
                      fontSize: 40,
                      fontFamily: "logo",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'App Description',
              style: TextStyle(
                fontSize: 20.0,
                fontFamily: "sfPro",
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Provide a brief description of your app and its features.',
              style: TextStyle(fontFamily: "sfPro"),
            ),

            const SizedBox(height: 20),

            const Text(
              'Version Information',
              style: TextStyle(
                fontSize: 20.0,
                fontFamily: "sfPro",
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Version: 1.0.0',
              style: TextStyle(fontFamily: "sfPro"),
            ),
            // Display release notes section if applicable

            const SizedBox(height: 20),

            const Text(
              'Developer Information',
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: "sfPro"),
            ),
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.business),
              title: const Text(
                'Company Name',
                style: TextStyle(fontFamily: "sfPro"),
              ),
              subtitle: const Text(
                'Cyber Society',
                style: TextStyle(fontFamily: "sfPro"),
              ),
              onTap: () {
                // Implement company website functionality here
              },
            ),
            ListTile(
              leading: const Icon(Icons.email),
              title: const Text(
                'Email',
                style: TextStyle(fontFamily: "sfPro"),
              ),
              subtitle: const Text(
                'info@csgroup.com',
                style: TextStyle(fontFamily: "sfPro"),
              ),
              onTap: () {
                // Implement email functionality here
              },
            ),

            const SizedBox(height: 20),

            const Text(
              'Credits and Acknowledgments',
              style: TextStyle(
                fontSize: 20.0,
                fontFamily: "sfPro",
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Special thanks to the following contributors:',
              style: TextStyle(fontFamily: "sfPro"),
            ),

            // Display a list of contributors or third-party resources

            const SizedBox(height: 20),

            const Text(
              'Feedback and Ratings',
              style: TextStyle(
                fontSize: 20.0,
                fontFamily: "sfPro",
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.star),
              title: const Text(
                'Rate Us',
                style: TextStyle(fontFamily: "sfPro"),
              ),
              onTap: () {
                // Implement app store link for ratings/reviews
              },
            ),
            ListTile(
              leading: const Icon(Icons.feedback),
              title: const Text(
                'Send Feedback',
                style: TextStyle(fontFamily: "sfPro"),
              ),
              onTap: () {
                // Implement feedback functionality here
              },
            ),
          ],
        ),
      ),
    );
  }
}
