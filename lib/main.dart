import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:inyigisho_app/providers/ArchiveLessons.dart';
import 'package:inyigisho_app/providers/Years.dart';
import 'package:inyigisho_app/providers/comments.dart';
import 'package:inyigisho_app/providers/videolessons.dart';
import 'package:inyigisho_app/screens/videolessondetails.dart';
import 'package:inyigisho_app/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:inyigisho_app/providers/Leasons.dart';

import 'constants/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();

  runApp(EasyLocalization(
      supportedLocales: [
        Locale('en', ''),
        Locale('de', ''),
        Locale('nl', ''),
        Locale('es', ''),
        Locale('fr', ''),
        Locale('sw', '')],
      path: 'assets/translations',
      fallbackLocale: Locale(Platform.localeName.substring(0,2), ''),
      child: Home()
  ));
}

class Home extends StatelessWidget {
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
        title: 'UMUHUZA',
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: ThemeData(
            primarySwatch: Colors.blue
          //fontFamily:'RobotoCondensed'
        ),
        routes: {
          RouteConstants.VideoLessonDetailsRoute: (context) => VideoLessonDetails(),
        },
        home: SplashScreen(),
      ),
    );
  }
}
