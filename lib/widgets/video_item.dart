import 'package:flutter/material.dart';
import 'package:inyigisho_app/constants/apis.dart';
import 'package:inyigisho_app/constants/routes.dart';
import 'package:inyigisho_app/extracteddata/ExtractedStrings.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../models/videolesson.dart';

class VideoItem extends StatelessWidget {

  final VideoLesson videoLesson;

  const VideoItem(this.videoLesson);

  void _handleItemClick(BuildContext context) {
    ExtractedStrings.YOUTUBE_URL = videoLesson.videoUrl;
    Navigator.of(context).pushNamed(RouteConstants.VideoLessonDetailsRoute, arguments: videoLesson.id);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: (){
          _handleItemClick(context);
        },
        child: Material(
          child: Container(
            margin: const EdgeInsets.all(7.0),
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 3.0,
                    spreadRadius: 0.1,
                  ),
                ]
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    ClipRRect(borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), bottomLeft: Radius.circular(10.0)),
                      child: FadeInImage.assetNetwork(
                          placeholder: 'assets/images/loading.gif', // Before image load
                          image: AppApi.getVideoThumbnail(YoutubePlayer.convertUrlToId(videoLesson.videoUrl).toString()), // After image load
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover
                      ),
                    )],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12.0, 2.0, 12.0, 2.0),
                      child: Text(
                        videoLesson.title,
                        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 2.0),
                      child: Text(
                        videoLesson.description,
                        style: TextStyle(fontSize: 15.0),
                        maxLines: 2,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12.0, 2.0, 12.0, 2.0),
                      child: Text(
                        "by " + videoLesson.posterName + " • " + videoLesson.doneOn,
                        style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w300),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
    );
  }
}