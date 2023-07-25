import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void _showDialog(Widget child, BuildContext context) {
  showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
            height: 216,
            padding: const EdgeInsets.only(top: 6.0),
            // The Bottom margin is provided to align the popup above the system
            // navigation bar.
            margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            // Provide a background color for the popup.
            color: CupertinoColors.systemBackground.resolveFrom(context),
            // Use a SafeArea widget to avoid system overlaps.
            child: SafeArea(
              top: false,
              child: child,
            ),
          ));
}

showDate(
    {required DateTime date,
    required BuildContext context,
    required TextEditingController birthDate,
    required DateTime lastDate,
    required DateTime firstDate}) {
  Platform.isIOS
      ? _showDialog(
          CupertinoDatePicker(
            initialDateTime: date,
            mode: CupertinoDatePickerMode.date,
            use24hFormat: true,
            // This is called when the user changes the date.
            onDateTimeChanged: (DateTime newDate) {
              date = newDate;
              birthDate.text = DateFormat('yyyy-MM-dd').format(date);
            },
          ),
          context)
      : showDatePicker(
              context: context,
              initialDate: date,
              firstDate: firstDate,
              lastDate: lastDate)
          .then((value) {
          date = value!;
          birthDate.text = DateFormat('yyyy-MM-dd').format(date);
        });
}
