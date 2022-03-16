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
import 'package:inyigisho_app/screens/reset_password.dart';

class SetEmail extends StatefulWidget {
  const SetEmail({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<SetEmail> {

  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  late Future<Response> reset;

  Future<Response> resetPasswordRequest() async {
    try {
      final response = await http.post(Uri.parse(AppApi.SET_EMAIL_ENDPOINT), body: json.encode(
          {"email": emailController.text, "phone_number": phoneNumberController.text})).timeout(const Duration(seconds: 35));
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
          Container(margin: EdgeInsets.only(left: 7),child:Text('Setting your email... Please Wait...')),
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
          content: Text('Account email successfully updated!'),
          actions: <Widget>[
            FlatButton(
              child: Text("Okay"),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ResetPassword()));
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
                          'Inyigisho',
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w500,
                              fontSize: 30),
                        )),
                    Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Add Email to your Account',
                          style: TextStyle(fontSize: 20),
                        )),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        controller: emailController,
                        maxLength: 25,
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
                          labelText: 'E-mail',
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        controller: phoneNumberController,
                        maxLength: 18,
                        inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
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
                        height: 70,
                        padding: EdgeInsets.all(10),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(20))),
                          ),
                          child: Text('Set Email'),
                          onPressed: () {
                            if(_formKey.currentState!.validate()){
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
                            }
                          },
                        )),
                  ],
                ))
        ));
  }

}
