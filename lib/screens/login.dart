import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/src/public_ext.dart';
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
  static const String LOGIN_TIME ='LOGIN_TIME';
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
                        child:Text('verifying'.tr())),
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
                          labelText: 'phoneNumber'.tr(),
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
                    ))
                  ],
                ))
        ));
  }

}
