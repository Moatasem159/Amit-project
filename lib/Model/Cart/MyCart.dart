// To parse this JSON data, do
//
//     final cartElement = cartElementFromJson(jsonString);

import 'dart:convert';

import 'package:amit_project/Model/Products/Products.dart';


CartElement cartElementFromJson(String str) => CartElement.fromJson(json.decode(str));

String cartElementToJson(CartElement data) => json.encode(data.toJson());

class CartElement {
  CartElement({
    this.products,
  });

  List<ProductElement> products;

  factory CartElement.fromJson(Map<String, dynamic> json) => CartElement(
    products: List<ProductElement>.from(json["products"].map((x) => ProductElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "products": List<dynamic>.from(products.map((x) => x.toJson())),
  };
}

class ProductElement {
  ProductElement({
    this.amount,
    this.total,
    this.totalText,
    this.product,
  });

  int amount;
  int total;
  String totalText;
  Product product;

  factory ProductElement.fromJson(Map<String, dynamic> json) => ProductElement(
    amount: json["amount"],
    total: json["total"],
    totalText: json["total_text"],
    product: Product.fromJson(json["product"]),
  );

  Map<String, dynamic> toJson() => {
    "amount": amount,
    "total": total,
    "total_text": totalText,
    "product": product.toJson(),
  };
}


