import 'package:amit_project/Global/Progress%20indecator.dart';
import 'package:amit_project/MainApp.dart';
import 'package:amit_project/Model/User/User%20Api.dart';
import 'package:amit_project/Model/User/User.dart';
import 'package:amit_project/Opening/RegisterPage.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isHidden = true;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey();

  void passwordVisibility() {
    setState(() {
      isHidden = !isHidden;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailController.addListener(onListen);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.removeListener(onListen);
    _passwordController.dispose();
    super.dispose();
  }

  void onListen() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            backgroundColor:  Color(0xFF192a56),
            body: Column(
              children: [
                Expanded(flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                        color:  Color(0xFF192a56),),

                    width: double.infinity,
                    height: 100,
                    child: Stack(children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(alignment: Alignment.center,
                            child: Text("Sign In",
                                style: GoogleFonts.mavenPro(fontSize: 35,color: Colors.white))),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                            icon: Icon(Icons.arrow_back_sharp,color: Colors.white,),
                            onPressed: () {
                              Navigator.of(context).pop();
                            }),
                      )


                    ],),
                  ),
                ),
                Expanded(flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white, borderRadius:BorderRadius.only(topLeft: Radius.circular(50),topRight:Radius.circular(50) )),
                    alignment: Alignment.topCenter,
                    height: 500,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 30,
                                right: 35,
                                left: 35),
                            child: TextFormField(
                               autocorrect: true,
                              strutStyle: StrutStyle(),
                              cursorColor:  Color(0xFF192a56),
                              autofillHints: [AutofillHints.email],
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.done,
                              validator: (value) {
                                if (value.isEmpty)
                                  return "E-mail is required";
                                else if (!EmailValidator.validate(value))
                                  return "Wrong E-mail";
                                else
                                  return null;
                              },
                              controller: _emailController,
                              decoration: InputDecoration(

                                suffixIcon: _emailController.text.isEmpty
                                    ? Container(
                                  width: 0,
                                )
                                    : IconButton(
                                  icon: Icon(Icons.close),
                                  onPressed: () {
                                    _emailController.clear();
                                  },
                                ),
                                prefixIcon: Icon(Icons.email_outlined),
                                labelText: "E-mail",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                focusColor: Colors.black,
                                hoverColor: Colors.black,
                                fillColor: Colors.black,


                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5,
                                right: 35,
                                left: 35),
                            child: TextFormField(
                              cursorColor: Colors.black,
                              textInputAction: TextInputAction.done,
                              validator: (value) {
                                if (value.isEmpty)
                                  return "Password is required";
                                else
                                  return null;
                              },
                              controller: _passwordController,
                              obscureText: isHidden,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                    onPressed: passwordVisibility,
                                    icon: isHidden
                                        ? Icon(Icons.visibility_off)
                                        : Icon(Icons.visibility)),
                                prefixIcon: Icon(FontAwesomeIcons.key),
                                labelText: "Password",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 38),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 5, top: 4),
                                  child: Text("Doesn't have Email?",
                                      style: GoogleFonts.vollkorn(color: Colors.black
                                      )),
                                ),
                                TextButton(
                                    style: ButtonStyle(),
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                RegisterPage(),
                                          ));
                                    },
                                    child: Text("Register",
                                        style: GoogleFonts.quicksand(
                                          color: Colors.blue
                                        ))),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                  MaterialStateProperty.all(Color(0xFF192a56))),
                              onPressed: loginButton,
                              child: Text("login",
                                  style: GoogleFonts.quicksand(
                                    color: Colors.white
                                  )))
                        ],
                      ),
                    ),),
                ),


              ],
            ),
          ),
        ));
  }

  loginButton() async {
    await Dialogs.showProgressDialog(context: context, msg: "Loading");
    if (!_formKey.currentState.validate()) {
      Fluttertoast.showToast(
          msg: "login failed ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      await Dialogs.hideProgressDialog();
    }
    else {
      User user = User(
          email: _emailController.text, password: _passwordController.text);
      dynamic res = await UserApi.instance.login(user);
      if (UserApi.statusCode == 200) {
        user.token = res;
        SharedPreferences tok = await SharedPreferences.getInstance();
        tok.setString("token", user.token);
        await Dialogs.hideProgressDialog();
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => MainApp(token: tok.getString("token"),),
        ));
      } else {
        Fluttertoast.showToast(
            msg: "Wrong E-mail or Password",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        await Dialogs.hideProgressDialog();
        print('Error:${UserApi.statusCode},$res');
      }
    }
  }


}
