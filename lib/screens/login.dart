import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inyigisho_app/screens/signup.dart';
import 'package:inyigisho_app/constants/apis.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late Future<String> logIn;

  Future<String> logUserIn() async {
    final response = await http.post(Uri.parse(AppApi.LOGIN_ENDPOINT), body: json.encode({"email": nameController.text, "password": passwordController.text}));

    if (response.statusCode == 200) {
      return "success";
    } else {
      return "failed";
    }
  }

  @override
  void initState() {
    super.initState();
    logIn = logUserIn();
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
                        child:Text("Verifying... Please wait..." )),
                  ]
              ),
            )
        ));
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
                          'Sign in',
                          style: TextStyle(fontSize: 20),
                        )),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        controller: nameController,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'Fill this field';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'E-Mail',
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        obscureText: true,
                        controller: passwordController,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'Fill this field';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                        ),
                      ),
                    ),
                    Container(
                        height: 70,
                        padding: EdgeInsets.all(10),
                        child: RaisedButton(
                          textColor: Colors.white,
                          color: Colors.blue,
                          child: Text('Login'),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              showProgressDialog(context);
                              logUserIn().then((value) {
                                Navigator.pop(context);
                                print(value);
                              });
                            }
                          },
                        )),
                    Container(
                        child: Row(
                          children: <Widget>[
                            Text('New? Create an account?'),
                            FlatButton(
                              textColor: Colors.blue,
                              child: Text(
                                'Sign Up',
                                style: TextStyle(fontSize: 20),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => SignupPage()),
                                );
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
