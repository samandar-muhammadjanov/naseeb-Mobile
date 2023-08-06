// ignore_for_file: must_be_immutable

import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
part 'post_for_employee.g.dart';

PostsForEmplyeeModel getPostsForEmplyeeFromJson(String str) =>
    PostsForEmplyeeModel.fromJson(json.decode(str));

String getPostsForEmplyeeToJson(PostsForEmplyeeModel data) =>
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
  double amountMoney;
  @HiveField(4)
  AddressDto addressDto;
  @HiveField(5)
  DateTime createdDate;
  @HiveField(6)
  DateTime updateDate;
  @HiveField(7)
  CategoryDto categoryDto;
  @HiveField(8)
  List<ResponseFile> responseFiles;

  Datum({
    required this.id,
    required this.description,
    required this.fixedTime,
    required this.amountMoney,
    required this.addressDto,
    required this.createdDate,
    required this.updateDate,
    required this.categoryDto,
    required this.responseFiles,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        description: json["description"],
        fixedTime: DateTime.parse(json["fixedTime"]),
        amountMoney: json["amountMoney"]?.toDouble(),
        addressDto: AddressDto.fromJson(json["addressDTO"]),
        createdDate: DateTime.parse(json["createdDate"]),
        updateDate: DateTime.parse(json["updateDate"]),
        categoryDto: CategoryDto.fromJson(json["categoryDTO"]),
        responseFiles: List<ResponseFile>.from(
            json["responseFiles"].map((x) => ResponseFile.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "fixedTime":
            "${fixedTime.year.toString().padLeft(4, '0')}-${fixedTime.month.toString().padLeft(2, '0')}-${fixedTime.day.toString().padLeft(2, '0')}",
        "amountMoney": amountMoney,
        "addressDTO": addressDto.toJson(),
        "createdDate":
            "${createdDate.year.toString().padLeft(4, '0')}-${createdDate.month.toString().padLeft(2, '0')}-${createdDate.day.toString().padLeft(2, '0')}",
        "updateDate":
            "${updateDate.year.toString().padLeft(4, '0')}-${updateDate.month.toString().padLeft(2, '0')}-${updateDate.day.toString().padLeft(2, '0')}",
        "categoryDTO": categoryDto.toJson(),
        "responseFiles":
            List<dynamic>.from(responseFiles.map((x) => x.toJson())),
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

@HiveType(typeId: 3)
class ResponseFile extends Equatable {
  @HiveField(0)
  String name;
  @HiveField(1)
  String url;
  @HiveField(2)
  String type;
  @HiveField(3)
  int size;

  ResponseFile({
    required this.name,
    required this.url,
    required this.type,
    required this.size,
  });

  factory ResponseFile.fromJson(Map<String, dynamic> json) => ResponseFile(
        name: json["name"],
        url: json["url"],
        type: json["type"],
        size: json["size"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
        "type": type,
        "size": size,
      };

  @override
  List<Object?> get props => [name, url, type, size];
}
