import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:inyigisho_app/constants/apis.dart';
import 'package:url_launcher/url_launcher.dart';

class OneMinute extends StatelessWidget {
  const OneMinute({Key? key}) : super(key: key);

   void launchURL(String url) async {
    if (await canLaunch(url)){
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: Center(child:  ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Colors.blue[700],
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                textStyle:
                const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            child: Text('One minute for africa'),
            onPressed: () {
              launchURL(AppApi.YOUTUBE_LINK);
            },
          ),),);
  }
}