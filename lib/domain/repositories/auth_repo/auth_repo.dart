// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:naseeb/domain/repositories/urls.dart';
import 'package:naseeb/presentation/pages/employee/home_page.dart';
import 'package:naseeb/presentation/pages/employer/home_page.dart';
import 'package:naseeb/presentation/pages/intro/verify_phone_page.dart';
import 'package:naseeb/presentation/pages/intro/widgets/w_successOrError.dart';
import 'package:naseeb/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  bool isLogined = false;
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
            user: body["message"],
          ),
        ),
      );
    } else {
      showCustomDialog(
          context: context,
          status: Image.asset("assets/images/close.png"),
          title: "Error!",
          body: body["message"],
          textButton: "Done",
          onTap: () => Navigator.pop(context),
          btnColor: MyColor.salary);
    }
  }

  static Future<void> resendCode(String phone, BuildContext context) async {
    var request =
        http.MultipartRequest('POST', Uri.parse(BASE_URL + CODE_SEND));
    request.fields.addAll({'phone': phone.split(" ").join()});

    http.Response response =
        await http.Response.fromStream(await request.send());
    final body = jsonDecode(response.body);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 4),
        content: Text("Your code ${body["data"]["code"]}"),
      ),
    );
  }

  static Future<void> codeVerify(
      String phone, String code, BuildContext context, String user) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse(BASE_URL + CODE_VERIFY));
    request.body = json.encode(
        {"phone": phone.split(" ").join().split("+").join(), "code": code});
    request.headers.addAll(headers);

    http.Response response =
        await http.Response.fromStream(await request.send());
    final body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      showSuccessOrError(context, response, user, phone, body);
    } else {
      showSuccessOrError(context, response, user, phone, body);
    }
  }

  Future<void> registration(
      lastName,
      firstName,
      email,
      String phone,
      gender,
      birthDate,
      description,
      role,
      dynamic address,
      BuildContext context) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse(BASE_URL + REGISTER));
    request.body = json.encode({
      "lastName": lastName,
      "firstName": firstName,
      "email": email,
      "phone": phone.split(" ").join(),
      "genderEnum": gender,
      "bornYear": birthDate,
      "description": description,
      "role": role,
      "language": "UZB",
      "address": {
        "region": address.region,
        "city": address.city,
        "latitude": address.lat,
        "longitude": address.long
      }
    });
    request.headers.addAll(headers);

    http.Response response =
        await http.Response.fromStream(await request.send());
    final body = jsonDecode(response.body);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (response.statusCode == 201) {
      isLogined = true;
      await preferences.setBool("isLogined", isLogined);
      await preferences.setString("accessToken", body['data']['token']);

      await preferences.setBool(
          "isEmployee", role == "role_employee" ? true : false);
      Navigator.pushNamedAndRemoveUntil(
          context,
          role == "role_employee"
              ? EmployeeHomePage.routeName
              : EmployerHomePage.routeName,
          (route) => false);
    } else {
      showCustomDialog(
          context: context,
          status: Image.asset(
            "assets/images/close.png",
            width: 80,
          ),
          title: "Error!",
          body: body["message"],
          textButton: "Done",
          onTap: () => Navigator.pop(context),
          btnColor: MyColor.salary);
    }
  }

  Future<dynamic> auth(String phone) async {
    var request = http.MultipartRequest('GET', Uri.parse(BASE_URL + AUTH));
    request.fields.addAll({'phone': phone.split(" ").join()});

    http.Response response =
        await http.Response.fromStream(await request.send());
    final body = jsonDecode(response.body);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final role = body["data"]["user"]["roles"][0];
    if (response.statusCode == 201) {
      isLogined = true;
      await preferences.setBool("isLogined", isLogined);
      await preferences.setString("accessToken", body['data']['token']);
      await preferences.setBool(
          "isEmployee", role == "role_employee" ? true : false);
      return body;
    } else {
      return throw Exception(body["message"]);
    }
  }
}
