// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:naseeb/domain/models/about_user_model.dart';
import 'package:naseeb/domain/repositories/urls.dart';
import 'package:naseeb/presentation/pages/intro/widgets/w_successOrError.dart';
import 'package:naseeb/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../models/address_model.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

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
      AboutUser user = aboutUserFromJson(utf8.decode(response.bodyBytes));
      return user;
    } else {
      return throw Exception(response.body);
    }
  }

  Future<void> updateUser(ID, firstName, lastName, gender, bornYear,
      description, AddressModel address, phone, BuildContext context) async {
    final prefs = await preference();
    final token = prefs.getString("accessToken");
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request('PUT', Uri.parse(BASE_URL + UPDATE_USER + ID));
    request.body = json.encode({
      "lastName": lastName,
      "firstName": firstName,
      "phone": phone,
      "gender": gender,
      "bornYear": bornYear,
      "description": description,
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

  Future<void> uploadUserPhoto(String pic) async {
    
    final prefs = await preference();
    final token = prefs.getString("accessToken");
    var headers = {'Authorization': 'Bearer $token'};
    File file = File(pic);
    String mimeType = lookupMimeType(file.path) ?? 'application/octet-stream';
    var request =
        http.MultipartRequest('POST', Uri.parse(BASE_URL + UPLOAD_USER_PHOTO));
    request.files.add(await http.MultipartFile.fromPath('pic', file.path,
        contentType: MediaType.parse(mimeType)));
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
}
