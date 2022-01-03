import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:inyigisho_app/constants/strings.dart';
import 'package:inyigisho_app/widgets/contactItem.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class ClubIwacu extends StatelessWidget {
  const ClubIwacu({Key? key}) : super(key: key);

  void launchURL(String url) async {
    if (await canLaunch(url)){
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<bool> showFingerprintAuth(BuildContext context) async {
    try {
      var localAuth = LocalAuthentication();
      return await localAuth.authenticate(localizedReason: 'authenticate_prompt'.tr(), stickyAuth: true);
    } on Exception catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('biometric'.tr()),
      ));
      return false;
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
            child: Text('explanation'.tr()),
            onPressed: () {
              showFingerprintAuth(context).then((successful) {
                if(successful){
                  launchURL("https://inyigisho.com");
                }
              });
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
            child: Text('learning'.tr()),
            onPressed: () {
              showFingerprintAuth(context).then((successful) {
                if(successful){
                  launchURL("https://inyigisho.com");
                }
              });
            },
          ),
        )
      ],
    );
  }
}
