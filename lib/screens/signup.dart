import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:inyigisho_app/constants/apis.dart';
import 'package:inyigisho_app/models/Response.dart';

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
  late Future<Response> signup;

  Future<Response> signUserUp() async {
    final response = await http.post(Uri.parse(AppApi.SIGNUP_ENDPOINT), body: json.encode(
        {"phone_number": phoneNumberController.text,
          "password": passwordController.text,
          "names": nameController.text,
        }));

    return Response(response.statusCode, response.body);
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
          Container(margin: EdgeInsets.only(left: 7),child:Text("Creating account... Please wait..." )),
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
          content: Text("Account created successfully"),
          actions: <Widget>[
            FlatButton(
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
                          'Create Account',
                          style: TextStyle(fontSize: 20),
                        )),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        controller: nameController,
                        maxLength: 25,
                        validator: (text) {
                          if (text == null || text.isEmpty || text.length < 1) {
                            return 'Fill this field';
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
                          labelText: 'Names',
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
                            return 'Minimum 6 characters!';
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
                          labelText: 'Phone Number',
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
                            return '8 characters minimum';
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
                          labelText: 'Password',
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
                            return '8 characters minimum';
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
                          labelText: 'Confirm Password',
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
                          child: Text('Signup'),
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
                                  content: Text("Passwords don't match!"),
                                ));
                              }
                            }
                          },
                        )),
                    Container(
                        child: Row(
                          children: <Widget>[
                            Text('Already have an account?'),
                            FlatButton(
                              textColor: Colors.blue,
                              child: Text(
                                'Login',
                                style: TextStyle(fontSize: 20),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
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
