import 'package:flutter/material.dart';
import 'package:inyigisho_app/constants/strings.dart';
import 'package:inyigisho_app/widgets/contactItem.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Contacts extends StatelessWidget {
  const Contacts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 10),
          child: Text(
            "Feel free to contact us",
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 15,
                fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 2,
        ),
        Divider(),
        SizedBox(
          height: 5,
        ),
        Padding(padding: EdgeInsets.all(10),
        child: Column(
          children: [
             ContactItem(
          label: Strings.EMAIL,
          icon: Icons.email,
        ),
        SizedBox(
          height: 5,
        ),
        ContactItem(
          label: Strings.PHONE_NUMBER,
          icon: Icons.phone,
        ),
        SizedBox(
          height: 5,
        ),
        ContactItem(
          label: Strings.WEB_SITE,
          icon: FontAwesomeIcons.weebly,
        ),
        SizedBox(
          height: 5,
        ),
        ContactItem(
          label: Strings.WHATSTAPP,
          icon: FontAwesomeIcons.whatsapp,
        ),
        SizedBox(
          height: 5,
        ),
        ContactItem(
          label: Strings.FACEBOOK,
          icon: Icons.facebook,
        ),
        ContactItem(
          label: Strings.INSTAGRAM,
          icon: FontAwesomeIcons.instagram,
        ),
        ContactItem(
          label: Strings.TWITER,
          icon: FontAwesomeIcons.twitter,
        ),
          ],
        ),)
      ],
    );
  }
}
