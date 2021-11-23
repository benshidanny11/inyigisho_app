import 'package:flutter/material.dart';
import 'package:inyigisho_app/constants/strings.dart';
import 'package:inyigisho_app/widgets/contactItem.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ClubIwacu extends StatelessWidget {
  const ClubIwacu({Key? key}) : super(key: key);

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
            child: Text('Ubusobanuro'),
            onPressed: () {
              launchURL("https://inyigisho.com");
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
            child: Text('Inyongerabumenyi'),
            onPressed: () {
              launchURL("https://inyigisho.com");
            },
          ),
        )
      ],
    );
  }
}
