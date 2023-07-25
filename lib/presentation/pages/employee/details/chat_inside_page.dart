import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:naseeb/utils/colors.dart';

class EmployeeChatInsidePage extends StatelessWidget {
  const EmployeeChatInsidePage({super.key});
  static const routeName = "/employee/chat/1";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset("assets/svg/dots.svg"),
          )
        ],
        toolbarHeight: 85,
        titleSpacing: 0,
        title: ListTile(
          title: const Text(
            "Jasur Nigmanov",
            style: TextStyle(
                fontSize: 16,
                color: Color(0xff171725),
                fontWeight: FontWeight.w700),
          ),
          subtitle: const Text(
            "online",
            style: TextStyle(color: kprimaryColor, fontSize: 12),
          ),
          leading: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), color: kgreyColor),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                    prefixIcon: IconButton(
                        onPressed: () {},
                        icon: SvgPicture.asset("assets/svg/scirpt.svg")),
                    hintText: "Write your message",
                    hintStyle: const TextStyle(color: kgreyColor, fontSize: 16),
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(color: kgreyColor),
                        borderRadius: BorderRadius.circular(15))),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            FloatingActionButton(
              onPressed: () {},
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: SvgPicture.asset("assets/svg/send.svg"),
            )
          ],
        ),
      ),
    );
  }
}
