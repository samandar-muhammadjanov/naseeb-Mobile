// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:http/http.dart' as http;
import 'package:naseeb/domain/models/get_employee_detail_model.dart';
import 'package:naseeb/domain/repositories/unic_repo/unic_repo.dart';
import 'package:naseeb/domain/repositories/urls.dart';
import 'package:naseeb/presentation/pages/employee/details/create_cv_page.dart';
import 'package:naseeb/presentation/pages/employee/home_page.dart';
import 'package:naseeb/presentation/pages/intro/create_employee_profile_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmployeeRepo {
  Future<SharedPreferences> preference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences;
  }

  Future<void> createEmployeeProfile(
      description, workType, salary, categoryId, BuildContext context) async {
    final prefs = await preference();
    final token = prefs.getString("accessToken");
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request =
        http.Request('POST', Uri.parse(BASE_URL + CREATE_EMPLOYEE_PROFILE));
    request.body = json.encode({
      "description": description,
      "workType": workType,
      "categoryId": categoryId,
      "salaryRequest": {"formOfService": "", "money": salary}
    });
    request.headers.addAll(headers);

    http.Response response =
        await http.Response.fromStream(await request.send());
    final body = jsonDecode(response.body);
    Hive.box("authData").put("employeeId", body["data"]["id"]);
    if (response.statusCode == 200) {
      Navigator.pushNamedAndRemoveUntil(
          context, CreateCVPage.routeName, (route) => false);
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<GetEmployeeDetail> getEmployeeDetail(ID) async {
    final prefs = await preference();
    final token = prefs.getString("accessToken");
    var headers = {'Authorization': 'Bearer $token'};
    var request =
        http.Request('GET', Uri.parse(BASE_URL + GET_EMPLOYEES_ID + ID));
    request.headers.addAll(headers);

    http.Response response =
        await http.Response.fromStream(await request.send());
    if (response.statusCode == 200) {
      GetEmployeeDetail employeeDetail =
          getEmployeeDetailFromJson(response.body);

      return employeeDetail;
    } else {
      return throw Exception(response.body);
    }
  }

  Future<void> checkToEmployee(BuildContext context) async {
    final prefs = await preference();
    final token = prefs.getString("accessToken");
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request('GET', Uri.parse(BASE_URL + CHECK_EMPLOYEE));

    request.headers.addAll(headers);

    http.Response response =
        await http.Response.fromStream(await request.send());
    final body = jsonDecode(response.body);
    if (body["success"] == true) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.setBool("isEmployee", true);
      UnicRepo().changeRole('role_employee');
      Navigator.pushNamedAndRemoveUntil(
          context, CreateEmployeeProfilePage.routeName, (route) => false);
    } else {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.setBool("isEmployee", true);
      UnicRepo().changeRole('role_employee');
      Navigator.pushNamedAndRemoveUntil(
          context, EmployeeHomePage.routeName, (route) => false);
    }
  }
}
