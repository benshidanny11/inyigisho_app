import 'package:flutter/material.dart';
import 'package:inyigisho_app/providers/Years.dart';
import 'package:inyigisho_app/screens/archives.dart';
import 'package:inyigisho_app/screens/contacts.dart';
import 'package:inyigisho_app/screens/leasons.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> pages = [LeasonsScreen(), Archives(), Contacts()];

  int _currentPage = 0;

  @override
  void initState() {
    super.initState();

    Provider.of<Years>(context,listen: false).fetchYears();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Inyigisho"),
      ),
      body: pages[_currentPage],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
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
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentPage,
      ),
    );
  }
}
