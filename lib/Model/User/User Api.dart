import 'dart:convert' as convert;

import 'package:amit_project/Model/User/User.dart';
import 'package:amit_project/Model/User/UserLoginErrors.dart';
import 'package:amit_project/Model/User/UserRegisteritonErrors.dart';
import 'package:http/http.dart'as http ;

class UserApi{
  static int statusCode=0;
  UserApi._();
  static final UserApi instance=UserApi._();

   Future<String> register(User user) async {
  var url = Uri.parse('https://retail.amit-learning.com/api/register');
  http.Response response = await http.post(url,body: convert.jsonEncode(user),headers: {"Content-Type":"application/json"});
  statusCode=response.statusCode;
  if(response.statusCode==201)
  {
   return convert.jsonDecode(response.body)["token"];
  }
  else
    {
      UserRegistrationErrors errorRegister =UserRegistrationErrors.fromJson(convert.jsonDecode(response.body));
      return errorRegister.message;

    }
}

   Future<String>login(User user)async {
  var url = Uri.parse('https://retail.amit-learning.com/api/login');
  http.Response response = await http.post(url,body: convert.jsonEncode(user),headers: {"Content-Type":"application/json"});
  statusCode=response.statusCode;
  if(response.statusCode==200)
  {
    return convert.jsonDecode(response.body)["token"];
  }
  else {
    UserLoginErrors loginError=UserLoginErrors.fromJson(convert.jsonDecode(response.body));
    return loginError.error;
  }




}




}