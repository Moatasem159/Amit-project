// To parse this JSON data, do
//
//     final userRegisteritonErrors = userRegisteritonErrorsFromJson(jsonString);

import 'dart:convert';

UserRegistrationErrors userRegistrationErrorsFromJson(String str) => UserRegistrationErrors.fromJson(json.decode(str));

String userRegistrationErrorsToJson(UserRegistrationErrors data) => json.encode(data.toJson());

class UserRegistrationErrors {
  UserRegistrationErrors({
    this.message,
    this.errors,
  });

  String message;
  Errors errors;

  factory UserRegistrationErrors.fromJson(Map<String, dynamic> json) => UserRegistrationErrors(
    message:json["message"]==null?"": json["message"],
    errors: json["errors"]==null? Errors():Errors.fromJson(json["errors"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "errors": errors.toJson(),
  };
}

class Errors {
  Errors({
    this.email,
    this.password,
  });

  List<String> email;
  List<String> password;

  factory Errors.fromJson(Map<String, dynamic> json) => Errors(
    email:  json["email"]==null?<String>[]:List<String>.from(json["email"].map((x) => x)),
    password: json["password"]==null?<String>[]:  List<String>.from(json["password"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "email": List<dynamic>.from(email.map((x) => x)),
    "password": List<dynamic>.from(password.map((x) => x)),
  };
}
