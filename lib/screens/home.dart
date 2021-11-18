import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:inyigisho_app/constants/strings.dart';
import 'package:inyigisho_app/providers/Years.dart';
import 'package:inyigisho_app/screens/archives.dart';
import 'package:inyigisho_app/screens/contacts.dart';
import 'package:inyigisho_app/screens/audio_lessons.dart';
import 'package:inyigisho_app/screens/videolessons.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(Home());

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

  void _openwhatsapp() async {
    var whatsapp = Strings.PHONE_NUMBER;
    var whatsappURlAndroid = "whatsapp://send?phone=" + whatsapp;
    var whatappURLIos = "https://wa.me/$whatsapp";
    if (Platform.isIOS) {
      await launch(whatappURLIos, forceSafariVC: false);
    } else {
      await launch(whatsappURlAndroid);
    }
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

  ValueNotifier<bool> isDialOpen = ValueNotifier(false);

  Future<bool> _willPopCallback() async {
    if(isDialOpen.value){
      isDialOpen.value = false;
    } else {
      return true;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text("INYIGISHO"),
          backgroundColor: Colors.orange[700],
          centerTitle: true,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: GestureDetector(onTap: () {}, child: Icon(Icons.search)),
            )
          ],
          bottom: TabBar(
            isScrollable: false,
            indicatorWeight: 5,
            indicatorColor: Colors.white,
            labelPadding: EdgeInsets.only(left: 10),
            tabs: <Widget>[
              Tab(
                icon: Icon(
                  Icons.play_circle,
                ),
                text: 'Videos',
              ),
              Tab(
                icon: Icon(
                  Icons.people,
                ),
                text: 'Club\nIwacu',
              ),
              Tab(
                icon: Icon(Icons.share_rounded),
                text: 'Sangiza\nUbumenyi',
              ),
              Tab(
                icon: Icon(
                  Icons.question_answer,
                ),
                text: 'Baza\nImpuguke',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            VideoLessonsScreen(),
            AudioLessonsScreen(),
            VideoLessonsScreen(),
            Contacts()
          ],
        ),
        floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.menu_close,
          openCloseDial: isDialOpen,
          backgroundColor: Colors.orange[700],
          overlayColor: Colors.grey,
          overlayOpacity: 0.5,
          spacing: 15,
          spaceBetweenChildren: 15,
          closeManually: true,
          children: [
            SpeedDialChild(
                child: Icon(Icons.share_rounded),
                label: 'Share',
                backgroundColor: Colors.orange[900],
                onTap: (){
                  print('Share Tapped');
                }
            ),
            SpeedDialChild(
                child: Icon(Icons.speaker_phone),
                label: 'Testimony',
                backgroundColor: Colors.orange[900],
                onTap: (){
                  print('Testimony Tapped');
                }
            ),
            SpeedDialChild(
                child: Icon(Icons.archive),
                label: 'Archive',
                backgroundColor: Colors.orange[900],
                onTap: (){
                  print('Archive Tapped');
                }
            ),
            SpeedDialChild(
                child: Icon(Icons.contact_page_rounded),
                label: 'Contact Us',
                backgroundColor: Colors.orange[900],
                onTap: (){
                  print('Contact Us Tapped');
                }
            ),
          ],
        ),
      ),
    ), onWillPop: _willPopCallback );
  }
}