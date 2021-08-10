import 'package:amit_project/home/HomeItem.dart';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  TabController tabController;
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 1, vsync: this, initialIndex: 0);
    _scrollController=ScrollController();

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body:
          NestedScrollView(
            controller: _scrollController,
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomRight: Radius.circular(7),bottomLeft:Radius.circular(10) )),
                  elevation: 20,
                  snap: true,
                  stretch: true,
                  backwardsCompatibility: true,
                  pinned: false,
                  floating: true,
                  forceElevated: innerBoxIsScrolled,
                  backgroundColor: Color(0xFF192a56),
                  centerTitle: true,
                  automaticallyImplyLeading: false,
                  title: Text("Home",style: GoogleFonts.quicksand()),
                ),
              ];
            },
            body: TabBarView(
                controller: tabController,
                children: [
                 HomeItem()
                ]),
          ),
        ));
  }
}
