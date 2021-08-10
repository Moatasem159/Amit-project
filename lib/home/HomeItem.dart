import 'package:amit_project/Global/Progress%20indecator.dart';
import 'package:amit_project/Model/Cart/CartApi.dart';
import 'package:amit_project/Model/Cart/MyCart.dart';

import 'package:amit_project/Model/Products/ProductPage.dart';
import 'package:amit_project/Model/Products/Products.dart';
import 'package:amit_project/Model/Products/ProductsApi.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeItem extends StatefulWidget {
  @override
  _HomeItemState createState() => _HomeItemState();
}

class _HomeItemState extends State<HomeItem> {
  Future<List<Product>> _productInfo;
  Future<SharedPreferences>_token;
  @override
  void initState() {
    super.initState();
    _productInfo = getProducts();
    _token=SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => null,
      child: FutureBuilder(
          future: _token,
        builder:(context, AsyncSnapshot<SharedPreferences> snapshotToken) {
            if(snapshotToken.connectionState==ConnectionState.waiting) return Container();
            else return  FutureBuilder(
          future: _productInfo,
          builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return Center(child: CircularProgressIndicator());
            else if (snapshot.connectionState == ConnectionState.done &&
                snapshot.data == null ||
                snapshot.hasError) {
              return Text("error");
            } else
              return GridView.builder(
                itemCount: snapshot.data.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisExtent: 240, crossAxisCount: 2),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () => productPageRoute(
                        index: index, context: context, snapshot: snapshot),
                    child: Card(
                      elevation: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        margin: EdgeInsets.all(8),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(
                                          snapshot.data[index].avatar)),
                                  color: Colors.black,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10))),
                              height: 120,
                              width: double.infinity,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Text(
                                snapshot.data[index].name,
                                style: GoogleFonts.quicksand(
                                    fontWeight: FontWeight.w500),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child: Text(
                                  snapshot.data[index].description == null
                                      ? ""
                                      : snapshot.data[index].description,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.quicksand(
                                      fontWeight: FontWeight.w100)),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 2),
                                  child: ElevatedButton(
                                      style: ButtonStyle(
                                          padding: MaterialStateProperty.all(
                                              EdgeInsets.all(4)),
                                          minimumSize:
                                          MaterialStateProperty.all(Size(10, 10)),
                                          shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(7),
                                              )),
                                          backgroundColor: MaterialStateProperty.all(
                                              Color(0xFF192a56)),
                                          elevation: MaterialStateProperty.all(2)),
                                      child: Icon(Icons.add),
                                      onPressed: ()=>putInCart(product: snapshot.data[index],token: snapshotToken.data.getString("token"))

                                  ),
                                ),
                                Container(
                                    padding: EdgeInsets.only(right: 5),
                                    alignment: Alignment.centerRight,
                                    height: 25,
                                    width: 105,
                                    child: Text(
                                      "${snapshot.data[index].price.toString()},${snapshot.data[index].currency}",
                                      style: GoogleFonts.quicksand(
                                          color: Color(0xFF192a56), fontSize: 10),
                                    ))
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
          },
        );
      },

      ),
    );
  }

  productPageRoute({int index,BuildContext context, AsyncSnapshot<List<Product>> snapshot})  {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ProductPage(
        avatar: snapshot.data[index].avatar,
        title: snapshot.data[index].title,
        name: snapshot.data[index].name,
        discount: snapshot.data[index].discount,
        price: snapshot.data[index].price,
        priceFinal: snapshot.data[index].priceFinal,
        priceFinalText: snapshot.data[index].priceFinalText,
        description: snapshot.data[index].description,
        id: snapshot.data[index].id,
        inStock: snapshot.data[index].inStock,
        currency: snapshot.data[index].currency,
      ),
    ));
  }
  putInCart({Product product,String token})async {
    Dialogs.showProgressDialog(context: context,msg: "Adding...");
    int amount=1 ;
    CartElement _cartElement = await CartApi.instance.getCart(token: token);
    var prod=_cartElement.products.firstWhere((element) => element.product.id==product.id,orElse: ()=>null );
    if(prod!=null) amount=prod.amount+1;
    await CartApi.instance.addToCart(
        productId: product.id.toString(),
        token:token,amount: amount);
    if (CartApi.statusCode == 200) {
      Dialogs.hideProgressDialog();
      Fluttertoast.showToast(
          msg: "Item Added",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black87,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    else {
      Dialogs.hideProgressDialog();
      Fluttertoast.showToast(
          msg: "error",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red[500],
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
