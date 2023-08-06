// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:equatable/equatable.dart';
part 'get_employee_model.g.dart';
GetEmployee getEmployeeFromJson(String str) =>
    GetEmployee.fromJson(json.decode(str));

String getEmployeeToJson(GetEmployee data) => json.encode(data.toJson());

class GetEmployee {
  String message;
  bool success;
  List<EmployeeDatum> data;

  GetEmployee({
    required this.message,
    required this.success,
    required this.data,
  });

  factory GetEmployee.fromJson(Map<String, dynamic> json) => GetEmployee(
        message: json["message"],
        success: json["success"],
        data: List<EmployeeDatum>.from(json["data"].map((x) => EmployeeDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

@HiveType(typeId: 4)
class EmployeeDatum extends Equatable {
  @HiveField(0)
  int id;
  @HiveField(1)
  String description;
  @HiveField(2)
  String workType;
  @HiveField(3)
  List<dynamic> languagesResponse;
  @HiveField(4)
  List<ExperienceResponse> experienceResponses;
  @HiveField(5)
  List<dynamic> educationResponse;
  @HiveField(6)
  CategoryResponse categoryResponse;
  @HiveField(7)
  SalaryResponse salaryResponse;
  @HiveField(8)
  List<dynamic> certificateFile;
  @HiveField(9)
  List<dynamic> sampleFile;
  @HiveField(10)
  RegisterResponse registerResponse;

  EmployeeDatum({
    required this.id,
    required this.description,
    required this.workType,
    required this.languagesResponse,
    required this.experienceResponses,
    required this.educationResponse,
    required this.categoryResponse,
    required this.salaryResponse,
    required this.certificateFile,
    required this.sampleFile,
    required this.registerResponse,
  });

  factory EmployeeDatum.fromJson(Map<String, dynamic> json) => EmployeeDatum(
        id: json["id"],
        description: json["description"],
        workType: json["workType"],
        languagesResponse:
            List<dynamic>.from(json["languagesResponse"].map((x) => x)),
        experienceResponses: List<ExperienceResponse>.from(
            json["experienceResponses"]
                .map((x) => ExperienceResponse.fromJson(x))),
        educationResponse:
            List<dynamic>.from(json["educationResponse"].map((x) => x)),
        categoryResponse: CategoryResponse.fromJson(json["categoryResponse"]),
        salaryResponse: SalaryResponse.fromJson(json["salaryResponse"]),
        certificateFile:
            List<dynamic>.from(json["certificateFile"].map((x) => x)),
        sampleFile: List<dynamic>.from(json["sampleFile"].map((x) => x)),
        registerResponse: RegisterResponse.fromJson(json["registerResponse"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "workType": workType,
        "languagesResponse":
            List<dynamic>.from(languagesResponse.map((x) => x)),
        "experienceResponses":
            List<dynamic>.from(experienceResponses.map((x) => x.toJson())),
        "educationResponse":
            List<dynamic>.from(educationResponse.map((x) => x)),
        "categoryResponse": categoryResponse.toJson(),
        "salaryResponse": salaryResponse.toJson(),
        "certificateFile": List<dynamic>.from(certificateFile.map((x) => x)),
        "sampleFile": List<dynamic>.from(sampleFile.map((x) => x)),
        "registerResponse": registerResponse.toJson(),
      };

  @override
  List<Object?> get props => [
        id,
        description,
        workType,
        languagesResponse,
        experienceResponses,
        categoryResponse,
        salaryResponse,
        certificateFile,
        sampleFile,
        registerResponse
      ];
}

@HiveType(typeId: 5)
class CategoryResponse extends Equatable {
  @HiveField(0)
  int id;
  @HiveField(1)
  String nameUz;
  @HiveField(2)
  String nameRu;
  @HiveField(3)
  bool active;

  CategoryResponse({
    required this.id,
    required this.nameUz,
    required this.nameRu,
    required this.active,
  });

  factory CategoryResponse.fromJson(Map<String, dynamic> json) =>
      CategoryResponse(
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

@HiveType(typeId: 6)
class ExperienceResponse extends Equatable {
  @HiveField(0)
  int id;
  @HiveField(1)
  String level;
  @HiveField(2)
  DateTime begin;
  @HiveField(3)
  DateTime end;
  @HiveField(4)
  String asWho;
  @HiveField(5)
  String company;
  @HiveField(6)
  String description;

  ExperienceResponse({
    required this.id,
    required this.level,
    required this.begin,
    required this.end,
    required this.asWho,
    required this.company,
    required this.description,
  });

  factory ExperienceResponse.fromJson(Map<String, dynamic> json) =>
      ExperienceResponse(
        id: json["id"],
        level: json["level"],
        begin: DateTime.parse(json["begin"]),
        end: DateTime.parse(json["end"]),
        asWho: json["asWho"],
        company: json["company"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "level": level,
        "begin":
            "${begin.year.toString().padLeft(4, '0')}-${begin.month.toString().padLeft(2, '0')}-${begin.day.toString().padLeft(2, '0')}",
        "end":
            "${end.year.toString().padLeft(4, '0')}-${end.month.toString().padLeft(2, '0')}-${end.day.toString().padLeft(2, '0')}",
        "asWho": asWho,
        "company": company,
        "description": description,
      };

  @override
  List<Object?> get props =>
      [id, level, begin, end, asWho, company, description];
}

@HiveType(typeId: 7)
class RegisterResponse extends Equatable {
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
  dynamic language;
  @HiveField(9)
  DateTime bornYear;
  @HiveField(10)
  String description;
  @HiveField(12)
  Address address;
  @HiveField(13)
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
    required this.language,
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
        language: json["language"],
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
        "language": language,
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
        language,
        bornYear,
        description,
        address,
        responseFile
      ];
}

@HiveType(typeId: 8)
class Address extends Equatable {
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

  @override
  List<Object?> get props => [id, region, city, latitude, longitude];
}

@HiveType(typeId: 9)
class SalaryResponse extends Equatable {
  @HiveField(0)
  int id;
  @HiveField(1)
  String nameCode;
  @HiveField(2)
  double money;

  SalaryResponse({
    required this.id,
    required this.nameCode,
    required this.money,
  });

  factory SalaryResponse.fromJson(Map<String, dynamic> json) => SalaryResponse(
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
