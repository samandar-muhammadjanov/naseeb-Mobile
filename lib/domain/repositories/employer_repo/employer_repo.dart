// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:naseeb/domain/models/get_employee_detail_model.dart';
import 'package:naseeb/domain/models/get_employee_model.dart';
import 'package:naseeb/domain/models/post_model.dart';
import 'package:naseeb/domain/repositories/urls.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/address_model.dart';

class EmployerRepo {
  Future<SharedPreferences> preference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences;
  }

  Future<GetEmployee> getEmployees(ID, RADIUS) async {
    final prefs = await preference();
    final token = prefs.getString("accessToken");
    var headers = {'Authorization': 'Bearer $token'};
    var request =
        http.Request('GET', Uri.parse('$BASE_URL$GET_EMPLOYEES$ID/$RADIUS'));

    request.headers.addAll(headers);

    http.Response response =
        await http.Response.fromStream(await request.send());
    if (response.statusCode == 200) {
      GetEmployee getEmployees = getEmployeeFromJson(response.body);
      return getEmployees;
    } else {
      return throw Exception(response.body);
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

  Future<void> addPost(
    description,
    time,
    amount,
    categoryId,
    AddressModel address,
  ) async {
    final prefs = await preference();
    final token = prefs.getString("accessToken");
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request('POST', Uri.parse(BASE_URL + ADD_POST));
    request.body = json.encode({
      "description": description,
      "fixedTime": time,
      "amountMoney": amount,
      "categoryId": categoryId,
      "address": {
        "region": address.region,
        "city": address.city,
        "latitude": address.lat,
        "longitude": address.long
      },
      "posterSampleIdList": [1, 2]
    });
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

  Future<Posts> getAllPosts() async {
    final prefs = await preference();
    final token = prefs.getString("accessToken");
    var headers = {'Authorization': 'Bearer $token'};
    var request =
        http.MultipartRequest('GET', Uri.parse(BASE_URL + GET_ALL_POST));
    request.fields.addAll({'page': '0', 'size': '100000'});

    request.headers.addAll(headers);

    http.Response response =
        await http.Response.fromStream(await request.send());
    print(response.body);
    if (response.statusCode == 200) {
      Posts posts = postsFromJson(response.body);
      return posts;
    } else {
      return throw Exception(response.body);
    }
  }
}
