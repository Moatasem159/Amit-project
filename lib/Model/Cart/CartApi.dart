import 'dart:convert' as convert;



import 'package:amit_project/Model/Cart/MyCart.dart';


import 'package:http/http.dart' as http;

class CartApi{
  static int statusCode=0;
  CartApi._();
  static final CartApi instance=CartApi._();

  Future<String>addToCart({String productId, String token, int amount}) async {
    var url = Uri.parse(
        'https://retail.amit-learning.com/api/user/products/$productId');
    http.Response response = await http.put(url,
        headers: {"Authorization": "Bearer $token"},
          body:{"amount":"$amount"});
    statusCode=response.statusCode;
     return response.body;
  }


  Future<CartElement> getCart({String token}) async {
    var url = Uri.parse('https://retail.amit-learning.com/api/user/products');
    http.Response response = await http.get(url,headers: {"Content-Type": "application/json","Authorization": "Bearer $token"});
    if(response.statusCode==200)
    {
      CartElement element= CartElement.fromJson(convert.jsonDecode(response.body));
     return element;
    }
    else print('Failed with code ${response.statusCode} ');
    return null;





  }

}





