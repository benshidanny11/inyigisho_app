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
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          SizedBox(
            height: 2,
          ),
          Column(
            children: [
              Text(
                "youth-festival-descroption".tr(),
                style: TextStyle(
                    color: Colors.grey[700],
                    shadows: [Shadow(color: Colors.grey[100] as Color)],
                    fontSize: 16),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.all(15),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.blue[700],
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 20),
                      textStyle: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  child: Text('Talent expo'),
                  onPressed: () {
                    launchURL(
                        "https://www.umuhuza-iwacu.org/youth-season-events/");
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.all(15),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.blue[700],
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 20),
                      textStyle: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  child: Text('Culture festival'),
                  onPressed: () {
                    launchURL(
                        "https://www.umuhuza-iwacu.org/youth-season-events/");
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
