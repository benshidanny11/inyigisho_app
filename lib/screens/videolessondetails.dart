import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:inyigisho_app/constants/apis.dart';
import 'package:inyigisho_app/constants/strings.dart';
import 'package:inyigisho_app/extracteddata/ExtractedStrings.dart';
import 'package:inyigisho_app/providers/comments.dart';
import 'package:inyigisho_app/providers/videolessons.dart';
import 'package:inyigisho_app/widgets/postcomment.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class VideoLessonDetails extends StatefulWidget {
  const VideoLessonDetails({Key? key}) : super(key: key);

  @override
  _VideoLessonDetailsState createState() => _VideoLessonDetailsState();
}

class _VideoLessonDetailsState extends State<VideoLessonDetails> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  bool isLoadingComments = false;
  bool isCommentsShown = false;
  String viewCommentsLabel = 'view_comments'.tr();

  //Youtube variables declarations

  YoutubePlayerController? _controller;
  TextEditingController? _idController;
  TextEditingController? _seekToController;

  PlayerState? _playerState;
  YoutubeMetaData? _videoMetaData;
  double _volume = 100;
  bool _muted = false;
  bool _isPlayerReady = false;

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
        await Provider.of<Comments>(ctx, listen: false).fetchComments(lessId,Strings.LESS_TYPE_VIDEO);
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

  void addCommentHandler(
      BuildContext ctx, String name, String comment, int lessonId) async {
    Provider.of<Comments>(context, listen: false)
        .addComment(name, comment, lessonId,Strings.LESS_TYPE_VIDEO)
        .then((_) {
      setState(() {
        Provider.of<Comments>(context, listen: false).emptyComments();
        Provider.of<VideoLessons>(context, listen: false)
            .findleason(lessonId)
            .commentCount += 1;
      });
      Navigator.of(ctx).pop();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            'comment_added'.tr()),
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
    Share.share('$title\n\n$body\n\n' + 'listen_to_lesson'.tr() + '${AppApi.ROOT_API}$lessonUrl', subject: title);
  }

//Init state

  @override
  void initState() {
    super.initState();
   if(mounted){
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(ExtractedStrings.YOUTUBE_URL).toString(),
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(listener);
    _idController = TextEditingController();
    _seekToController = TextEditingController();
    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;
   }
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller!.value.isFullScreen) {
      setState(() {
        _playerState = _controller!.value.playerState;
        _videoMetaData = _controller!.metadata;
      });
    }
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller!.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller!.dispose();
    _idController!.dispose();
    _seekToController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final lessonId = ModalRoute.of(context)!.settings.arguments as int;

    final loadedLesson = Provider.of<VideoLessons>(
      context,
      listen: false,
    ).findleason(lessonId);

    final commentData = Provider.of<Comments>(context);

    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller as YoutubePlayerController,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.blueAccent,
        topActions: <Widget>[
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              _controller!.metadata.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
              size: 25.0,
            ),
            onPressed: () {},
          ),
        ],
        onReady: () {
          _isPlayerReady = true;
        },
      ),
      builder: (contex, player) => Scaffold(
        key: scaffoldKey,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  height: 250,
                  width: double.infinity,
                  child: player),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      loadedLesson.title,
                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "by " + loadedLesson.posterName + " • " + loadedLesson.doneOn,
                      style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w400),
                    ),
                    Divider(),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        loadedLesson.description,
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
                            child: Text(
                                '$viewCommentsLabel (${loadedLesson.commentCount})'),
                            onPressed: () {
                              loadComments(context, loadedLesson.id,
                                  loadedLesson.commentCount);
                            },
                          ),
                          VerticalDivider(
                            width: 2.0,
                            thickness: 2.0,
                            color: Colors.grey[200],
                          ),
                          TextButton.icon(
                              onPressed: () {
                                handleShowCommentBottomSheet(context, lessonId);
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
                                      title: Text(
                                          commentData.items[index].userName),
                                      subtitle: Text(commentData
                                          .items[index].commentContent),
                                      trailing: Text(
                                        commentData.items[index].doneOn,
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
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
      ),
    );
  }
}
