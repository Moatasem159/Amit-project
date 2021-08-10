
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductPage extends StatefulWidget {
  final int id, price, discount, inStock;
  final String name, title, description, discountType, avatar, priceFinalText;
  final double priceFinal;
  final String currency;

  const ProductPage(
      {Key key,
      this.id,
      this.price,
      this.discount,
      this.inStock,
      this.name,
      this.title,
      this.description,
      this.discountType,
      this.avatar,
      this.priceFinalText,
      this.priceFinal,
      this.currency})
      : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomRight: Radius.circular(7),bottomLeft:Radius.circular(10) )),
        elevation: 5,
        backgroundColor: Color(0xFF192a56),
        title: Text(
          widget.title,
          style: GoogleFonts.quicksand(),
        ),
      ),
      body:
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // avatar
              Card(
                child: Container(
                  constraints: BoxConstraints(maxHeight: 200, maxWidth: 200),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill, image: NetworkImage(widget.avatar)),
                      color: Colors.black,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10))),
                  height: 200,
                  width: 200,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //ID
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 5, bottom: 4),
                    child: Text(
                      "Category Id : ${widget.id}".toString(),
                      style: GoogleFonts.quicksand(fontWeight: FontWeight.w500),
                    ),
                  ),
                  //IN_stock
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4, left: 10),
                    child: Text(
                      "In_Stock : ${widget.inStock}".toString(),
                      style: GoogleFonts.quicksand(fontWeight: FontWeight.w500),
                    ),
                  ),
                  //price
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4, left: 10),
                    child: Text(
                      "Price : ${widget.price} ${widget.currency}".toString(),
                      style: GoogleFonts.quicksand(fontWeight: FontWeight.w500),
                    ),
                  ),
                  //Discount
                  widget.discount==0? Container():Padding(
                    padding: const EdgeInsets.only(bottom: 4, left: 10),
                    child:Text("Discount: ${widget.discount} ${widget.currency}".toString(),
                      style: GoogleFonts.quicksand(fontWeight: FontWeight.w500),
                    ),
                  ),
                  //final Price text
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4, left: 10),
                    child: Text(
                      "Final Price:${widget.priceFinalText}",
                      style: GoogleFonts.quicksand(fontWeight: FontWeight.w500,),
                    ),
                  ),
                ],
              )
            ],
          ),
          Container(
            alignment: Alignment.topLeft,
            width: double.infinity,
            height: 75,
            child: Padding(
              padding: const EdgeInsets.only(left: 13),
              child: Text(
                "${widget.name} .",
                style: GoogleFonts.quicksand(fontWeight: FontWeight.w500,fontSize: 20),
              ),
            ),
          ),
          //Buy
        ],
      ),
    ));
  }
}
