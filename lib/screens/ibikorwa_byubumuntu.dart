import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class IbikorwaByubumuntu extends StatelessWidget {
  const IbikorwaByubumuntu({Key? key}) : super(key: key);

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
          margin: EdgeInsets.all(25),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Colors.blue[700],
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                textStyle:
                const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            child: Text('Imishinga'),
            onPressed: () {
              launchURL("http://ejomultimedia.org/projects");
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
            child: Text('Adoption'),
            onPressed: () {
              launchURL("http://ejomultimedia.org/adoption");
            },
          ),
        )
      ],
    );
  }
}
