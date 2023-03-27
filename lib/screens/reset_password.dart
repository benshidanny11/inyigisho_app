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

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<ResetPassword> {

  TextEditingController usernameController = TextEditingController();
  late Future<Response> reset;

  Future<Response> resetPasswordRequest() async {
    try {
      final response = await http.post(Uri.parse(AppApi.RESET_PASSWORD_ENDPOINT), body: json.encode(
          {"username": usernameController.text})).timeout(const Duration(seconds: 35));
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
          Container(margin: EdgeInsets.only(left: 7),child:Text('Resetting Password... Please Wait...')),
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
          content: Text('OTP token has been sent to your email'),
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
                          'Reset Password',
                          style: TextStyle(fontSize: 20),
                        )),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        controller: usernameController,
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
                          labelText: 'Phone number or Email',
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
                          child: Text('Reset Password'),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              showProgressDialog(context);
                              resetPasswordRequest().then((value) {
                                Navigator.pop(context);
                                if(value.statusCode == 200){
                                  showSuccessAlert(context);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text(value.responseBody),
                                  ));
                                  if(value.statusCode == 403){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SetEmail(), settings: RouteSettings(arguments: usernameController.text)));
                                  }
                                }
                              });
                            }
                          },
                        )),
                  ],
                ))
        ));
  }

}
