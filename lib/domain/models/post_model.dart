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
  AmountMoney amountMoney;
  Address addressDto;
  DateTime createdDate;
  DateTime updateDate;
  CategoryDto categoryDto;
  RegisterResponse registerResponse;
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
    required this.registerResponse,
    required this.responseFiles,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        description: json["description"],
        fixedTime: DateTime.parse(json["fixedTime"]),
        amountMoney: AmountMoney.fromJson(json["amountMoney"]),
        addressDto: Address.fromJson(json["addressDTO"]),
        createdDate: DateTime.parse(json["createdDate"]),
        updateDate: DateTime.parse(json["updateDate"]),
        categoryDto: CategoryDto.fromJson(json["categoryDTO"]),
        registerResponse: RegisterResponse.fromJson(json["registerResponse"]),
        responseFiles: List<ResponseFile>.from(
            json["responseFiles"].map((x) => ResponseFile.fromJson(x))),
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
        "responseFiles":
            List<dynamic>.from(responseFiles.map((x) => x.toJson())),
      };
}

class Address {
  int id;
  String region;
  String city;
  double latitude;
  double longitude;

  Address({
    required this.id,
    required this.region,
    required this.city,
    required this.latitude,
    required this.longitude,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
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

class AmountMoney {
  int id;
  String nameCode;
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

class RegisterResponse {
  int id;
  String firstName;
  String lastName;
  String email;
  String phone;
  String active;
  List<String> roles;
  String gender;
  DateTime bornYear;
  String description;
  Address address;
  dynamic responseFile;

  RegisterResponse({
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

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      RegisterResponse(
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
        address: Address.fromJson(json["address"]),
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
