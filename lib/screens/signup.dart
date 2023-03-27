import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:inyigisho_app/constants/apis.dart';
import 'package:inyigisho_app/models/Response.dart';

import 'login.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<SignupPage> {

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  late Future<Response> signup;

  Future<Response> signUserUp() async {
    try {
      final response = await http.post(Uri.parse(AppApi.SIGNUP_ENDPOINT), body: json.encode(
          {"phone_number": phoneNumberController.text,
            "email": emailController.text,
            "password": passwordController.text,
            "names": nameController.text,
          })).timeout(const Duration(seconds: 35));
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
    signup = signUserUp();
  }

  showProgressDialog(BuildContext context){
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(margin: EdgeInsets.only(left: 7),child:Text('creating_account'.tr())),
        ],),
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }

  showSuccessAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
              children:[
                Icon(Icons.check_circle),
                Text('')
              ]
          ),
          content: Text('account_created'.tr()),
          actions: <Widget>[
            TextButton(
              child: Text("Okay"),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop(phoneNumberController.text);
              },
            ),
          ],
        );
      },
    );
  }

  final _formKey = GlobalKey<FormState>();

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
                          'createAccount'.tr(),
                          style: TextStyle(fontSize: 20),
                        )),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        controller: nameController,
                        maxLength: 25,
                        validator: (text) {
                          if (text == null || text.isEmpty || text.length < 1) {
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
                          labelText: 'names'.tr(),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        controller: phoneNumberController,
                        maxLength: 18,
                        // inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                        keyboardType: TextInputType.number,
                        validator: (text) {
                          if (text == null || text.isEmpty || text.length < 5) {
                            return 'min_six_chars'.tr();
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
                          labelText: 'phoneNumber'.tr(),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        controller: emailController,
                        maxLength: 25,
                        keyboardType: TextInputType.emailAddress,
                        validator: (text) {
                          if (text == null || text.isEmpty || !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(text)) {
                            return 'valid email required!';
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
                          labelText: 'Email',
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        obscureText: true,
                        maxLength: 16,
                        controller: passwordController,
                        validator: (text) {
                          if (text == null || text.isEmpty || text.length < 7) {
                            return 'min_eight_chars'.tr();
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
                          labelText: 'password'.tr(),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        obscureText: true,
                        maxLength: 16,
                        controller: confirmPasswordController,
                        validator: (text) {
                          if (text == null || text.isEmpty || text.length < 7) {
                            return 'min_eight_chars'.tr();
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
                          labelText: 'confirmPassword'.tr(),
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
                          child: Text('signup'.tr()),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              if(passwordController.text == confirmPasswordController.text){
                                showProgressDialog(context);
                                signUserUp().then((value) {
                                  Navigator.pop(context);
                                  if(value.statusCode == 201){
                                    showSuccessAlert(context);
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                      content: Text(value.responseBody),
                                    ));
                                  }
                                });
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text('passwordsDontMatch'.tr()),
                                ));
                              }
                            }
                          },
                        )),
                  ],
                ))
        ));
  }

}
