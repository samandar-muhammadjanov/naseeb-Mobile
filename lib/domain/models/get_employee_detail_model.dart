import 'dart:convert';

GetEmployeeDetail getEmployeeDetailFromJson(String str) =>
    GetEmployeeDetail.fromJson(json.decode(str));

String getEmployeeDetailToJson(GetEmployeeDetail data) =>
    json.encode(data.toJson());

class GetEmployeeDetail {
  String message;
  bool success;
  Data data;

  GetEmployeeDetail({
    required this.message,
    required this.success,
    required this.data,
  });

  factory GetEmployeeDetail.fromJson(Map<String, dynamic> json) =>
      GetEmployeeDetail(
        message: json["message"],
        success: json["success"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "success": success,
        "data": data.toJson(),
      };
}

class Data {
  int id;
  String description;
  String workType;
  List<LanguagesResponse> languagesResponse;
  List<ExperienceResponse> experienceResponses;
  List<EducationResponse> educationResponse;
  CategoryResponse categoryResponse;
  SalaryResponse salaryResponse;
  List<EFile> certificateFile;
  List<EFile> sampleFile;
  RegisterResponse registerResponse;

  Data({
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

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        description: json["description"],
        workType: json["workType"],
        languagesResponse: List<LanguagesResponse>.from(
            json["languagesResponse"]
                .map((x) => LanguagesResponse.fromJson(x))),
        experienceResponses: List<ExperienceResponse>.from(
            json["experienceResponses"]
                .map((x) => ExperienceResponse.fromJson(x))),
        educationResponse: List<EducationResponse>.from(
            json["educationResponse"]
                .map((x) => EducationResponse.fromJson(x))),
        categoryResponse: CategoryResponse.fromJson(json["categoryResponse"]),
        salaryResponse: SalaryResponse.fromJson(json["salaryResponse"]),
        certificateFile: List<EFile>.from(
            json["certificateFile"].map((x) => EFile.fromJson(x))),
        sampleFile:
            List<EFile>.from(json["sampleFile"].map((x) => EFile.fromJson(x))),
        registerResponse: RegisterResponse.fromJson(json["registerResponse"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "workType": workType,
        "languagesResponse":
            List<dynamic>.from(languagesResponse.map((x) => x.toJson())),
        "experienceResponses":
            List<dynamic>.from(experienceResponses.map((x) => x.toJson())),
        "educationResponse":
            List<dynamic>.from(educationResponse.map((x) => x.toJson())),
        "categoryResponse": categoryResponse.toJson(),
        "salaryResponse": salaryResponse.toJson(),
        "certificateFile":
            List<dynamic>.from(certificateFile.map((x) => x.toJson())),
        "sampleFile": List<dynamic>.from(sampleFile.map((x) => x.toJson())),
        "registerResponse": registerResponse.toJson(),
      };
}

class CategoryResponse {
  int id;
  String nameUz;
  String nameRu;
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
}

class EFile {
  String name;
  String url;
  String type;
  DateTime date;
  int size;

  EFile({
    required this.name,
    required this.url,
    required this.type,
    required this.date,
    required this.size,
  });

  factory EFile.fromJson(Map<String, dynamic> json) => EFile(
        name: json["name"],
        url: json["url"],
        type: json["type"],
        date: DateTime.parse(json["date"] ?? "2023-01-20"),
        size: json["size"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
        "type": type,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "size": size,
      };
}

class EducationResponse {
  int id;
  String institution;
  String level;
  String description;

  EducationResponse({
    required this.id,
    required this.institution,
    required this.level,
    required this.description,
  });

  factory EducationResponse.fromJson(Map<String, dynamic> json) =>
      EducationResponse(
        id: json["id"],
        institution: json["institution"],
        level: json["level"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "institution": institution,
        "level": level,
        "description": description,
      };
}

class ExperienceResponse {
  int id;
  String level;
  DateTime begin;
  DateTime end;
  String asWho;
  String company;
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
}

class LanguagesResponse {
  int id;
  String level;
  String name;
  String description;
  String certificateName;

  LanguagesResponse({
    required this.id,
    required this.level,
    required this.name,
    required this.description,
    required this.certificateName,
  });

  factory LanguagesResponse.fromJson(Map<String, dynamic> json) =>
      LanguagesResponse(
        id: json["id"],
        level: json["level"],
        name: json["name"],
        description: json["description"],
        certificateName: json["certificateName"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "level": level,
        "name": name,
        "description": description,
        "certificateName": certificateName,
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
  String language;
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
        "responseFile": responseFile.toJson(),
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

class SalaryResponse {
  int id;
  String formOfService;
  double money;

  SalaryResponse({
    required this.id,
    required this.formOfService,
    required this.money,
  });

  factory SalaryResponse.fromJson(Map<String, dynamic> json) => SalaryResponse(
        id: json["id"],
        formOfService: json["formOfService"],
        money: json["money"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "formOfService": formOfService,
        "money": money,
      };
}
