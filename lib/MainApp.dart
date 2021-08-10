import 'package:amit_project/Categories.dart';
import 'package:amit_project/Model/Cart/My%20CartUi.dart';
import 'package:amit_project/home/Home.dart';
import 'package:amit_project/Menu.dart';
import 'package:community_material_icon/community_material_icon.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class MainApp extends StatefulWidget {
  final String token;

  const MainApp({Key key, this.token}) : super(key: key);
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {


  List<BottomNavigationBarItem> _itemList = [
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.home),label: "home"),
    BottomNavigationBarItem(icon: Icon(Icons.category_outlined), label: "Categories"),
    BottomNavigationBarItem(icon: Icon(CommunityMaterialIcons.cart_variant), label: "My Cart"),
    BottomNavigationBarItem(icon: Icon(Icons.menu), label: "Menu"),];
  List<Widget> _pages ;
  int _barIndex = 0;
  PageController _pageViewCont = PageController();
  @override
  void initState() {
    // TODO: implement initState
    _pages = [HomePage(), Categories(), MyCart( token: widget.token,), Menu()];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: PageView(
        controller: _pageViewCont,
        children: _pages,
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: (value) {
          _barIndex = value;
          setState(() {});
        },
        pageSnapping: true,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _itemList,
      currentIndex: _barIndex,
      onTap: (index){
        setState(() {
          _barIndex = index;
          _pageViewCont.jumpToPage(index);
          setState(() {});
        });},
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.white,
        backgroundColor:Color(0xFF192a56),

    ),
    ));
  }
}
