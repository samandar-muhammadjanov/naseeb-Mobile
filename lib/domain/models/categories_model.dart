import 'dart:convert';

Categories categoriesFromJson(String str) =>
    Categories.fromJson(json.decode(str));

String categoriesToJson(Categories data) => json.encode(data.toJson());

class Categories {
  String message;
  bool success;
  List<Datum> data;

  Categories({
    required this.message,
    required this.success,
    required this.data,
  });

  Categories copyWith({
    String? message,
    bool? success,
    List<Datum>? data,
  }) =>
      Categories(
        message: message ?? this.message,
        success: success ?? this.success,
        data: data ?? this.data,
      );

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
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

class Datum {
  int id;
  String nameUz;
  String nameRu;
  bool active;

  Datum({
    required this.id,
    required this.nameUz,
    required this.nameRu,
    required this.active,
  });

  Datum copyWith({
    int? id,
    String? nameUz,
    String? nameRu,
    bool? active,
  }) =>
      Datum(
        id: id ?? this.id,
        nameUz: nameUz ?? this.nameUz,
        nameRu: nameRu ?? this.nameRu,
        active: active ?? this.active,
      );

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
}
