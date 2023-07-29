import 'dart:convert';

GetEmployee getEmployeeFromJson(String str) =>
    GetEmployee.fromJson(json.decode(str));

String getEmployeeToJson(GetEmployee data) => json.encode(data.toJson());

class GetEmployee {
  String message;
  bool success;
  dynamic data;

  GetEmployee({
    required this.message,
    required this.success,
    required this.data,
  });

  GetEmployee copyWith({
    String? message,
    bool? success,
    dynamic data,
  }) =>
      GetEmployee(
        message: message ?? this.message,
        success: success ?? this.success,
        data: data ?? this.data,
      );

  factory GetEmployee.fromJson(Map<String, dynamic> json) => GetEmployee(
        message: json["message"],
        success: json["success"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "success": success,
        "data": data,
      };
}
