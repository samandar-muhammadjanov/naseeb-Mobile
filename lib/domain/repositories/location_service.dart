// ignore_for_file: non_constant_identifier_names

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class LocationService {
  String kPLACES_API_KEY = "AIzaSyDb6_C33guxksbYIFHFnsHU2o-QX7i0bxQ";
  Future<String> getPlaceId(String input, String sessionToken) async {
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input&key=$kPLACES_API_KEY&sessiontoken=$sessionToken';
    var response = await http.get(Uri.parse(request));

    var json = convert.jsonDecode(response.body);
    var placeId = json['predictions'][0]['place_id'] as String;

    return placeId;
  }

  Future<void> getPlaceFromLatLng(latitude, longitude) async {
    var response = await http.get(Uri.parse(
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$kPLACES_API_KEY"));
    var json = convert.jsonDecode(response.body);
    print(json);
  }

  Future<Map<String, dynamic>> getPlace(
      String input, String sessionToken) async {
    final placeId = await getPlaceId(input, sessionToken);
    String baseURL = 'https://maps.googleapis.com/maps/api/place/details/json';
    String request = '$baseURL?place_id=$placeId&key=$kPLACES_API_KEY';
    var response = await http.get(Uri.parse(request));

    var json = convert.jsonDecode(response.body);
    var results = json['result'] as Map<String, dynamic>;
    return results;
  }
}
