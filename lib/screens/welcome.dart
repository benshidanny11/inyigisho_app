import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:inyigisho_app/constants/routes.dart';
import 'package:inyigisho_app/providers/Years.dart';
import 'package:inyigisho_app/screens/login.dart';
import 'package:inyigisho_app/screens/signup.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool isDataLoaded = false;

  @override
  void initState() {
    super.initState();
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
                Colors.white,
                Colors.blue[200]!,
              ],
            )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "UMUHUZA",
                style: TextStyle(
                    color: Colors.grey,
                    shadows: [Shadow(color: Colors.grey[100] as Color)],
                    fontSize: 24),
              ),
            ),
            Center(
              child: Text(
                "w'",
                style: TextStyle(
                    color: Colors.grey,
                    shadows: [Shadow(color: Colors.grey[100] as Color)],
                    fontSize: 24),
              ),
            ),
            Center(
              child: Text(
                "U RWANDA RWAGUTSE",
                style: TextStyle(
                    color: Colors.blue,
                    shadows: [Shadow(color: Colors.grey[100] as Color)],
                    fontSize: 20),
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: EdgeInsets.all(20),
              child: Image.asset('assets/images/rda.png'),
            ),
            SizedBox(height: 30),
            Center(
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                    ),
                    child: Text('login'.tr()),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginPage()));
                    },
                  ),
                  SizedBox(width: 30),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                    ),
                    child: Text('signup'.tr()),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SignupPage()));
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 30,),
            Text('for_the_nation'.tr(), style: TextStyle(color: Colors.grey[700], fontWeight: FontWeight.w400, fontSize: 18),)
          ],
        ),
      ),
    );
  }
}
