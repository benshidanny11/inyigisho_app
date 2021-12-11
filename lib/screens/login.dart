import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inyigisho_app/models/Response.dart';
import 'package:inyigisho_app/screens/home.dart';
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
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late Future<Response> logIn;
  SharedPreferences? sharedPreferences;

  Future<Response> logUserIn() async {
    final response = await http.post(Uri.parse(AppApi.LOGIN_ENDPOINT), body: json.encode({"phone_number": nameController.text, "password": passwordController.text}));

    return Response(response.statusCode, response.body);
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
                        maxLength: 18,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
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
                          labelText: 'Phone Number',
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        obscureText: true,
                        controller: passwordController,
                        maxLength: 18,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
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
                          labelText: 'Password',
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
                          child: Text('Login'),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              showProgressDialog(context);
                              logUserIn().then((value) {
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(value.responseBody),
                                ));
                                if(value.statusCode == 200){
                                  //save login state
                                  setState((){
                                    sharedPreferences!.setBool(LOGIN_STATE, true);
                                  });
                                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Home()), (Route<dynamic> route) => false);
                                }
                              });
                            }
                          },
                        )),
                    Container(child: Row(
                      children: <Widget>[
                        Text('New? Create an account?'),
                        FlatButton(
                          textColor: Colors.blue,
                          child: Text(
                            'Sign Up',
                            style: TextStyle(fontSize: 20),
                          ),
                          onPressed: () {
                            goToSignupPage(context);
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
