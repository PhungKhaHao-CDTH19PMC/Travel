import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel/models/user.dart';
import 'package:travel/screens/signin.dart';
import 'package:travel/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUp extends StatefulWidget {
  @override
  SignUpState createState() {
    return SignUpState();
  }
}

class SignUpState extends State<SignUp> {
  final FocusNode focusEmail = FocusNode();
  final FocusNode focusPassword = FocusNode();
  final FocusNode focusName = FocusNode();
  final FocusNode focusConfirmPassword = FocusNode();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  bool _hidepassword = false;
  bool _obscureText = true;
  String? errorMessage;
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
            padding: EdgeInsets.only(top: 80.0),
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
                        height: 510.00,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 20.0,
                                  bottom: 20.0,
                                  left: 25.0,
                                  right: 25.0),
                              child: TextFormField(
                                focusNode: focusName,
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
                                focusNode: focusEmail,
                                controller: emailController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return ('Vui lòng nhập email');
                                  }
                                  if (!RegExp(
                                          '^[a-zA-Z0-9+_.-]+@[a-zA-z0-9.-]+.[a-z]')
                                      .hasMatch(value)) {
                                    return ('Nhập email đúng định dạng');
                                  }
                                  return null;
                                },
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
                              padding: EdgeInsets.only(
                                  top: 20.0,
                                  bottom: 20.0,
                                  left: 25.0,
                                  right: 25.0),
                              child: TextFormField(
                                obscureText: _obscureText,
                                focusNode: focusPassword,
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
                              padding: EdgeInsets.only(
                                  top: 20.0,
                                  bottom: 20.0,
                                  left: 25.0,
                                  right: 25.0),
                              child: TextFormField(
                                obscureText: _obscureText,
                                focusNode: focusConfirmPassword,
                                controller: confirmPasswordController,
                                validator: (value) {
                                  if (passwordController.text != value) {
                                    return ('Password không trùng khớp');
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  confirmPasswordController.text = value!;
                                },
                                style: TextStyle(
                                    fontFamily: "SignikaSemiBold",
                                    fontSize: 16.0,
                                    color: Colors.black),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    icon: Icon(
                                      FontAwesomeIcons.lock,
                                      color: Colors.black,
                                      size: 22.0,
                                    ),
                                    hintText: "Confirm password",
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
                              margin: const EdgeInsets.only(top: 40.0),
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
                                  signUp(emailController.text,
                                      passwordController.text);
                                },
                              ),
                            )
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

  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {postDetailsToFirestore()})
            .catchError((e) {
          Fluttertoast.showToast(msg: e.message);
        });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";
            break;

          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;

          default:
            errorMessage = "Vui lòng kiểm tra lại thông tin.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
  }

  postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sedning these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User user = _auth.currentUser!;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.uid = user.uid;
    userModel.email = user.email;
    userModel.name = nameController.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Đăng kí thành công :) ");

    Navigator.pushAndRemoveUntil((context),
        MaterialPageRoute(builder: (context) => Login()), (route) => false);
  }
}
