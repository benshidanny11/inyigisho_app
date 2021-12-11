import 'package:flutter/material.dart';
import 'package:inyigisho_app/constants/routes.dart';
import 'package:inyigisho_app/providers/Years.dart';
import 'package:inyigisho_app/screens/login.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool isDataLoaded = false;
  static const String LOGIN_STATE ='LOGIN_STATE';

  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((sharePreferences) {

      bool loggedIn = sharePreferences.getBool(LOGIN_STATE) ?? false;

      if(loggedIn){
        Future.delayed(Duration.zero, () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Home()), (Route<dynamic> route) => false);
        });
      } else {
        Future.delayed(Duration.zero, () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()), (Route<dynamic> route) => false);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blue[800] as Color,
            Theme.of(context).primaryColor,
          ],
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "Inyigisho",
                style: TextStyle(
                    color: Colors.white,
                    shadows: [Shadow(color: Colors.grey[100] as Color)],
                    fontSize: 20),
              ),
            ),
            SizedBox(height: 10),
            CircularProgressIndicator(
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
