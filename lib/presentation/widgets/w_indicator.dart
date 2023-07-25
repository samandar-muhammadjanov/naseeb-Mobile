import 'package:flutter/material.dart';

class StatusIndicator extends StatelessWidget {
  const StatusIndicator({
    Key? key,
    required this.background,
    required this.text,
    required this.textColor,
  }) : super(key: key);

  final Color background;
  final String text;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 20,
        decoration: BoxDecoration(
            color: background,
            borderRadius: const BorderRadius.all(Radius.circular(6))),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: 12,
              fontWeight: FontWeight.w500,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }
}