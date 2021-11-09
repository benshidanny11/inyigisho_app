import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:inyigisho_app/constants/apis.dart';
import '../models/videolesson.dart';

class VideoItem extends StatelessWidget {

  final VideoLesson videoLesson;

  const VideoItem(this.videoLesson);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        margin: const EdgeInsets.all(7.0),
        decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 5.0,
                spreadRadius: 0.3,
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
                Padding(padding: const EdgeInsets.fromLTRB(12.0, 2.0, 12.0, 2.0),
                    child: Image.network(AppApi.getVideoThumbnail(YoutubePlayer.convertUrlToId(videoLesson.videoUrl).toString()), width: 100, height: 100))
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 2.0, 12.0, 2.0),
                  child: Text(
                    videoLesson.posterName,
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}