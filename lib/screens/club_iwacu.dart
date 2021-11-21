import 'package:flutter/material.dart';
import 'package:inyigisho_app/constants/strings.dart';
import 'package:inyigisho_app/widgets/contactItem.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ClubIwacu extends StatelessWidget {
  const ClubIwacu({Key? key}) : super(key: key);

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
            onPressed: () {},
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
            onPressed: () {},
          ),
        )
      ],
    );
  }
}
