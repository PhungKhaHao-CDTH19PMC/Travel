import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel/screens/home.dart';
import 'package:travel/screens/viewpage.dart';
import 'package:travel/theme.dart';
import '../screens/signup.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'api.dart';

class Login extends StatefulWidget {
  @override
  LoginState createState() {
    return LoginState();
  }
}

class LoginState extends State<Login> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _hidepassword = false;
  bool _obscureText = true;
  //firebase
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  Iterable s = [];
  String a = '';
  String b = '';
  String c = '';
  String? errorMessage;
  int t = 0;
  @override
  Widget build(BuildContext context) {
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text("Sai thông tin"),
      content: Text(
        "Vui lòng kiểm tra lại thông tin tài khoản!",
        style: TextStyle(color: Colors.red),
      ),
      actions: [
        okButton,
      ],
    );
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/beach.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Center(
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                Stack(
                  alignment: Alignment.topCenter,
                  overflow: Overflow.visible,
                  children: <Widget>[
                    Card(
                      elevation: 2.0,
                      color: Colors.white60,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Container(
                        width: 360.00,
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: 60.0,
                              height: 60.0,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 20.0,
                                  bottom: 20.0,
                                  left: 25.0,
                                  right: 25.0),
                              child: TextFormField(
                                controller: usernameController,
                                validator: (value) {
                                  if (value == "") {
                                    return ("Please Enter Your Uername");
                                  }
                                  return "";
                                  // reg expression for email validation
                                  // if (!RegExp(
                                  //         "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                  //     .hasMatch(value)) {
                                  //   return ("Please Enter a valid email");
                                  // }
                                },
                                onSaved: (value) {
                                  usernameController.text = value!;
                                },
                                keyboardType: TextInputType.emailAddress,
                                style: TextStyle(
                                    fontFamily: "SignikaSemiBold",
                                    fontSize: 16.0,
                                    color: Colors.black),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    icon: Icon(
                                      FontAwesomeIcons.envelope,
                                      color: Colors.black,
                                      size: 22.0,
                                    ),
                                    hintText: "Enter username",
                                    hintStyle: TextStyle(
                                        fontFamily: "SignikaSemiBold",
                                        fontSize: 18.0)),
                              ),
                            ),
                            Container(
                              width: 250.0,
                              height: 1.0,
                              color: Colors.grey,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 20.0,
                                  bottom: 20.0,
                                  left: 25.0,
                                  right: 25.0),
                              child: TextFormField(
                                obscureText: _obscureText,
                                controller: passwordController,
                                validator: (value) {
                                  RegExp regex = new RegExp(r'^.{6,}$');
                                  if (value == "") {
                                    return ("Password is required for login");
                                  }
                                  return "";
                                  // if (!regex.hasMatch(value)) {
                                  //   return ("Enter Valid Password(Min. 6 Character)");
                                  // }
                                },
                                onSaved: (value) {
                                  passwordController.text = value!;
                                },
                                style: TextStyle(
                                    fontFamily: "SignikaSemiBold",
                                    fontSize: 16.0,
                                    color: Colors.black),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _hidepassword = !_hidepassword;
                                          _obscureText = !_obscureText;
                                        });
                                      },
                                      icon: Icon(_hidepassword
                                          ? FontAwesomeIcons.solidEye
                                          : FontAwesomeIcons.solidEyeSlash),
                                    ),
                                    icon: Icon(
                                      FontAwesomeIcons.lock,
                                      color: Colors.black,
                                      size: 22.0,
                                    ),
                                    hintText: "Enter password",
                                    hintStyle: TextStyle(
                                        fontFamily: "SignikaSemiBold",
                                        fontSize: 18.0)),
                              ),
                            ),
                            Container(
                              width: 250.0,
                              height: 1.0,
                              color: Colors.grey,
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 60.0, bottom: 26.0),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                        color: AppColours.colorStart,
                                        offset: Offset(1.0, 6.0),
                                        blurRadius: 20.0),
                                    BoxShadow(
                                        color: AppColours.colorEnd,
                                        offset: Offset(1.0, 6.0),
                                        blurRadius: 20.0),
                                  ],
                                  gradient: LinearGradient(
                                      colors: [
                                        AppColours.colorEnd,
                                        AppColours.colorStart
                                      ],
                                      begin: const FractionalOffset(0.2, 0.2),
                                      end: const FractionalOffset(1.0, 1.0),
                                      stops: [0.1, 1.0],
                                      tileMode: TileMode.clamp)),
                              child: MaterialButton(
                                highlightColor: Colors.transparent,
                                splashColor: AppColours.colorEnd,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 42.0),
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                        fontFamily: "SignikaSemiBold",
                                        color: Colors.white,
                                        fontSize: 22.0),
                                  ),
                                ),
                                onPressed: () {
                                  if (usernameController.text == '' ||
                                      passwordController.text == '') {
                                    signIn(usernameController.text,
                                        passwordController.text);
                                  }
                                  API(
                                          url:
                                              "http://10.0.2.2:8000/doan/api/dang_nhap.php/?username=" +
                                                  usernameController.text +
                                                  "&password=" +
                                                  passwordController.text)
                                      .getDataString()
                                      .then((value) {
                                    s = json.decode(value);
                                    c = value;
                                    a = s.elementAt(0)["username"].toString();
                                    b = s.elementAt(0)["password"].toString();
                                    if (a == usernameController.text &&
                                        b == passwordController.text) {
                                      setState(() {
                                        c = "";
                                      
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => ViewPage(
                                                    username: s
                                                        .elementAt(0)["id"]
                                                        .toString(),
                                                  )));
                                                  });
                                    }
                                  });
                                },
                              ),
                            ),
                            Container(
                              child: FlatButton(
                                child: Text(
                                  'Forgot password',
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Colors.black,
                                      fontSize: 18.0,
                                      fontFamily: "SignikaRegular"),
                                ),
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: FlatButton(
                    child: Text(
                      "Not have account?",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontFamily: "SignikaRegular"),
                    ),
                    onPressed: () {},
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      gradient: LinearGradient(
                          colors: [Colors.white, Colors.white],
                          begin: const FractionalOffset(0.2, 0.2),
                          end: const FractionalOffset(0.5, 0.5),
                          stops: [0.1, 0.5],
                          tileMode: TileMode.clamp)),
                  child: MaterialButton(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.white70,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 42.0),
                      child: Text(
                        "SignUp",
                        style: TextStyle(
                            fontFamily: "SignikaSemiBold",
                            color: Colors.black,
                            fontSize: 22.0),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SignUp()));
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          gradient: new LinearGradient(
                              colors: [
                                Colors.white10,
                                Colors.white,
                              ],
                              begin: const FractionalOffset(0.0, 0.0),
                              end: const FractionalOffset(1.0, 1.0),
                              stops: [0.0, 1.0],
                              tileMode: TileMode.clamp),
                        ),
                        width: 100.0,
                        height: 1.0,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 15.0, right: 15.0),
                        child: Text(
                          "OR",
                          style: TextStyle(
                              color: Colors.white,
                              decoration: TextDecoration.none,
                              fontSize: 16.0,
                              fontFamily: "WorkSansMedium"),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: new LinearGradient(
                              colors: [
                                Colors.white,
                                Colors.white10,
                              ],
                              begin: const FractionalOffset(0.0, 0.0),
                              end: const FractionalOffset(1.0, 1.0),
                              stops: [0.0, 1.0],
                              tileMode: TileMode.clamp),
                        ),
                        width: 100.0,
                        height: 1.0,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 10.0, right: 40.0),
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.all(15.0),
                          decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: new Icon(
                            FontAwesomeIcons.facebookF,
                            color: Color(0xFF0084ff),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0, right: 40.0),
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.all(15.0),
                          decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: new Icon(
                            FontAwesomeIcons.instagram,
                            color: Color(0xFF0084ff),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0, right: 40.0),
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.all(15.0),
                          decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: new Icon(
                            FontAwesomeIcons.github,
                            color: Color(0xFF0084ff),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.all(15.0),
                          decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: new Icon(
                            FontAwesomeIcons.google,
                            color: Color(0xFF0084ff),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {}
  }
}
