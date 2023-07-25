// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:naseeb/domain/repositories/urls.dart';
import 'package:naseeb/presentation/pages/intro/verify_phone_page.dart';

class AuthRepo {
  static Future<void> codeSend(String phone, BuildContext context) async {
    var request =
        http.MultipartRequest('POST', Uri.parse(BASE_URL + CODE_SEND));
    request.fields.addAll({'phone': phone.split(" ").join()});

    http.Response response =
        await http.Response.fromStream(await request.send());
    final body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VerifyPhonePage(
            phoneNumber: phone,
            code: body["data"]["code"],
          ),
        ),
      );
    } else {
      print(response.reasonPhrase);
    }
  }
}
