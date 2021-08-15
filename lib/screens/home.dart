import 'package:flutter/material.dart';
import 'package:inyigisho_app/providers/Years.dart';
import 'package:inyigisho_app/screens/archives.dart';
import 'package:inyigisho_app/screens/contacts.dart';
import 'package:inyigisho_app/screens/leasons.dart';
import 'package:inyigisho_app/screens/videolessons.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {


  @override
  void initState() {
    super.initState();

    Provider.of<Years>(context, listen: false).fetchYears();
  }

  void _handleShowPopup() {
    showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(25.0, 25.0, 0.0,
          0.0), //position where you want to show the menu on screen
      items: [
        PopupMenuItem<String>(child: const Text('menu option 1'), value: '1'),
        PopupMenuItem<String>(child: const Text('menu option 2'), value: '2'),
        PopupMenuItem<String>(child: const Text('menu option 3'), value: '3'),
      ],
      elevation: 8.0,
    ).then<void>((itemSelected) {
      if (itemSelected == null) return;

      if (itemSelected == "1") {
        //code here
      } else if (itemSelected == "2") {
        //code here
      } else {
        //code here
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length:4,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Inyigisho"),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: GestureDetector(
                  onTap: () { 
                  },
                  child: Icon(Icons.share)),
            )
          ],
             bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(
                  Icons.play_circle,
                ),
                text: 'Video lessons',
              ),
              Tab(
                icon: Icon(
                  Icons.audiotrack,
                ),
                text: 'Audio lessons',
              ),
              Tab(
                icon: Icon(
                  Icons.archive
                ),
                text: 'Archive',
              ),
              Tab(
                icon: Icon(
                  Icons.contact_page,
                ),
                text: 'Contacts',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
           VideoLessonsScreen(),LeasonsScreen(), Archives(), Contacts()
          ],
        ),
      ),
    );
  }
}
