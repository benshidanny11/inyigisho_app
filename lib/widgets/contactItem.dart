import 'package:flutter/material.dart';

class ContactItem extends StatelessWidget {
  final String label;
  final IconData icon;
  const ContactItem({Key? key, this.label="",required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
          height: 80,
          child: Card(
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: 60,
                  color: Theme.of(context).primaryColor,

                ),
                SizedBox(width: 5,),
                Icon(icon),
                SizedBox(width: 10,),
                Text(label)
              ],
            ),
          ),
        );
  }
}
