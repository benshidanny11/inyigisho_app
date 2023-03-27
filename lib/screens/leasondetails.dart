import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:inyigisho_app/constants/apis.dart';
import 'package:inyigisho_app/constants/strings.dart';
import 'package:inyigisho_app/providers/Leasons.dart';
import 'package:inyigisho_app/providers/comments.dart';
import 'package:inyigisho_app/widgets/postcomment.dart';
import 'package:provider/provider.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:share_plus/share_plus.dart';

class LeasonDatails extends StatefulWidget {
  const LeasonDatails({Key? key}) : super(key: key);

  @override
  _LeasonDatailsState createState() => _LeasonDatailsState();
}

class _LeasonDatailsState extends State<LeasonDatails> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  AudioPlayer audioPlayer = AudioPlayer();
  PlayerState audioPlayerState = PlayerState.PAUSED;
  int timeProgress = 0;
  int audioDuration = 0;
  String playingState = "";
  String viewCommentsLabel = 'view_comments'.tr();

  bool isLoadingComments = false;
  bool isCommentsShown = false;

  Widget slider() {
    return Container(
      width: 300.0,
      child: Slider.adaptive(
          value: timeProgress.toDouble(),
          max: audioDuration.toDouble(),
          onChanged: (value) {
            seekToSec(value.toInt());
          }),
    );
  }

  /// Compulsory
  playMusic(String url) async {
    // Add the parameter "isLocal: true" if you want to access a local file
    setState(() {
      playingState = "loading";
    });
    await audioPlayer.play(url);
    setState(() {
      playingState = "playing";
    });
  }

  /// Compulsory
  pauseMusic() async {
    await audioPlayer.pause();
  }

  /// Optional
  void seekToSec(int sec) {
    Duration newPos = Duration(seconds: sec);
    audioPlayer.seek(newPos); // Jumps to the given position within the audio file
  }

  /// Optional
  String getTimeString(int seconds) {
    String minuteString =
        '${(seconds / 60).floor() < 10 ? 0 : ''}${(seconds / 60).floor()}';
    String secondString = '${seconds % 60 < 10 ? 0 : ''}${seconds % 60}';
    return '$minuteString:$secondString'; // Returns a string with the format mm:ss
  }

  @override
  void initState() {
    super.initState();

    /// Compulsory
    audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      if (mounted) {
        setState(() {
          audioPlayerState = state;
        });
      }
    });
    Provider.of<Comments>(context, listen: false).emptyCommentsForInit();
  }

  /// Compulsory
  @override
  void dispose() {
    audioPlayer.release();
    audioPlayer.dispose();

    super.dispose();
  }

  void loadComments(BuildContext ctx, int lessId, int commentCount) async {
    if (commentCount == 0) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('no_comments'.tr()),
      ));
    } else {
      if (viewCommentsLabel.compareTo('view_comments'.tr()) == 0) {
        setState(() {
          isLoadingComments = true;
        });
        await Provider.of<Comments>(ctx, listen: false).fetchComments(lessId,Strings.LESS_TYPE_AUDIO);
        setState(() {
          isLoadingComments = false;
          viewCommentsLabel = 'hide_comments'.tr();
        });
      } else {
        setState(() {
          viewCommentsLabel = 'view_comments'.tr();
        });
        Provider.of<Comments>(ctx, listen: false).emptyComments();
      }
    }
  }

  void addCommentHandler(BuildContext ctx, String name, String comment, int lessonId) async {
    Provider.of<Comments>(context, listen: false)
        .addComment(name, comment, lessonId,Strings.LESS_TYPE_AUDIO)
        .then((_) {
      setState(() {
        Provider.of<Comments>(context, listen: false).emptyComments();
        Provider.of<Leasons>(context, listen: false)
            .findleason(lessonId)
            .commentCount += 1;
      });
      Navigator.of(ctx).pop();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('comment_added'.tr()),
        duration: Duration(seconds: 3),
      ));
    });
  }

  void handleShowCommentBottomSheet(BuildContext ctx, int lessId) {
    scaffoldKey.currentState!.showBottomSheet((context) => PostComment(
          handleAddComment: addCommentHandler,
          lessId: lessId,
        ));
  }

  void _handleShare(String title, String body, String lessonUrl) {
    Share.share('$title\n\n$body\n\n' + 'listen_to_lesson'.tr() + '${AppApi.baseApi}$lessonUrl', subject: title);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final leasonId = ModalRoute.of(context)!.settings.arguments as int;

    final loadedLeason = Provider.of<Leasons>(
      context,
      listen: false,
    ).findleason(leasonId);

    final commentData = Provider.of<Comments>(context);

    /// Optional
    audioPlayer.setUrl(
        '${AppApi.baseApi}${loadedLeason.audionUrl}'); // Triggers the onDurationChanged listener and sets the max duration string
    audioPlayer.onDurationChanged.listen((Duration duration) {
      setState(() {
        audioDuration = duration.inSeconds;
      });
    });
    audioPlayer.onAudioPositionChanged.listen((Duration position) async {
      setState(() {
        timeProgress = position.inSeconds;
      });
    });

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Inyigisho on ${loadedLeason.doneOn}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                    height: 250,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(loadedLeason.featureImageUrl),
                      ),
                    )),
                Positioned(
                    bottom: 5,
                    left: 2,
                    child: Container(
                      width: screenWidth,
                      padding: const EdgeInsets.all(5),
                      color: Colors.black38,
                      child: Text(
                        'uploaded_by'.tr() + loadedLeason.posterName,
                        style: TextStyle(color: Colors.white, fontSize: 15),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ))
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    loadedLeason.title,
                    style: TextStyle(color: Colors.grey[900], fontSize: 18),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          audioPlayerState == PlayerState.PLAYING
                              ? pauseMusic()
                              : playMusic(
                                  '${AppApi.baseApi}${loadedLeason.audionUrl}');
                        },
                        icon: Icon(
                          playingState == "loading"
                              ? Icons.circle_rounded
                              : audioPlayerState == PlayerState.PLAYING
                                  ? Icons.pause_rounded
                                  : Icons.play_arrow_rounded,
                          color: Theme.of(context).primaryColor,
                          size: 25,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(getTimeString(timeProgress)),
                          SizedBox(width: 20),
                          Container(width: 100, child: slider()),
                          SizedBox(width: 20),
                          Text(getTimeString(audioDuration)),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          _handleShare(loadedLeason.title,
                              loadedLeason.description, loadedLeason.audionUrl);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Icon(
                            Icons.share,
                            color: Theme.of(context).primaryColor,
                            size: 25,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Divider(),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      loadedLeason.description,
                      style: TextStyle(color: Colors.grey[700], fontSize: 16),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          child: Text('$viewCommentsLabel (${loadedLeason.commentCount})'),
                          onPressed: () {
                            loadComments(context, loadedLeason.id,
                                loadedLeason.commentCount);
                          },
                        ),
                        VerticalDivider(
                          width: 2.0,
                          thickness: 2.0,
                          color: Colors.grey[200],
                        ),
                        TextButton.icon(
                            onPressed: () {
                              handleShowCommentBottomSheet(context, leasonId);
                            },
                            icon: Icon(Icons.message_rounded),
                            label: Text('add_comment'.tr()))
                      ],
                    ),
                  ),
                  Divider(),
                  Container(
                    height: screenHeight * .45,
                    child: isLoadingComments
                        ? Align(
                            alignment: Alignment.topCenter,
                            child: CircularProgressIndicator(),
                          )
                        : commentData.items.length > 0
                            ? ListView.builder(
                                itemBuilder: (contex, index) {
                                  return ListTile(
                                    leading: CircleAvatar(
                                      child: Text(commentData
                                          .items[index].userName
                                          .substring(0, 1)),
                                    ),
                                    title:
                                        Text(commentData.items[index].userName),
                                    subtitle: Text(commentData
                                        .items[index].commentContent),
                                    trailing: Text(
                                      commentData.items[index].doneOn,
                                      style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 12),
                                    ),
                                  );
                                },
                                itemCount: commentData.items.length,
                              )
                            : Text(""),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

enum CommentOptions { ShowComment, HideComment }
