import 'dart:convert'as convert;

import 'package:amit_project/Model/Category/Category.dart';
import 'package:http/http.dart' as http;

Future<List<CategoryElement>> getCategories() async {
    var url = Uri.parse('https://retail.amit-learning.com/api/categories');
    http.Response response = await http.get(url,headers: {"Content-Type":"application/json"});
    if(response.statusCode==200)
    {
      Category category= Category.fromJson(convert.jsonDecode(response.body));
      List<CategoryElement> categoryElement=category.categories;
      return categoryElement;
    }
    else print('Failed with code ${response.statusCode} ');
    return null;
  }