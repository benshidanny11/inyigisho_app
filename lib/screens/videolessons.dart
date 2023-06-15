import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:inyigisho_app/providers/videolessons.dart';
import 'package:provider/provider.dart';
import '../widgets/dialog.dart';
import '../widgets/one_minute.dart';
import '../widgets/video_list.dart';

class VideoLessonsScreen extends StatefulWidget {
    VideoLessonsScreen({Key? key}) : super(key: key);

  @override
  _VideoLessonsScreenState createState() => _VideoLessonsScreenState();
}

class _VideoLessonsScreenState extends State<VideoLessonsScreen> {
  void handleSearch(String value) {
    setState(() {
      Provider.of<VideoLessons>(context, listen: false).searchLeason(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: Text('TWUBAKE U RWANDA RWAGUTSE', style: TextStyle(
                        color: Colors.grey[700],
                        shadows: [Shadow(color: Colors.grey[100] as Color)],
                        fontSize: 16),
                  ),
              ),
                
              Column(
                children: [
                  TabBar(
                    labelStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                    unselectedLabelColor: Color(0XFF1a1a1a),
                    labelColor: Colors.white,
                    indicator: BubbleTabIndicator(
                      tabBarIndicatorSize: TabBarIndicatorSize.tab,
                      indicatorColor: Colors.blue[700] as Color,
                      indicatorHeight: 30.0,
                      indicatorRadius: 5.0,
                    ),
                    tabs: [
                      Tab(text: 'U Rwanda Rwagutse'),
                      Tab(text: 'One Minute For Africa'),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5.3),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.65,
                      child: Column(
                        children: [
                          Expanded(
                            child: TabBarView(
                              children: [
                                VideoList(),
                                OneMinute(),
                              ],
                            ),
                          ),
                          Container(
                            height:  MediaQuery.of(context).size.height * 0.12,
                            margin: EdgeInsets.only(bottom: 15),
                            child: Column(
                              children: [
                                Divider(
                                  thickness: 2,
                                  color: Color(0xFFDCDCDC),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        openEmail();
                                      },
                                      child: Icon(
                                        Icons.email,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        showAlertDialog(context, "whatsapp");
                                      },
                                      child: Icon(
                                        FontAwesomeIcons.whatsapp,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        showAlertDialog(context, "telegram");
                                      },
                                      child: Icon(
                                        FontAwesomeIcons.telegram,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
