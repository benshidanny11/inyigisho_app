import 'package:flutter/material.dart';
import 'package:inyigisho_app/providers/ArchiveLessons.dart';
import 'package:inyigisho_app/providers/Years.dart';
import 'package:inyigisho_app/providers/comments.dart';
import 'package:inyigisho_app/providers/videolessons.dart';
import 'package:inyigisho_app/screens/videolessondetails.dart';
import 'package:inyigisho_app/screens/welcome.dart';
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
    ChangeNotifierProvider<Years>(create: (_)=>Years()),
    ChangeNotifierProvider<ArchiveLessons>(create: (_)=>ArchiveLessons()),
    ChangeNotifierProvider<VideoLessons>(create: (_)=>VideoLessons())
  ],
      child: MaterialApp(
        title: 'Lessons',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          //fontFamily:'RobotoCondensed'
        ),
        home: WelcomePage(),
        routes: {
          RouteConstants.LeasonDetailsRoute:(ctx)=>LeasonDatails(),
          RouteConstants.VideoLessonDetailsRoute:(ctx)=>VideoLessonDetails(),
          RouteConstants.HomeRoute:(ctx)=>Home()
        },
      ),
    );
  }
}
