import 'package:amit_project/Global/Progress%20indecator.dart';
import 'package:amit_project/Model/Cart/CartApi.dart';
import 'package:amit_project/Model/Cart/MyCart.dart';
import 'package:amit_project/Model/Products/Products.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
class MyCart extends StatefulWidget {
  final String token;
  const MyCart({Key key, this.token}) : super(key: key);
  @override
  _MyCartState createState() => _MyCartState();
}


class _MyCartState extends State<MyCart> {
  Future<CartElement> _productElement;
  double finalPrice=0.0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _productElement = CartApi.instance.getCart(token:widget.token);
  }
  @override
  void setState(fn) {
    // TODO: implement setState
    super.setState(fn);
    _productElement = CartApi.instance.getCart(token:widget.token);
  }

  @override
  Widget build(BuildContext context) {
    finalPrice=0.0;
    return WillPopScope(
      onWillPop: () => null,
      child: SafeArea(
          child: Scaffold(
              appBar: buildAppBar(),
              body: FutureBuilder(
                    future: _productElement,
                    builder: (context, AsyncSnapshot<CartElement> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting)
                        return Center(child: CircularProgressIndicator());
                      else if (snapshot.data.products.isEmpty)
                        return Center(child: Text('no item Added',style: GoogleFonts.mavenPro(fontSize: 25)));
                      else {
                        snapshot.data.products.forEach((element) {
                          finalPrice+=element.total;
                          print(finalPrice);
                        });
                        return Column(
                          children: [
                          Expanded(
                            child: ListView.builder(
                              itemCount: snapshot.data.products.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  child: ListTile(
                                    //name
                                    title: Text(
                                        snapshot.data.products[index].product.name,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.quicksand(
                                            fontWeight: FontWeight.w700)),
                                    //avatar
                                    leading: CircleAvatar(
                                      backgroundColor: Color(0),
                                      radius: 29,
                                      child: CachedNetworkImage(
                                        imageUrl: snapshot
                                            .data.products[index].product.avatar,
                                        placeholder: (context, url) =>
                                            CircularProgressIndicator(),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    //price
                                    subtitle: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "final price: ${snapshot.data
                                              .products[index].product
                                              .priceFinalText}",
                                            style: GoogleFonts.quicksand(color: Colors.black87)
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 125),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: ElevatedButton(
                                                    onPressed: () {
                                                      minusButton(
                                                          product: snapshot.data
                                                              .products[index]
                                                              .product);
                                                    },
                                                    style: ButtonStyle(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        shape: MaterialStateProperty
                                                            .all(
                                                            RoundedRectangleBorder(
                                                                borderRadius: BorderRadius
                                                                    .only(
                                                                    topLeft:
                                                                    Radius.circular(
                                                                        5),
                                                                    bottomLeft: Radius
                                                                        .circular(
                                                                        5)))),
                                                        backgroundColor:
                                                        MaterialStateProperty.all(
                                                            Color(0xFA192a56)),
                                                        minimumSize: MaterialStateProperty
                                                            .all(
                                                            Size(5, 30)),
                                                        padding: MaterialStateProperty
                                                            .all(
                                                            EdgeInsets.only(
                                                                left: 12,
                                                                right: 10,
                                                                top: 5,
                                                                bottom: 5))),
                                                    child: Icon(
                                                      CommunityMaterialIcons.minus,
                                                      size: 15,
                                                    )),
                                              ),
                                              Expanded(
                                                  flex: 1,
                                                  child: Container(
                                                      width: 5,
                                                      height: 30,
                                                      alignment: Alignment.center,
                                                      color: Colors.grey,
                                                      child: Text(snapshot.data
                                                          .products[index].amount
                                                          .toString()))),
                                              Expanded(
                                                flex: 1,
                                                child: ElevatedButton(
                                                    onPressed: () {
                                                      addButton(
                                                          product: snapshot.data
                                                              .products[index]
                                                              .product);
                                                    },
                                                    style: ButtonStyle(
                                                        backgroundColor: MaterialStateProperty
                                                            .all(
                                                            Color(0xFA192a56)),
                                                        shape: MaterialStateProperty
                                                            .all(
                                                            RoundedRectangleBorder(
                                                                borderRadius: BorderRadius
                                                                    .only(
                                                                    topRight:
                                                                    Radius.circular(
                                                                        5),
                                                                    bottomRight: Radius
                                                                        .circular(
                                                                        5)))),
                                                        minimumSize:
                                                        MaterialStateProperty.all(
                                                            Size(5, 30)),
                                                        padding: MaterialStateProperty
                                                            .all(
                                                            EdgeInsets.only(
                                                                left: 5,
                                                                right: 5,
                                                                top: 5,
                                                                bottom: 5))),
                                                    child: Icon(
                                                      CommunityMaterialIcons.plus,
                                                      size: 15,
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                            Column(children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text("total price:",style: GoogleFonts.mavenPro(),),
                                    Text("$finalPrice EGP",style: GoogleFonts.mavenPro(color: Colors.blue),),
                                  ],
                                ),
                              ),
                              ElevatedButton(
                                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue)),
                                onPressed: confirmButton,
                                child: Text("Confirm",style: GoogleFonts.mavenPro(),),),
                            ],)

                        ]);
                      }},
                  ),
              )),
    );
  }



  Widget buildAppBar(){
    return  AppBar(
      title: Text("My Cart", style: GoogleFonts.quicksand()),
      automaticallyImplyLeading: false,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(7),
              bottomLeft: Radius.circular(7))),
      elevation: 5,
      centerTitle: true,
      backgroundColor: Color(0xFF192a56),
    );
  }

  addButton({Product product}) async {
    await Dialogs.showProgressDialog(context: context,msg: "adding...");
    SharedPreferences token = await SharedPreferences.getInstance();
    int amount = 1;
    CartElement cartElement = await CartApi.instance.getCart(token: token.getString("token"));
    var prod = cartElement.products.firstWhere((element) => element.product.id == product.id, orElse: () => null);
    if (prod != null){
      amount = prod.amount + 1;
    }
    await CartApi.instance.addToCart(
        productId: product.id.toString(),
        amount: amount,
        token: token.getString("token"));
    print(finalPrice);
    setState(() {});
    await Dialogs.hideProgressDialog();
    if(product.inStock==prod.amount){
      Fluttertoast.showToast(
          msg: "No more item in stock",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black54,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    else{
      Fluttertoast.showToast(
          msg: "Added successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black87,
          textColor: Colors.white,
          fontSize: 16.0);
    }

       }

  minusButton({Product product}) async {
    await Dialogs.showProgressDialog(context: context,msg: "Removing...");
    SharedPreferences token = await SharedPreferences.getInstance();
    int amount = 1;
    CartElement cartElement =
        await CartApi.instance.getCart(token: token.getString("token"));
    var prod = cartElement.products.firstWhere(
        (element) => element.product.id == product.id,
        orElse: () => null);
    if (prod != null && prod.amount != 0) amount = prod.amount - 1;

    await CartApi.instance.addToCart(
        productId: product.id.toString(),
        amount: amount,
        token: token.getString("token"));
    setState(() {
      CartApi.instance.getCart(token: token.getString("token"));


    });
    finalPrice-=prod.total;
    Fluttertoast.showToast(
        msg: "Removed successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black87,
        textColor: Colors.white,
        fontSize: 16.0);
    await Dialogs.hideProgressDialog();
  }

  confirmButton()async{
    await Dialogs.showProgressDialog(msg: "confirming...",context: context);
    var list=await CartApi.instance.getCart(token: widget.token);
    for(var element in list.products){
      await CartApi.instance.addToCart(productId: element.product.id.toString(),amount: 0,token: widget.token);
    }
    await Dialogs.hideProgressDialog();
    setState(() {
      finalPrice=0;
    });




}

}
