import 'package:flutter/material.dart';
import 'package:inyigisho_app/providers/comments.dart';
import 'package:provider/provider.dart';

import 'package:inyigisho_app/screens/home.dart';
import 'package:inyigisho_app/constants/routes.dart';
import 'package:inyigisho_app/providers/Leasons.dart';
import 'package:inyigisho_app/screens/leasondetails.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
  providers: [
    ChangeNotifierProvider<Leasons>(create: (_)=>Leasons(),),
    ChangeNotifierProvider<Comments>(create: (_)=>Comments(),),
  ],
      child: MaterialApp(
        title: 'Leasons',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Home(),
        routes: {
          RouteConstants.LeasonDetailsRoute:(ctx)=>LeasonDatails()
        },
      ),
    );
  }
}
