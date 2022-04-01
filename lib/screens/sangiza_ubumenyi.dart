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
            "Tanga Amakuru (Contact Us)",
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
        Divider(),
        SizedBox(
          height: 5,
        ),
        Padding(padding: EdgeInsets.all(10),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  openEmail();
                },
                child: ContactItem(
                  label: Strings.EMAIL,
                  icon: Icons.email,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              GestureDetector(
                onTap: () {
                  launchURL('tel:+31620699903');
                },
                child: ContactItem(
                  label: Strings.PHONE_NUMBER,
                  icon: Icons.phone,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              GestureDetector(
                onTap: () {
                  launchURL("https://www.umuhuza-iwacu.org");
                },
                child: ContactItem(
                  label: Strings.WEB_SITE,
                  icon: FontAwesomeIcons.weebly,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              GestureDetector(
                onTap: () {
                  showAlertDialog(context, "whatsapp");
                },
                child: ContactItem(
                  label: Strings.WHATSTAPP,
                  icon: FontAwesomeIcons.whatsapp,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              GestureDetector(
                onTap: () {
                  launchURL("https://facebook.com/umuhuza");
                },
                child: ContactItem(
                  label: Strings.FACEBOOK,
                  icon: Icons.facebook,
                ),
              ),
              GestureDetector(
                onTap: () {
                  launchURL("https://instagram.com/umuhuza");
                },
                child: ContactItem(
                  label: Strings.INSTAGRAM,
                  icon: FontAwesomeIcons.instagram,
                ),
              ),
              GestureDetector(
                onTap: () {
                  launchURL("https://twitter.com/umuhuza");
                },
                child: ContactItem(
                  label: Strings.TWITER,
                  icon: FontAwesomeIcons.twitter,
                ),
              ),
            ],
          ),)
      ],
    );
  }
}
