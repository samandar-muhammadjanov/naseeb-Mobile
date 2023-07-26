import 'package:flutter/material.dart';

Widget wButton(Function()? onTap, String text,
    {Color color = const Color(0xff3498DB)}) {
  return InkWell(
    borderRadius: BorderRadius.circular(15),
    onTap: onTap,
    child: Ink(
      height: 56,
      width: 343,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(15)),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              fontFamily: "sfPro"),
        ),
      ),
    ),
  );
}
