import 'dart:io';

import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:inyigisho_app/constants/strings.dart';
import 'package:inyigisho_app/widgets/contactItem.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inyigisho_app/widgets/dialog.dart';

class BazaImpuguke extends StatelessWidget {
  const BazaImpuguke({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                  showAlertDialog(context, "telegram");
                },
                child: ContactItem(
                  label: "Telegram",
                  icon: FontAwesomeIcons.telegram,
                ),
              ),
            ],
          ),)
      ],
    );
  }
}
