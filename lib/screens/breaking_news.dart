import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BreakingNews extends StatelessWidget {
  const BreakingNews({Key? key}) : super(key: key);
  
  void launchURL(String url) async {
    if (await canLaunch(url)){
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
           Text(
                  "Ni ikigo k'igihugu gifite icyerekezo n'inshingano byo kuba umusingi mu kunagura no Kubaka igihugu kibereye abanyagihugu bose, binyuze mu guhuza imbaraga zabo z'ingeri zose (Ubumenyi, Ubunararibonye, Ibikorwa n'Impano...). Ibyo bigakorwa hagamijwe kugera ku gihugu cy'abantu bunze ubumwe baharanira uburumbuke n'iterambere rirambye, mu Rwanda no mu karere u Rwanda ruherereyemo.",
                   style: TextStyle(
                  color: Colors.grey[700],
                  shadows: [Shadow(color: Colors.grey[100] as Color)],
                  fontSize: 16),),
                  SizedBox(height: 10,),
                 Container(
            margin: EdgeInsets.all(25),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.blue[700],
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  textStyle:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              child: Text('The nation academy'),
              onPressed: () {
                launchURL("https://www.dreams-platform.com/");
              },
            ),
          ),
        ],
      ),
    );
  }
}
