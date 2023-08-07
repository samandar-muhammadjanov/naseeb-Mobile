import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});
  static const routeName = "/help";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Help',
          style: TextStyle(
              fontFamily: "sfPro", fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Frequently Asked Questions',
              style: TextStyle(
                fontSize: 20.0,
                fontFamily: "sfPro",
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            const FAQCard(
              question: 'How do I create an account?',
              answer:
                  'To create an account, go to the registration page and provide your email...',
            ),
            const FAQCard(
              question: 'I forgot my password. How can I reset it?',
              answer:
                  'If you forgot your password, you can reset it by clicking on the "Forgot Password" link...',
            ),
            // Add more FAQCard widgets for additional questions

            const SizedBox(height: 20.0),

            const Text(
              'Contact Us',
              style: TextStyle(
                fontSize: 20.0,
                fontFamily: "sfPro",
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            ListTile(
              leading: const Icon(Icons.email),
              title: const Text(
                'Email',
                style: TextStyle(fontFamily: "sfPro"),
              ),
              subtitle: const Text(
                'info@naseeb.com',
                style: TextStyle(fontFamily: "sfPro"),
              ),
              onTap: () {
                // Implement email functionality here
              },
            ),
            ListTile(
              leading: const Icon(Icons.phone),
              title: const Text(
                'Phone',
                style: TextStyle(fontFamily: "sfPro"),
              ),
              subtitle: const Text(
                '+998 (90) 066-01-00',
                style: TextStyle(fontFamily: "sfPro"),
              ),
              onTap: () {
                // Implement phone functionality here
              },
            ),
            ListTile(
              leading: const Icon(Icons.location_on),
              title: const Text(
                'Address',
                style: TextStyle(fontFamily: "sfPro"),
              ),
              subtitle: const Text(
                '123 Main Street, City, Country',
                style: TextStyle(fontFamily: "sfPro"),
              ),
              onTap: () {
                // Implement address functionality here
              },
            ),
            // Add more contact options like live chat, social media, etc.
          ],
        ),
      ),
    );
  }
}

class FAQCard extends StatelessWidget {
  final String question;
  final String answer;

  const FAQCard({super.key, required this.question, required this.answer});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        question,
        style: const TextStyle(fontFamily: "sfPro"),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            answer,
            style: const TextStyle(fontFamily: "sfPro"),
          ),
        ),
      ],
    );
  }
}
