// ignore_for_file: non_constant_identifier_names

import 'package:http/http.dart' as http;
import 'package:naseeb/domain/models/get_employee_detail_model.dart';
import 'package:naseeb/domain/models/get_employee_model.dart';
import 'package:naseeb/domain/repositories/urls.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    print(response.body);
    if (response.statusCode == 200) {
      GetEmployeeDetail employeeDetail =
          getEmployeeDetailFromJson(response.body);
      return employeeDetail;
    } else {
      return throw Exception(response.body);
    }
  }
}
