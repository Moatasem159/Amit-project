// To parse this JSON data, do
//
//     final userLoginErrors = userLoginErrorsFromJson(jsonString);

import 'dart:convert';

UserLoginErrors userLoginErrorsFromJson(String str) => UserLoginErrors.fromJson(json.decode(str));

String userLoginErrorsToJson(UserLoginErrors data) => json.encode(data.toJson());

class UserLoginErrors {
  UserLoginErrors({
    this.error,
  });

  String error;

  factory UserLoginErrors.fromJson(Map<String, dynamic> json) => UserLoginErrors(
    error: json["error"],
  );

  Map<String, dynamic> toJson() => {
    "error": error,
  };
}
