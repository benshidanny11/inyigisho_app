import 'dart:io';

import 'package:flutter/material.dart';
import 'package:inyigisho_app/widgets/dialog.dart';
import 'package:url_launcher/url_launcher.dart';

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
                "Umutamenwa ni Ububiko bushinganye bwagenewe kubika ubuziraherezo ibyangombwa, ubuhamya cyangwa ibimenyetso byumutungo wimukanwa n'utimukanwa, ndetse n'umutungo kamere w'iguhugu. Ibi bikorwa hagamijwe kwimakaza Umuco w'ubutabera, no kurandura ingeso yo kuvogera uburenganzira bw'abaturage no gucaingeso gusahura ibya Rubanda.",
                 style: TextStyle(
                  color: Colors.grey[700],
                  shadows: [Shadow(color: Colors.grey[100] as Color)],
                  fontSize: 16),),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.all(25),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.blue[700],
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 20),
                    textStyle: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                child: Text('Isubize ijambo'),
                onPressed: () {
                  showContentAlertDialog(context, 'Isubize ijambo',
                      "Ubwenge kamere bwo kumenya ikibi n’ikiza hamwe n’Ijambo rishobora gusenya cyangwa rikubaka umutamenwa, ni ibintu bibiri bikomeye Imana yaremanye Umuntu. Iyo umuntu anyazwe uburenganzira bwo gutekereza no kuvuga icyo ashaka, aba anyazwe Ubumuntu bwe! Kubera iyo mpamvu “Isubize ijambo”, ni igikorwa kigamije guha urubuga rusesuye umunyagihugu wese akavuga ikimuri kumutima, cyaba ari ikibazo, kigahita gishakirwa umuti urambye, kitaratera ingaruka kubuzima bwa nyiracyo n’ubwigihugu muri rusange.");
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.all(25),
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
