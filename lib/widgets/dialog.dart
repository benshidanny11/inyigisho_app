// replace this function with the examples above
import 'dart:io';

import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:inyigisho_app/constants/strings.dart';
import 'package:url_launcher/url_launcher.dart';

void openEmail() {
  _launchMailClient();
}

void _launchMailClient() async {
  var mailUrl = "mailto:info@umuhuza-iwacu.org";
  try {
    await launch(mailUrl);
  } catch (e) {}
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

// https://www.umuhuza-iwacu.org/youth-season-events/

showPlatformDialog(BuildContext context) {
  // set up the list options
  Widget optionOne = SimpleDialogOption(
    child: const Text('WhatsApp'),
    padding: EdgeInsets.all(20.0),
    onPressed: () {
      Navigator.of(context, rootNavigator: true).pop();
      showAlertDialog(context, "whatsapp");
    },
  );
  Widget optionTwo = SimpleDialogOption(
    child: const Text('Telegram'),
    padding: EdgeInsets.all(20.0),
    onPressed: () {
      Navigator.of(context, rootNavigator: true).pop();
      showAlertDialog(context, "telegram");
    },
  );
  Widget optionThree = SimpleDialogOption(
    child: const Text('e-mail'),
    padding: EdgeInsets.all(20.0),
    onPressed: () {
      Navigator.of(context, rootNavigator: true).pop();
      _launchMailClient();
    },
  );

  // set up the SimpleDialog
  SimpleDialog dialog = SimpleDialog(
    title: const Text('Choose platform'),
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

showAlertDialog(BuildContext context, String app) {
  // set up the list options
  Widget optionOne = SimpleDialogOption(
    child: const Text('+32 469 116 744'),
    padding: EdgeInsets.all(20.0),
    onPressed: () {
      Navigator.of(context, rootNavigator: true).pop();
      if (app == "whatsapp") {
        _openWhatsApp('+32 469 116 744');
      } else {
        _openTelegram('+32 469 116 744');
      }
    },
  );
  Widget optionTwo = SimpleDialogOption(
    child: const Text('+31 620 699903'),
    padding: EdgeInsets.all(20.0),
    onPressed: () {
      Navigator.of(context, rootNavigator: true).pop();
      if (app == "whatsapp") {
        _openWhatsApp('+31 620 699903');
      } else {
        _openTelegram('+31 620 699903');
      }
    },
  );

  // set up the SimpleDialog
  SimpleDialog dialog = SimpleDialog(
    title: const Text('Choose a number'),
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

showContentAlertDialog(BuildContext context, String title, String content) {
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext ctx) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text('Ok'),
          )
        ],
      );
    },
  );
}
