// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:naseeb/blocs/bloc_imports.dart';
import 'package:naseeb/domain/models/get_employee_model.dart';
import 'package:naseeb/domain/models/post_detail_model.dart';
import 'package:naseeb/domain/models/post_model.dart';
import 'package:naseeb/domain/repositories/urls.dart';
import 'package:naseeb/presentation/pages/employer/home_page.dart';
import 'package:naseeb/presentation/pages/intro/widgets/w_successOrError.dart';
import 'package:naseeb/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/address_model.dart';
import 'package:mime/mime.dart';

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
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 404) {
      GetEmployee getEmployees = getEmployeeFromJson(response.body);
      return getEmployees;
    } else {
      return throw Exception(response.body);
    }
  }

  Future<void> addPost(description, time, amount, categoryId,
      AddressModel address, BuildContext context, List images, nameCode) async {
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
      "amountMoney": {
        "nameCode": nameCode,
        "money": amount,
      },
      "categoryId": categoryId,
      "address": {
        "region": address.region,
        "city": address.city,
        "latitude": address.lat,
        "longitude": address.long
      },
      "posterSampleID": images
    });
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
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const EmployerHomePage(
                    index: 2,
                  ),
                ));
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

    if (response.statusCode == 200) {
      Posts posts = postsFromJson(response.body);
      return posts;
    } else {
      return throw Exception(response.body);
    }
  }

  Future<void> deletePost(ID, BuildContext context) async {
    final prefs = await preference();
    final token = prefs.getString("accessToken");
    var headers = {'Authorization': 'Bearer $token'};
    var request =
        http.Request('DELETE', Uri.parse(BASE_URL + DELETE_POST + ID));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      BlocBuilder<EmployerBloc, EmployerState>(
        builder: (context, state) {
          if (state is AllPostsLoaded) {
            context.read<EmployerBloc>()..add(GetAllPosts());
            return SizedBox();
          }
          return SizedBox();
        },
      );
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<List> uploadPhotoForPost(String pic) async {
    final prefs = await preference();
    final token = prefs.getString("accessToken");
    var headers = {'Authorization': 'Bearer $token'};
    File file = File(pic);
    String mimeType = lookupMimeType(file.path) ?? 'application/octet-stream';
    var request =
        http.MultipartRequest('POST', Uri.parse(BASE_URL + UPLOAD_PHOTO_POST));
    request.files.add(await http.MultipartFile.fromPath('pic', file.path,
        contentType: MediaType.parse(mimeType)));
    request.headers.addAll(headers);
    http.Response response =
        await http.Response.fromStream(await request.send());

    final body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return body["data"];
    } else {
      return throw Exception(response.body);
    }
  }

  Future<PostById> getPostDetail(ID) async {
    final prefs = await preference();
    final token = prefs.getString("accessToken");
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request('GET', Uri.parse(BASE_URL + POST_DETAIL + ID));

    request.headers.addAll(headers);

    http.Response response =
        await http.Response.fromStream(await request.send());

    if (response.statusCode == 200) {
      PostById postById = postByIdFromJson(utf8.decode(response.bodyBytes));
      return postById;
    } else {
      return throw Exception(response.body);
    }
  }

  Future<void> updatePost(ID, des, time, amount, categoryId,
      AddressModel address, List images, BuildContext context) async {
    final prefs = await preference();
    final token = prefs.getString("accessToken");
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request('PUT', Uri.parse(BASE_URL + UPDATE_POST + ID));
    request.body = json.encode({
      "description": des,
      "fixedTime": time,
      "amountMoney": amount,
      "categoryId": categoryId,
      "address": {
        "region": address.region,
        "city": address.city,
        "latitude": address.lat,
        "longitude": address.long
      },
      "posterSampleID": images
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
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const EmployerHomePage(
                    index: 2,
                  ),
                ));
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
}
