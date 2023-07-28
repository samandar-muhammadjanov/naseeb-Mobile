import 'dart:convert';

Posts postsFromJson(String str) => Posts.fromJson(json.decode(str));

String postsToJson(Posts data) => json.encode(data.toJson());

class Posts {
  String message;
  bool success;
  List<Datum> data;

  Posts({
    required this.message,
    required this.success,
    required this.data,
  });

  Posts copyWith({
    String? message,
    bool? success,
    List<Datum>? data,
  }) =>
      Posts(
        message: message ?? this.message,
        success: success ?? this.success,
        data: data ?? this.data,
      );

  factory Posts.fromJson(Map<String, dynamic> json) => Posts(
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
  String description;
  DateTime fixedTime;
  double amountMoney;
  AddressDto addressDto;
  DateTime createdDate;
  DateTime updateDate;
  CategoryDto categoryDto;
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

  Datum copyWith({
    int? id,
    String? description,
    DateTime? fixedTime,
    double? amountMoney,
    AddressDto? addressDto,
    DateTime? createdDate,
    DateTime? updateDate,
    CategoryDto? categoryDto,
    List<ResponseFile>? responseFiles,
  }) =>
      Datum(
        id: id ?? this.id,
        description: description ?? this.description,
        fixedTime: fixedTime ?? this.fixedTime,
        amountMoney: amountMoney ?? this.amountMoney,
        addressDto: addressDto ?? this.addressDto,
        createdDate: createdDate ?? this.createdDate,
        updateDate: updateDate ?? this.updateDate,
        categoryDto: categoryDto ?? this.categoryDto,
        responseFiles: responseFiles ?? this.responseFiles,
      );

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
}

class AddressDto {
  int id;
  String region;
  String city;
  double latitude;
  double longitude;

  AddressDto({
    required this.id,
    required this.region,
    required this.city,
    required this.latitude,
    required this.longitude,
  });

  AddressDto copyWith({
    int? id,
    String? region,
    String? city,
    double? latitude,
    double? longitude,
  }) =>
      AddressDto(
        id: id ?? this.id,
        region: region ?? this.region,
        city: city ?? this.city,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
      );

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
}

class CategoryDto {
  int id;
  String nameUz;
  String nameRu;
  bool active;

  CategoryDto({
    required this.id,
    required this.nameUz,
    required this.nameRu,
    required this.active,
  });

  CategoryDto copyWith({
    int? id,
    String? nameUz,
    String? nameRu,
    bool? active,
  }) =>
      CategoryDto(
        id: id ?? this.id,
        nameUz: nameUz ?? this.nameUz,
        nameRu: nameRu ?? this.nameRu,
        active: active ?? this.active,
      );

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
}

class ResponseFile {
  String name;
  String url;
  String type;
  int size;

  ResponseFile({
    required this.name,
    required this.url,
    required this.type,
    required this.size,
  });

  ResponseFile copyWith({
    String? name,
    String? url,
    String? type,
    int? size,
  }) =>
      ResponseFile(
        name: name ?? this.name,
        url: url ?? this.url,
        type: type ?? this.type,
        size: size ?? this.size,
      );

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
}
