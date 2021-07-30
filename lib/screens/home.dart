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
  List<Widget> pages = [VideoLessonsScreen(),LeasonsScreen(), Archives(), Contacts()];

  int _currentPage = 0;

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
    return Scaffold(
      appBar: AppBar(
        title: Text("Inyigisho"),
        actions: [
          GestureDetector(
              onTap: () {
                _handleShowPopup();
              },
              child: Icon(Icons.share))
        ],
      ),
      body: pages[_currentPage],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.play_circle),label: 'Video lessons'),
          BottomNavigationBarItem(icon: Icon(Icons.audiotrack),label: 'Audios lessons'),
          BottomNavigationBarItem(icon: Icon(Icons.archive), label: 'Archive'),
          BottomNavigationBarItem(
              icon: Icon(Icons.contact_page), label: 'Contacts'),
        ],
        onTap: (index) {
          setState(() {
            _currentPage = index;
          });
        },
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey[600],
        currentIndex: _currentPage,
      ),
    );
  }
}
