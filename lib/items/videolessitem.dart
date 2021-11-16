import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:inyigisho_app/extracteddata/ExtractedStrings.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'package:inyigisho_app/constants/apis.dart';
import 'package:inyigisho_app/constants/routes.dart';
import 'package:inyigisho_app/models/videolesson.dart';

class VideoLessonItem extends StatelessWidget {
  final VideoLesson lesson;
  const VideoLessonItem(this.lesson);

  void _handleItemClick(BuildContext context) {
    ExtractedStrings.YOUTUBE_URL = lesson.videoUrl;
    Navigator.of(context).pushNamed(RouteConstants.VideoLessonDetailsRoute, arguments: lesson.id);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _handleItemClick(context);
      },
      child: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(50)),
                    child: Stack(children: [
                      Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(AppApi.getVideoThumbnail(YoutubePlayer.convertUrlToId(lesson.videoUrl).toString())),
                            ),
                          )),
                      Positioned(
                        child: Icon(
                          Icons.play_circle,
                          color: Colors.grey[100],
                          size: 20,
                        ),
                        top: 32,
                        left: 32,
                      ),
                      Positioned(
                          bottom: 2,
                          child: Container(
                            width: 80,
                            padding: EdgeInsets.all(5),
                            color: Colors.black38,
                            child: Text(
                              'By ${lesson.posterName}',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 9),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ))
                    ]),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        lesson.title.toUpperCase(),
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        lesson.description,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.grey[600], fontSize: 15),
                      ),
                    ],
                  )),
                ],
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Badge(
                  position: BadgePosition.topEnd(top: 2, end: 2),
                  badgeContent: Text(
                    lesson.commentCount.toString(),
                    style: TextStyle(color: Colors.white, fontSize: 9),
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.message,
                      color: Theme.of(context).primaryColor,
                    ),
                    onPressed: () {},
                  ),
                  badgeColor: Theme.of(context).accentColor,
                ),
                Container(
                    margin: EdgeInsets.only(left: 20, right: 10),
                    child: Text(
                      lesson.doneOn,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Theme.of(context).primaryColor, fontSize: 12),
                    ))
              ],
            ),
            Divider()
          ],
        ),
      ),
    );
  }
}