import 'package:flutter/material.dart';
import 'package:inyigisho_app/models/videolesson.dart';
import 'package:inyigisho_app/providers/Leasons.dart';
import 'package:inyigisho_app/providers/videolessons.dart';
import 'package:inyigisho_app/screens/archives.dart';
import 'package:inyigisho_app/screens/contacts.dart';
import 'package:inyigisho_app/screens/videolessons.dart';

void main() => runApp(Home2());

/// This Widget is the main application widget.
class Home2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyNavigationBar (),
    );
  }
}

class MyNavigationBar extends StatefulWidget {
  MyNavigationBar ({Key? key}) : super(key: key);

  @override
  _MyNavigationBarState createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar > {

  List _pages = [
    VideoLessonsScreen(),
    VideoLessonsScreen(),
    Archives(),
    Contacts()
  ];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Inyigisho'),
          backgroundColor: Colors.blue[400]
      ),
      body: Center(
        child: SingleChildScrollView(
            child: _pages.elementAt(_selectedIndex)
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.play_circle),
            label: 'Video',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.audiotrack),
            label: 'Audio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.archive),
            label: 'Archive',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contact_page),
            label: 'Contact',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue[400],
        unselectedItemColor: Colors.grey[600],
        onTap: _onItemTapped,
      ),
    );
  }
}