import 'package:amit_project/Opening/LoginPage.dart';
import 'package:amit_project/Opening/RegisterPage.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OpenPage extends StatefulWidget {
  @override
  _OpenPageState createState() => _OpenPageState();
}

class _OpenPageState extends State<OpenPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFF192a56),
                ),
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        flex: 1,
                        child: Container(
                            child: Align(
                              alignment: Alignment.center,
                                child: Text("Souq.",
                                    style: GoogleFonts.quicksand(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 60,
                                        color: Colors.white))))),
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(110),
                                topRight: Radius.circular(110))),
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              style: ButtonStyle(
                                  elevation: MaterialStateProperty.all(3),
                                  padding: MaterialStateProperty.all(EdgeInsets.only(left: 20,right: 20)),
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.blue)),
                              child: Text(
                                "Sign In",
                                style: GoogleFonts.quicksand(fontSize: 20,
                                  color: Colors.white
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => LoginPage(),
                                ));
                              },
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                elevation: MaterialStateProperty.all(3),
                                  padding: MaterialStateProperty.all(EdgeInsets.only(left: 15.5,right: 15.5)),
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.blue)),
                              child: Text("Sign Up",
                                  style: GoogleFonts.quicksand(
                                      fontSize: 20,
                                      color: Colors.white
                                  )),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => RegisterPage(),
                                ));
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
