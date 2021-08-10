import 'package:amit_project/Model/User/User%20Api.dart';
import 'package:amit_project/Model/User/User.dart';
import 'package:amit_project/Opening/LoginPage.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey();
  bool isHidden = true;

  void onListen() {
    setState(() {});
  }

  void passwordVisibility() {
    setState(() {
      isHidden = !isHidden;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController.addListener(onListen);
    _emailController.addListener(onListen);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _nameController.removeListener(onListen);
    _emailController.removeListener(onListen);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor:  Color(0xFF192a56),
        body: SingleChildScrollView(
          child: Container(
            height: double.infinity,
            alignment: Alignment.topCenter,
            constraints: BoxConstraints.expand(height: 710,width: 500),
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                    child: Container(
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                            icon: Icon(Icons.arrow_back_sharp,color: Colors.white,),
                            onPressed: () {
                              Navigator.of(context).pop();
                            }),
                      ),
                      Align(alignment: Alignment.center,
                          child: Text("Sign Up", style: GoogleFonts.mavenPro(color: Colors.white,fontSize: 35))),
                    ],
                  ),
                )),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(left:20,right: 20),
                    child: Container(
                      height: double.infinity,
                      padding: EdgeInsets.only(top: 0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(75),
                          topRight: Radius.circular(75),
                        )
                      ),

                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 5, right: 35, left: 35),
                              child: TextFormField(
                                textInputAction: TextInputAction.done,
                                validator: (value) =>
                                    value.isEmpty ? "name is required" : null,
                                controller: _nameController,
                                decoration: InputDecoration(
                                  suffixIcon: _nameController.text.isEmpty
                                      ? Container(
                                          width: 0,
                                        )
                                      : IconButton(
                                          icon: Icon(Icons.close),
                                          onPressed: () {
                                            _nameController.clear();
                                          }),
                                  prefixIcon: Icon(Icons.person),
                                  labelText: "Name",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 5, right: 35, left: 35),
                              child: TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.done,
                                validator: (value) {
                                  if (value.isEmpty)
                                    return "E-mail is required";
                                  else if (!EmailValidator.validate(value))
                                    return "wrong E-mail";
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
                                          }),
                                  prefixIcon: Icon(Icons.email_outlined),
                                  labelText: "E-mail",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 5, right: 35, left: 35),
                              child: TextFormField(
                                textInputAction: TextInputAction.done,
                                validator: (value) =>
                                    value.isEmpty ? "Password is required" : null,
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
                            SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 5, right: 35, left: 35),
                              child: TextFormField(
                                textInputAction: TextInputAction.done,
                                validator: (value) {
                                  if (value.isEmpty)
                                    return " Confirm Password is required";
                                  else if (_passwordController.text !=
                                      _confirmPasswordController.text)
                                    return "Wrog Password";
                                  else
                                    return null;
                                },
                                controller: _confirmPasswordController,
                                obscureText: isHidden,
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                      onPressed: passwordVisibility,
                                      icon: isHidden
                                          ? Icon(Icons.visibility_off)
                                          : Icon(Icons.visibility)),
                                  prefixIcon: Icon(FontAwesomeIcons.key),
                                  labelText: "Confirm Password",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
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
                                child:
                                    Text("Register", style: GoogleFonts.quicksand()))
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  loginButton() async {
    if (!_formKey.currentState.validate()) {
      Fluttertoast.showToast(
          msg: "Register failed ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black87,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    User user = User(
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text);
    dynamic res = await UserApi.instance.register(user);
    if (UserApi.statusCode == 201) {
      user.token = res;
      print('token:$res');
      Fluttertoast.showToast(
          msg: "Register Done",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black87,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => LoginPage(),
      ));
    } else {
      print('error:${UserApi.statusCode},$res');
    }
  }
}
