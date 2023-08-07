// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
part 'post_for_employee.g.dart';

PostsForEmplyeeModel postsForEmplyeeModelFromJson(String str) =>
    PostsForEmplyeeModel.fromJson(json.decode(str));

String postsForEmplyeeModelToJson(PostsForEmplyeeModel data) =>
    json.encode(data.toJson());

class PostsForEmplyeeModel {
  String message;
  bool success;
  List<Datum> data;

  PostsForEmplyeeModel({
    required this.message,
    required this.success,
    required this.data,
  });

  factory PostsForEmplyeeModel.fromJson(Map<String, dynamic> json) =>
      PostsForEmplyeeModel(
        message: json["message"],
        success: json["success"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

@HiveType(typeId: 0)
class Datum extends Equatable {
  @HiveField(0)
  int id;
  @HiveField(1)
  String description;
  @HiveField(2)
  DateTime fixedTime;
  @HiveField(3)
  AmountMoney amountMoney;
  @HiveField(4)
  AddressDto addressDto;
  @HiveField(5)
  DateTime createdDate;
  @HiveField(6)
  DateTime updateDate;
  @HiveField(7)
  CategoryDto categoryDto;
  @HiveField(8)
  RegisterResponsePost registerResponse;
  @HiveField(9)
  List<dynamic> responseFiles;

  Datum({
    required this.id,
    required this.description,
    required this.fixedTime,
    required this.amountMoney,
    required this.addressDto,
    required this.createdDate,
    required this.updateDate,
    required this.categoryDto,
    required this.registerResponse,
    required this.responseFiles,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        description: json["description"],
        fixedTime: DateTime.parse(json["fixedTime"]),
        amountMoney: AmountMoney.fromJson(json["amountMoney"]),
        addressDto: AddressDto.fromJson(json["addressDTO"]),
        createdDate: DateTime.parse(json["createdDate"]),
        updateDate: DateTime.parse(json["updateDate"]),
        categoryDto: CategoryDto.fromJson(json["categoryDTO"]),
        registerResponse:
            RegisterResponsePost.fromJson(json["registerResponse"]),
        responseFiles: List<dynamic>.from(json["responseFiles"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "fixedTime":
            "${fixedTime.year.toString().padLeft(4, '0')}-${fixedTime.month.toString().padLeft(2, '0')}-${fixedTime.day.toString().padLeft(2, '0')}",
        "amountMoney": amountMoney.toJson(),
        "addressDTO": addressDto.toJson(),
        "createdDate":
            "${createdDate.year.toString().padLeft(4, '0')}-${createdDate.month.toString().padLeft(2, '0')}-${createdDate.day.toString().padLeft(2, '0')}",
        "updateDate":
            "${updateDate.year.toString().padLeft(4, '0')}-${updateDate.month.toString().padLeft(2, '0')}-${updateDate.day.toString().padLeft(2, '0')}",
        "categoryDTO": categoryDto.toJson(),
        "registerResponse": registerResponse.toJson(),
        "responseFiles": List<dynamic>.from(responseFiles.map((x) => x)),
      };

  @override
  List<Object?> get props => [
        id,
        description,
        fixedTime,
        amountMoney,
        addressDto,
        createdDate,
        updateDate,
        categoryDto,
        registerResponse,
        responseFiles
      ];
}

@HiveType(typeId: 1)
class AddressDto extends Equatable {
  @HiveField(0)
  int id;
  @HiveField(1)
  String region;
  @HiveField(2)
  String city;
  @HiveField(3)
  double latitude;
  @HiveField(4)
  double longitude;

  AddressDto({
    required this.id,
    required this.region,
    required this.city,
    required this.latitude,
    required this.longitude,
  });

  factory AddressDto.fromJson(Map<String, dynamic> json) => AddressDto(
        id: json["id"],
        region: json["region"],
        city: json["city"],
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "region": region,
        "city": city,
        "latitude": latitude,
        "longitude": longitude,
      };

  @override
  List<Object?> get props => [id, region, city, latitude, longitude];
}

@HiveType(typeId: 2)
class AmountMoney extends Equatable {
  @HiveField(1)
  int id;
  @HiveField(2)
  String nameCode;
  @HiveField(3)
  double money;

  AmountMoney({
    required this.id,
    required this.nameCode,
    required this.money,
  });

  factory AmountMoney.fromJson(Map<String, dynamic> json) => AmountMoney(
        id: json["id"],
        nameCode: json["nameCode"],
        money: json["money"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nameCode": nameCode,
        "money": money,
      };

  @override
  List<Object?> get props => [id, nameCode, money];
}

@HiveType(typeId: 3)
class CategoryDto extends Equatable {
  @HiveField(0)
  int id;
  @HiveField(1)
  String nameUz;
  @HiveField(2)
  String nameRu;
  @HiveField(3)
  bool active;

  CategoryDto({
    required this.id,
    required this.nameUz,
    required this.nameRu,
    required this.active,
  });

  factory CategoryDto.fromJson(Map<String, dynamic> json) => CategoryDto(
        id: json["id"],
        nameUz: json["nameUz"],
        nameRu: json["nameRu"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nameUz": nameUz,
        "nameRu": nameRu,
        "active": active,
      };

  @override
  List<Object?> get props => [id, nameUz, nameRu, active];
}

@HiveType(typeId: 10)
class RegisterResponsePost extends Equatable {
  @HiveField(0)
  int id;
  @HiveField(1)
  String firstName;
  @HiveField(2)
  String lastName;
  @HiveField(3)
  String email;
  @HiveField(4)
  String phone;
  @HiveField(5)
  String active;
  @HiveField(6)
  List<String> roles;
  @HiveField(7)
  String gender;
  @HiveField(8)
  DateTime bornYear;
  @HiveField(9)
  String description;
  @HiveField(10)
  AddressDto address;
  @HiveField(11)
  dynamic responseFile;

  RegisterResponsePost({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.active,
    required this.roles,
    required this.gender,
    required this.bornYear,
    required this.description,
    required this.address,
    required this.responseFile,
  });

  factory RegisterResponsePost.fromJson(Map<String, dynamic> json) =>
      RegisterResponsePost(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        phone: json["phone"],
        active: json["active"],
        roles: List<String>.from(json["roles"].map((x) => x)),
        gender: json["gender"],
        bornYear: DateTime.parse(json["bornYear"]),
        description: json["description"],
        address: AddressDto.fromJson(json["address"]),
        responseFile: json["responseFile"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "phone": phone,
        "active": active,
        "roles": List<dynamic>.from(roles.map((x) => x)),
        "gender": gender,
        "bornYear":
            "${bornYear.year.toString().padLeft(4, '0')}-${bornYear.month.toString().padLeft(2, '0')}-${bornYear.day.toString().padLeft(2, '0')}",
        "description": description,
        "address": address.toJson(),
        "responseFile": responseFile,
      };

  @override
  List<Object?> get props => [
        id,
        firstName,
        lastName,
        email,
        phone,
        active,
        roles,
        gender,
        bornYear,
        description,
        address,
        responseFile
      ];
}
