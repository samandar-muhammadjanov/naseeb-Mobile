// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:http/http.dart' as http;
import 'package:naseeb/domain/models/get_employee_detail_model.dart';
import 'package:naseeb/domain/models/post_for_employee.dart';
import 'package:naseeb/domain/repositories/unic_repo/unic_repo.dart';
import 'package:naseeb/domain/repositories/urls.dart';
import 'package:naseeb/presentation/pages/employee/details/create_cv_page.dart';
import 'package:naseeb/presentation/pages/employee/home_page.dart';
import 'package:naseeb/presentation/pages/intro/create_employee_profile_page.dart';
import 'package:naseeb/presentation/pages/intro/widgets/w_successOrError.dart';
import 'package:naseeb/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmployeeRepo {
  Future<SharedPreferences> preference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences;
  }

  Future<void> createEmployeeProfile(description, workType, salary, categoryId,
      BuildContext context, nameCode) async {
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
      "salaryRequest": {
        "nameCode": nameCode == "ONLINE" ? "ONLAIN" : nameCode,
        "money": salary
      }
    });
    request.headers.addAll(headers);

    http.Response response =
        await http.Response.fromStream(await request.send());
    final body = jsonDecode(response.body);
    print(body);
    Hive.box("authData").put("employeeId", body["data"]["id"]);
    if (response.statusCode == 200) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => CreateCVPage(
            isFromBegin: true,
          ),
        ),
        (route) => false,
      );
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
          getEmployeeDetailFromJson(utf8.decode(response.bodyBytes));

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

  Future<void> addExperience(
      {required String level,
      required String begin,
      required String end,
      required String description,
      required String company,
      required String asWho,
      required BuildContext context}) async {
    final prefs = await preference();
    final token = prefs.getString("accessToken");
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request('POST', Uri.parse(BASE_URL + ADD_EXPERIENCE));
    request.body = json.encode({
      "level": level,
      "begin": begin,
      "end": end,
      "description": description,
      "company": company,
      "asWho": asWho
    });
    request.headers.addAll(headers);

    http.Response response =
        await http.Response.fromStream(await request.send());
    final body = jsonDecode(response.body);

    if (response.statusCode == 200) {
      showCustomDialog(
          context: context,
          status: SvgPicture.asset("assets/svg/success.svg"),
          title: "Success",
          body: "Data Updated Successfully",
          textButton: "Done",
          onTap: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
          btnColor: MyColor.kSuccessColor);
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

  Future<void> addEducation(
      {required BuildContext context,
      required String institution,
      required String level,
      required String description}) async {
    final prefs = await preference();
    final token = prefs.getString("accessToken");
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request('POST', Uri.parse(BASE_URL + ADD_EDUCATION));
    request.body = json.encode({
      "institution": institution,
      "level": level,
      "description": description
    });
    request.headers.addAll(headers);

    http.Response response =
        await http.Response.fromStream(await request.send());
    final body = jsonDecode(response.body);

    if (response.statusCode == 200) {
      showCustomDialog(
          context: context,
          status: SvgPicture.asset("assets/svg/success.svg"),
          title: "Success",
          body: "Data Updated Successfully",
          textButton: "Done",
          onTap: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
          btnColor: MyColor.kSuccessColor);
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

  Future<void> addLanguage(
      BuildContext context, name, level, description) async {
    final prefs = await preference();
    final token = prefs.getString("accessToken");
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request('POST', Uri.parse(BASE_URL + ADD_LANGUAGE));
    request.body = json.encode({
      "name": name,
      "level": level,
      "description": description,
    });
    request.headers.addAll(headers);

    http.Response response =
        await http.Response.fromStream(await request.send());
    final body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      showCustomDialog(
          context: context,
          status: SvgPicture.asset("assets/svg/success.svg"),
          title: "Success",
          body: "Data Updated Successfully",
          textButton: "Done",
          onTap: () {
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pop(context);
          },
          btnColor: MyColor.kSuccessColor);
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

  Future<void> addCertificate(BuildContext context, date, name, path) async {
    final prefs = await preference();
    final token = prefs.getString("accessToken");
    var headers = {'Authorization': 'Bearer $token'};

    var request =
        http.MultipartRequest('POST', Uri.parse(BASE_URL + ADD_CERTIFICATE));
    request.fields.addAll({'date': date, 'name': name});
    request.files.add(await http.MultipartFile.fromPath('ser', path));
    request.headers.addAll(headers);

    http.Response response =
        await http.Response.fromStream(await request.send());
    final body = jsonDecode(response.body);
    print(body);
    if (response.statusCode == 200) {
      showCustomDialog(
          context: context,
          status: SvgPicture.asset("assets/svg/success.svg"),
          title: "Success",
          body: "Data Updated Successfully",
          textButton: "Done",
          onTap: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
          btnColor: MyColor.kSuccessColor);
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

  Future<void> deleteLanguage(String ID) async {
    final prefs = await preference();
    final token = prefs.getString("accessToken");
    var headers = {'Authorization': 'Bearer $token'};
    var request =
        http.Request('DELETE', Uri.parse(BASE_URL + DELETE_LANGUAGE + ID));

    request.headers.addAll(headers);

    http.Response response =
        await http.Response.fromStream(await request.send());
    print(response.body);

    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<PostsForEmplyeeModel> getPostsFormployee(String RADIUS) async {
    final prefs = await preference();
    final token = prefs.getString("accessToken");
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.MultipartRequest(
        'GET', Uri.parse(BASE_URL + GET_POST_FOR_EMPLOYEE + RADIUS));

    request.headers.addAll(headers);

    http.Response response =
        await http.Response.fromStream(await request.send());

    if (response.statusCode == 200) {
      PostsForEmplyeeModel posts = getPostsForEmplyeeFromJson(response.body);
      return posts;
    } else {
      return throw Exception(response.body);
    }
  }
}
