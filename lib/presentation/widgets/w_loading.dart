import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:naseeb/utils/colors.dart';

Center buildLoading() {
  return const Center(
    child: SpinKitPulse(
      color: kprimaryColor,
    ),
  );
}
