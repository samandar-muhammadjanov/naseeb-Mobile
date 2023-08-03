import 'package:naseeb/domain/models/categories_model.dart';
import 'package:naseeb/domain/repositories/urls.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UnicRepo {
  Future<SharedPreferences> preference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences;
  }

  Future<List<Datum>> getCategories(pattern) async {
    final prefs = await preference();
    final token = prefs.getString("accessToken");
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request(
        'GET', Uri.parse('$BASE_URL$CATEGORIES?nameUz=$pattern&nameRu='));

    request.headers.addAll(headers);

    http.Response response =
        await http.Response.fromStream(await request.send());

    if (response.statusCode == 200) {
      Categories categories = categoriesFromJson(response.body);
      return categories.data;
    } else {
      return throw Exception(response.body);
    }
  }

  Future<void> changeRole(role) async {
    final prefs = await preference();
    final token = prefs.getString("accessToken");
    var headers = {'Authorization': 'Bearer $token'};
    var request =
        http.MultipartRequest('GET', Uri.parse(BASE_URL + CHANGE_ROLE));
    request.fields.addAll({'role': role});

    request.headers.addAll(headers);

    await request.send();
  }
}
