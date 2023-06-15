import 'dart:io';

import 'package:flutter/material.dart';
import 'package:inyigisho_app/widgets/dialog.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:easy_localization/src/public_ext.dart';

class IbikorwaByubumuntu extends StatelessWidget {
  const IbikorwaByubumuntu({Key? key}) : super(key: key);

  void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(

          children: [
            Text(
                "umutamenwa-description".tr(),
                 style: TextStyle(
                  color: Colors.grey[700],
                  shadows: [Shadow(color: Colors.grey[100] as Color)],
                  fontSize: 16),),
            SizedBox(
              height: 5,
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.blue[700],
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 20),
                    textStyle: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                child: Text('Isubiza ijambo'),
                onPressed: () {
                  showContentAlertDialog(context, 'get-word'.tr(),
                      "get-your-word-description".tr());
                },
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.blue[700],
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 20),
                    textStyle: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                child: Text('Join Umutamenwa'),
                onPressed: () {
                  launchURL("https://umutamenwa.com/");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
