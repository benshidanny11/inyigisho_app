import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:inyigisho_app/constants/routes.dart';
import 'package:inyigisho_app/providers/Years.dart';
import 'package:inyigisho_app/screens/login.dart';
import 'package:inyigisho_app/screens/welcome.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashScreen> {
  bool isDataLoaded = false;
  static const String LOGIN_STATE ='LOGIN_STATE';
  static const String LOGIN_TIME ='LOGIN_TIME';

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((sharePreferences) {

      bool loggedIn = sharePreferences.getBool(LOGIN_STATE) ?? false;
      String loginDate = sharePreferences.getString(LOGIN_TIME) ?? "";

      if(loggedIn){
        if(loginDate.isNotEmpty){
          final previousLoginDate = DateFormat('yyyy-MM-dd HH:mm').parse(loginDate);
          final difference = daysBetween(previousLoginDate, DateTime.now());

          //if the user hasn't used the app for a day
          if(difference > 1){
            Future.delayed(Duration.zero, () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => WelcomePage()), (Route<dynamic> route) => false);
            });
          } else {
            Future.delayed(Duration.zero, () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Home()), (Route<dynamic> route) => false);
            });
          }
        } else {
          Future.delayed(Duration.zero, () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => WelcomePage()), (Route<dynamic> route) => false);
          });
        }
      } else {
        Future.delayed(Duration.zero, () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => WelcomePage()), (Route<dynamic> route) => false);
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
