import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel/models/user.dart';
import 'package:travel/screens/signin.dart';
import 'package:travel/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'api.dart';

class SignUp extends StatefulWidget {
  @override
  SignUpState createState() {
    return SignUpState();
  }
}

class SignUpState extends State<SignUp> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  bool _hidepassword = false;
  bool _obscureText = true;
  String? errorMessage;
  String msg = '';
  Iterable s = [];
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/beach.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.only(top: 90.0),
            child: ListView(
              children: <Widget>[
                Stack(
                  alignment: Alignment.topCenter,
                  overflow: Overflow.visible,
                  children: <Widget>[
                    Card(
                      elevation: 2.0,
                      color: Colors.white54,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                      child: Container(
                        width: 360.00,
                        height: 550.00,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 20.0,
                                  bottom: 20.0,
                                  left: 25.0,
                                  right: 25.0),
                              child: TextFormField(
                                controller: nameController,
                                validator: (value) {
                                  RegExp regex = new RegExp(r'^.{6,}$');
                                  if (value!.isEmpty) {
                                    return ('Vui lòng nhập họ tên');
                                  }
                                  if (!regex.hasMatch(value)) {
                                    return ('Nhập họ tên ít nhất 6 kí tự');
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  nameController.text = value!;
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
                                    hintText: "Enter name",
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
                              padding: const EdgeInsets.only(
                                  top: 20.0,
                                  bottom: 20.0,
                                  left: 25.0,
                                  right: 25.0),
                              child: TextFormField(
                                controller: usernameController,
                                onSaved: (value) {
                                  usernameController.text = value!;
                                },
                                keyboardType: TextInputType.emailAddress,
                                style: const TextStyle(
                                    fontFamily: "SignikaSemiBold",
                                    fontSize: 16.0,
                                    color: Colors.black),
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    icon: Icon(
                                      FontAwesomeIcons.user,
                                      color: Colors.black,
                                      size: 22.0,
                                    ),
                                    hintText: "Enter Username",
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
                                  if (value!.isEmpty) {
                                    return ('Vui lòng nhập password');
                                  }
                                  if (!regex.hasMatch(value)) {
                                    return ('Vui lòng nhập password ít nhất 6 kí tự');
                                  }
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
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 20.0,
                                  bottom: 20.0,
                                  left: 25.0,
                                  right: 25.0),
                              child: TextFormField(
                                controller: emailController,
                                onSaved: (value) {
                                  emailController.text = value!;
                                },
                                keyboardType: TextInputType.emailAddress,
                                style: const TextStyle(
                                    fontFamily: "SignikaSemiBold",
                                    fontSize: 16.0,
                                    color: Colors.black),
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    icon: Icon(
                                      FontAwesomeIcons.envelope,
                                      color: Colors.black,
                                      size: 22.0,
                                    ),
                                    hintText: "Enter email",
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
                              padding: const EdgeInsets.only(
                                  top: 20.0,
                                  bottom: 20.0,
                                  left: 25.0,
                                  right: 25.0),
                              child: TextFormField(
                                controller: phoneController,
                                onSaved: (value) {
                                  phoneController.text = value!;
                                },
                                keyboardType: TextInputType.emailAddress,
                                style: const TextStyle(
                                    fontFamily: "SignikaSemiBold",
                                    fontSize: 16.0,
                                    color: Colors.black),
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    icon: Icon(
                                      FontAwesomeIcons.phone,
                                      color: Colors.black,
                                      size: 22.0,
                                    ),
                                    hintText: "Enter phone",
                                    hintStyle: TextStyle(
                                        fontFamily: "SignikaSemiBold",
                                        fontSize: 18.0)),
                              ),
                            ),
                            Container(
                              decoration: const BoxDecoration(
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
                                      begin: FractionalOffset(0.2, 0.2),
                                      end: FractionalOffset(1.0, 1.0),
                                      stops: [0.1, 1.0],
                                      tileMode: TileMode.clamp)),
                              child: MaterialButton(
                                highlightColor: Colors.transparent,
                                splashColor: AppColours.colorEnd,
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 42.0),
                                  child: Text(
                                    "Sign Up",
                                    style: TextStyle(
                                        fontFamily: "SignikaSemiBold",
                                        color: Colors.white,
                                        fontSize: 22.0),
                                  ),
                                ),
                                onPressed: () {
                                  API(
                                          url:
                                              "http://10.0.2.2/doan/api/dang_ki.php/?name=" +
                                                  nameController.text +
                                                  "&username=" +
                                                  usernameController.text +
                                                  "&password=" +
                                                  passwordController.text +
                                                  "&email=" +
                                                  emailController.text +
                                                  "&phone=" +
                                                  phoneController.text)
                                      .getDataString()
                                      .then((value) {
                                    s = json.decode(value);
                                  });
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Login()));
                                  setState(() {});
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
