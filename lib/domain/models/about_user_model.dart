// To parse this JSON data, do
//
//     final aboutUser = aboutUserFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

AboutUser aboutUserFromJson(String str) => AboutUser.fromJson(json.decode(str));

String aboutUserToJson(AboutUser data) => json.encode(data.toJson());

class AboutUser {
    String message;
    bool success;
    Data data;

    AboutUser({
        required this.message,
        required this.success,
        required this.data,
    });

    AboutUser copyWith({
        String? message,
        bool? success,
        Data? data,
    }) => 
        AboutUser(
            message: message ?? this.message,
            success: success ?? this.success,
            data: data ?? this.data,
        );

    factory AboutUser.fromJson(Map<String, dynamic> json) => AboutUser(
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

    Data({
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

    Data copyWith({
        int? id,
        String? firstName,
        String? lastName,
        String? email,
        String? phone,
        String? active,
        List<String>? roles,
        String? gender,
        String? language,
        DateTime? bornYear,
        String? description,
        Address? address,
        dynamic responseFile,
    }) => 
        Data(
            id: id ?? this.id,
            firstName: firstName ?? this.firstName,
            lastName: lastName ?? this.lastName,
            email: email ?? this.email,
            phone: phone ?? this.phone,
            active: active ?? this.active,
            roles: roles ?? this.roles,
            gender: gender ?? this.gender,
            language: language ?? this.language,
            bornYear: bornYear ?? this.bornYear,
            description: description ?? this.description,
            address: address ?? this.address,
            responseFile: responseFile ?? this.responseFile,
        );

    factory Data.fromJson(Map<String, dynamic> json) => Data(
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
        "bornYear": "${bornYear.year.toString().padLeft(4, '0')}-${bornYear.month.toString().padLeft(2, '0')}-${bornYear.day.toString().padLeft(2, '0')}",
        "description": description,
        "address": address.toJson(),
        "responseFile": responseFile,
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

    Address copyWith({
        int? id,
        String? region,
        String? city,
        double? latitude,
        double? longitude,
    }) => 
        Address(
            id: id ?? this.id,
            region: region ?? this.region,
            city: city ?? this.city,
            latitude: latitude ?? this.latitude,
            longitude: longitude ?? this.longitude,
        );

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
