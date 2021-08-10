
import 'package:amit_project/Opening/OpenPage.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  Future<SharedPreferences> _token;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _token = SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => null,
      child: SafeArea(
          child: Scaffold(
        appBar: AppBar(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(7),
                  bottomLeft: Radius.circular(7))),
          automaticallyImplyLeading: false,
          elevation: 5,
          centerTitle: true,
          backgroundColor:  Color(0xFF192a56),
          title: Text(
            "Menu",
            style: GoogleFonts.quicksand(),
          ),
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Column(
                children: [
                  buildListTile(
                      tileName: "Rate App",
                      tileLeadingIcon: FontAwesomeIcons.award,
                      tileTrailingIcon: Icons.arrow_forward_ios_rounded),
                  Padding(
                    padding: const EdgeInsets.only(left: 33),
                    child: Container(
                      color: Colors.black26,
                      width: 282,
                      height: 1,
                    ),
                  ),
                  buildListTile(
                      tileName: "Share App",
                      tileLeadingIcon: Icons.ios_share,
                      tileTrailingIcon: Icons.arrow_forward_ios_rounded),
                  Padding(
                    padding: const EdgeInsets.only(left: 33),
                    child: Container(
                      color: Colors.black26,
                      width: 282,
                      height: 1,
                    ),
                  ),
                  buildListTile(
                      tileName: "Contact Us",
                      tileLeadingIcon: Icons.contact_phone_outlined,
                      tileTrailingIcon: Icons.arrow_forward_ios_rounded),
                  Padding(
                    padding: const EdgeInsets.only(left: 33),
                    child: Container(
                      color: Colors.black26,
                      width: 282,
                      height: 1,
                    ),
                  ),
                  InkWell(
                      onTap: logOut,
                      child: buildListTile(
                          tileName: "Log Out",
                          tileLeadingIcon:
                              CommunityMaterialIcons.account_key_outline,
                          tileTrailingIcon: Icons.arrow_forward_ios_rounded)),
                  Padding(
                    padding: const EdgeInsets.only(left: 33),
                    child: Container(
                      color: Colors.black26,
                      width: 282,
                      height: 1,
                    ),
                  ),
                  buildListTile(
                      tileName: "Settings",
                      tileLeadingIcon: FontAwesomeIcons.cogs,
                      tileTrailingIcon: Icons.arrow_forward_ios_rounded),
                  Padding(
                    padding: const EdgeInsets.only(left: 33),
                    child: Container(
                      color: Colors.black26,
                      width: 282,
                      height: 1,
                    ),
                  ),

                ],
              ),
            )
          ],
        ),
      )),
    );
  }

  Widget buildListTile(
      {String tileName, IconData tileTrailingIcon, IconData tileLeadingIcon}) {
    return ListTile(
      minLeadingWidth: 5,
      leading: Icon(tileLeadingIcon),
      title: Text(tileName, style: GoogleFonts.quicksand(

      )),
      trailing: Icon(tileTrailingIcon),
    );
  }

  logOut() async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Are you sure ?",
              style: GoogleFonts.quicksand(color: Colors.black)),
          content: Text("do you want to log out ?",
              style: GoogleFonts.quicksand(color: Colors.black)),
          actions: [
            ElevatedButton(
                style: ButtonStyle(
                    elevation: MaterialStateProperty.all(0),
                    backgroundColor: MaterialStateProperty.all(Colors.white)),
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(
                  "No",
                  style: GoogleFonts.quicksand(color: Colors.black),
                )),
            FutureBuilder(
              future: _token,
              builder: (context, AsyncSnapshot<SharedPreferences> snapshot) {
                return ElevatedButton(
                    style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white)),
                    onPressed: () async {
                      await snapshot.data.clear();
                      return Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => OpenPage(),
                          ),
                          (route) => false);
                    },
                    child: Text("Yes",
                        style: GoogleFonts.quicksand(color: Colors.black)));
              },
            ),
          ],
        );
      },
    );
  }
}
