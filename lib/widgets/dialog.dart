// replace this function with the examples above
import 'dart:io';

import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:inyigisho_app/constants/strings.dart';
import 'package:url_launcher/url_launcher.dart';

void openEmail(){
  _launchMailClient();
}

void _launchMailClient() async {
  var mailUrl = "mailto:info@umuhuza.com";
  try {
    await launch(mailUrl);
  } catch (e) {

  }
}

void _openTelegram(String number) async {
  var telegramURlAndroid = "https://t.me/$number";
  var telegramURliOS = "https://wa.me/$number";
  if (Platform.isIOS) {
    await launch(telegramURliOS, forceSafariVC: false);
  } else {
    await launch(telegramURlAndroid);
  }
}

void _openWhatsApp(String number) async {
  var whatsappURlAndroid = "whatsapp://send?phone=" + number;
  var whatappURLIos = "https://wa.me/$number";
  if (Platform.isIOS) {
    await launch(whatappURLIos, forceSafariVC: false);
  } else {
    await launch(whatsappURlAndroid);
  }
}

showPlatformDialog(BuildContext context) {
  // set up the list options
  Widget optionOne = SimpleDialogOption(
    child: const Text('WhatsApp'),
    padding: EdgeInsets.all(20.0),
    onPressed: () {
      Navigator.pop(context, true);
      showAlertDialog(context, "whatsapp");
    },
  );
  Widget optionTwo = SimpleDialogOption(
    child: const Text('Telegram'),
    padding: EdgeInsets.all(20.0),
    onPressed: () {
      Navigator.pop(context, true);
      showAlertDialog(context, "telegram");
    },
  );

  // set up the SimpleDialog
  SimpleDialog dialog = SimpleDialog(
    title: const Text('Choose platform'),
    children: <Widget>[
      optionOne,
      optionTwo,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return dialog;
    },
  );
}

showAlertDialog(BuildContext context, String app) {

  // set up the list options
  Widget optionOne = SimpleDialogOption(
    child: const Text('+32 466 192 703'),
    padding: EdgeInsets.all(20.0),
    onPressed: () {
      if(app == "whatsapp") {
        _openWhatsApp('+32 466 192 703');
      } else {
        _openTelegram('+32 466 192 703');
      }
      Navigator.pop(context, true);
    },
  );
  Widget optionTwo = SimpleDialogOption(
    child: const Text('+31 620 699903'),
    padding: EdgeInsets.all(20.0),
    onPressed: () {
      if(app == "whatsapp") {
        _openWhatsApp('+32 466 192 703');
      } else {
        _openTelegram('+32 466 192 703');
      }
      Navigator.pop(context, true);
    },
  );
  Widget optionThree = SimpleDialogOption(
    child: const Text('+32 489 243838'),
    padding: EdgeInsets.all(20.0),
    onPressed: () {
      if(app == "whatsapp") {
        _openWhatsApp('+32 466 192 703');
      } else {
        _openTelegram('+32 466 192 703');
      }
      Navigator.pop(context, true);
    },
  );

  // set up the SimpleDialog
  SimpleDialog dialog = SimpleDialog(
    title: const Text('Choose a number'),
    children: <Widget>[
      optionOne,
      optionTwo,
      optionThree,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return dialog;
    },
  );
}