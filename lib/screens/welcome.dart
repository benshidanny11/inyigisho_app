import 'package:flutter/material.dart';
import 'package:inyigisho_app/constants/routes.dart';
import 'package:inyigisho_app/providers/Years.dart';
import 'package:provider/provider.dart';

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
    double screenHeight = MediaQuery.of(context).size.height;
    Provider.of<Years>(context, listen: false).fetchYears().then((_) {
      Navigator.of(context).pushReplacementNamed(RouteConstants.HomeRoute);
    });
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.yellow[800] as Color,
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
