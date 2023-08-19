// ignore_for_file: deprecated_member_use

import 'dart:convert';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:naseeb/config/app_theme.dart';
import 'package:naseeb/presentation/widgets/w_loading.dart';
import 'package:naseeb/utils/colors.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';

class ChatInsidePage extends StatefulWidget {
  const ChatInsidePage({super.key});
  static const routeName = "/employee/chat/1";

  @override
  State<ChatInsidePage> createState() => _ChatInsidePageState();
}

class _ChatInsidePageState extends State<ChatInsidePage> {
  TextEditingController _controller = TextEditingController();
  final channel =
      IOWebSocketChannel.connect('ws://192.168.0.97:8082/chat/app/chat');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Listen for messages
    channel.stream.listen(
      (message) {
        print('Received: $message');
      },
      onError: (error) {
        print('Error: $error');
      },
    );
// Send a message
    channel.sink.add('Hello, WebSocket!');
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        ThemeModelInheritedNotifier.of(context).theme == AppTheme.darkTheme;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              "assets/svg/dots.svg",
              color: isDarkMode ? white : black,
            ),
          )
        ],
        toolbarHeight: 85,
        titleSpacing: 0,
        title: ListTile(
          title: const Text(
            "Jasur Nigmanov",
            style: TextStyle(
                fontSize: 16, fontFamily: "sfPro", fontWeight: FontWeight.w700),
          ),
          subtitle: const Text(
            "online",
            style: TextStyle(
                color: kprimaryColor, fontSize: 12, fontFamily: "sfPro"),
          ),
          leading: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), color: kgreyColor),
          ),
        ),
      ),
      // T
      // body: StreamBuilder(
      //   stream: channel.stream,
      //   builder: (context, snapshot) {
      //     return Padding(
      //       padding: const EdgeInsets.symmetric(vertical: 24.0),
      //       child: Text(snapshot.hasData ? '${snapshot.data}' : ''),
      //     );
      //   },
      // )
      // bottomNavigationBar: Padding(
      //   padding: EdgeInsets.only(
      //       left: 16.0,
      //       right: 16,
      //       top: 16,
      //       bottom: MediaQuery.of(context).viewInsets.bottom != 0
      //           ? MediaQuery.of(context).viewInsets.bottom + 16
      //           : 16),
      //   child: Row(
      //     children: [
      //       Expanded(
      //         child: TextField(
      //           decoration: InputDecoration(
      //               prefixIcon: IconButton(
      //                   onPressed: () {},
      //                   icon: SvgPicture.asset("assets/svg/scirpt.svg")),
      //               hintText: "Write your message",
      //               hintStyle: const TextStyle(
      //                   color: kgreyColor, fontSize: 16, fontFamily: "sfPro"),
      //               border: OutlineInputBorder(
      //                   borderSide: const BorderSide(color: kgreyColor),
      //                   borderRadius: BorderRadius.circular(15))),
      //         ),
      //       ),
      //       const SizedBox(
      //         width: 10,
      //       ),
      //       FloatingActionButton(
      //         onPressed: () {
      //           channel.sink.add('Hello, SockJS Server!');
      //         },
      //         elevation: 0,
      //         shape: RoundedRectangleBorder(
      //             borderRadius: BorderRadius.circular(15)),
      //         child: SvgPicture.asset("assets/svg/send.svg"),
      //       )
      //     ],
      //   ),
      // ),
    );
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      print("Adding message: ${_controller.text}");
      channel.sink.add(_controller.text);
    }
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }
}
