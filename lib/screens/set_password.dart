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
import 'package:inyigisho_app/screens/login.dart';
import 'package:inyigisho_app/screens/set_email.dart';

class SetPassword extends StatefulWidget {
  const SetPassword({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<SetPassword> {

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  late Future<Response> reset;

  Future<Response> resetPasswordRequest() async {
    try {
      final response = await http.post(Uri.parse(AppApi.SET_PASSWORD_ENDPOINT), body: json.encode(
          {"username": usernameController.text, "confirm_password": confirmPasswordController.text, "password": passwordController.text})).timeout(const Duration(seconds: 35));
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
    reset = resetPasswordRequest();
  }

  showProgressDialog(BuildContext context){
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(margin: EdgeInsets.only(left: 7),child:Text('Setting New Password... Please Wait...')),
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
          content: Text('New password set, you may proceed to log in'),
          actions: <Widget>[
            TextButton(
              child: Text("Okay"),
              onPressed: () {
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginPage()), (Route<dynamic> route) => false);
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
    final username = ModalRoute.of(context)!.settings.arguments as String;
    usernameController.text = username;

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
                          'Create New Password',
                          style: TextStyle(fontSize: 20),
                        )),
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
                          child: Text('Set Password'),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              if(passwordController.text == confirmPasswordController.text){
                                showProgressDialog(context);
                                resetPasswordRequest().then((value) {
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
