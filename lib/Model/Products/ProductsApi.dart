import 'dart:convert'as convert;
import 'package:amit_project/Model/Products/Products.dart';
import 'package:http/http.dart' as http;

Future<List<Product>> getProducts() async {
  var url = Uri.parse('https://retail.amit-learning.com/api/products');
  http.Response response = await http.get(url,headers: {"Content-Type":"application/json"});
  if(response.statusCode==200)
  {
    Products products= Products.fromJson(convert.jsonDecode(response.body));
    List<Product> product=products.products;
    return product;
  }
  else print('Failed with code ${response.statusCode} ');
  return null;
}