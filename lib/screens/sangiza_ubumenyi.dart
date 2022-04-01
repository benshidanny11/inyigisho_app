import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:inyigisho_app/constants/strings.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inyigisho_app/widgets/contactItem.dart';
import 'package:inyigisho_app/widgets/dialog.dart';
import 'package:url_launcher/url_launcher.dart';

class SangizaUbumenyi extends StatelessWidget {
  const SangizaUbumenyi({Key? key}) : super(key: key);

  void launchURL(String url) async {
    if (await canLaunch(url)){
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 10),
          child: Text(
            "Sangiza Ubumenyi (Contact Us)",
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 15,
                fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 2,
        ),
        Column(
          children: [
            Container(
              margin: EdgeInsets.all(25),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.blue[700],
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    textStyle:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                child: Text('Tanga Ubumenyi'),
                onPressed: () {
                  showPlatformDialog(context);
                },
              ),
            ),
            Container(
              margin: EdgeInsets.all(25),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.blue[700],
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    textStyle:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                child: Text('Tanga Amakuru'),
                onPressed: () {
                  showPlatformDialog(context);
                },
              ),
            )
          ],
        ),
      ],
    );
  }
}
