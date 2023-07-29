import 'package:naseeb/domain/models/about_user_model.dart';
import 'package:naseeb/domain/repositories/urls.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UserRepo {
  Future<SharedPreferences> preference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences;
  }

  Future<AboutUser> aboutUser() async {
    final prefs = await preference();
    final token = prefs.getString("accessToken");
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request(
      'GET',
      Uri.parse(BASE_URL + ABOUT_USER),
    );

    request.headers.addAll(headers);

    http.Response response =
        await http.Response.fromStream(await request.send());

    if (response.statusCode == 200) {
      AboutUser user = aboutUserFromJson(response.body);
      return user;
    } else {
      return throw Exception(response.body);
    }
  }
}
