import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inyigisho_app/models/Response.dart';
import 'package:inyigisho_app/screens/home.dart';
import 'package:inyigisho_app/screens/reset_password.dart';
import 'package:inyigisho_app/screens/set_password.dart';
import 'package:inyigisho_app/screens/signup.dart';
import 'package:inyigisho_app/constants/apis.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  static const String LOGIN_STATE ='LOGIN_STATE';
  static const String LOGIN_TIME ='LOGIN_TIME';
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late Future<Response> logIn;
  SharedPreferences? sharedPreferences;
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;

  Future<Response> logUserIn() async {
    try {
      final response = await http.post(Uri.parse(AppApi.LOGIN_ENDPOINT), body: json.encode({"username": nameController.text, "password": passwordController.text})).timeout(const Duration(seconds: 20));

      return Response(response.statusCode, response.body);
    } on SocketException {
      return Response(0, "network error");
    } on TimeoutException {
      return Response(-1, "request timeout");
    }
  }

  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((sp) {
      sharedPreferences = sp;
    });

    logIn = logUserIn();
  }

  void goToSignupPage(BuildContext context) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SignupPage())
    );
    //set the phone number into the field
    if(result.toString().isNotEmpty && result.toString() != "null"){
      nameController.text = result.toString();
    }
  }

  showProgressDialog(BuildContext context){
    showDialog(barrierDismissible: false,
        context:context,
        builder: (BuildContext context) => WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              content: new Row(
                  children: [
                    CircularProgressIndicator(),
                    Container(margin: EdgeInsets.only(left: 7),
                        child:Text('verifying'.tr())),
                  ]
              ),
            )
        ));
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
            key: _formKey,
            child: Padding(
                padding: EdgeInsets.all(10),
                child: ListView(
                  children: <Widget>[
                    Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Umuhuza',
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w500,
                              fontSize: 30),
                        )),
                    Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'login'.tr(),
                          style: TextStyle(fontSize: 20),
                        )),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        controller: nameController,
                        maxLength: 18,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'fillThisField'.tr();
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          filled: true,
                          contentPadding: EdgeInsets.all(16),
                          fillColor: Colors.grey[300],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),),
                          labelText: 'Phone number or email',
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        obscureText: _obscureText,
                        controller: passwordController,
                        maxLength: 18,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'fillThisField'.tr();
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          suffixIcon: InkWell(
                            onTap: _toggle,
                            child: Icon(
                              _obscureText ? FontAwesomeIcons.eye : FontAwesomeIcons.eyeSlash
                            )
                          ),
                          filled: true,
                          contentPadding: EdgeInsets.all(16),
                          fillColor: Colors.grey[300],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),),
                          labelText: 'password'.tr(),
                        ),
                      ),
                    ),
                    Container(
                        height: 70,
                        padding: EdgeInsets.all(10),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(20))),
                          ),
                          child: Text('login'.tr()),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              showProgressDialog(context);
                              logUserIn().then((value) {
                                Navigator.of(context, rootNavigator: true).pop('dialog');
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(value.responseBody),
                                ));
                                if(value.statusCode == 200){
                                  //save login state
                                  setState((){
                                    sharedPreferences!.setBool(LOGIN_STATE, true);
                                    sharedPreferences!.setString(LOGIN_TIME, DateFormat("yyyy-MM-dd HH:mm").format(DateTime.now()).toString());
                                  });
                                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Home()), (Route<dynamic> route) => false);
                                } else if(value.statusCode == 302){
                                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => SetPassword()), (Route<dynamic> route) => false);
                                }
                              });
                            }
                          },
                        )),
                    Container(child: Row(
                      children: <Widget>[
                        Text('createAccount'.tr(),),
                        FlatButton(
                          textColor: Colors.blue,
                          child: Text(
                            'signup'.tr(),
                            style: TextStyle(fontSize: 20),
                          ),
                          onPressed: () {
                            goToSignupPage(context);
                          },
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    )),
                    Container(child: Row(
                      children: <Widget>[
                        Text('Forgot Password?',),
                        FlatButton(
                          textColor: Colors.blue,
                          child: Text(
                            'Reset',
                            style: TextStyle(fontSize: 20),
                          ),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const ResetPassword()));
                          },
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ))
                  ],
                ))
        ));
  }

}
