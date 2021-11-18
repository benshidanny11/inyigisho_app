import 'package:flutter/material.dart';
import 'package:inyigisho_app/items/videolessitem.dart';
import 'package:inyigisho_app/providers/videolessons.dart';
import 'package:inyigisho_app/widgets/video_item.dart';
import 'package:provider/provider.dart';

class VideoLessonsScreen extends StatefulWidget {

  VideoLessonsScreen({ Key? key }) : super(key: key);

  @override
  _VideoLessonsScreenState createState() => _VideoLessonsScreenState();
}

class _VideoLessonsScreenState extends State<VideoLessonsScreen> {
  bool _isInit = true;
  bool _isLoading = false;

    @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<VideoLessons>(context).fetchLasons().then((_) {
        setState(() {
          _isLoading = false;
        });
      }).catchError((onError) {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
    _isInit = false;
    if (Provider.of<VideoLessons>(context).items.length > 0) {
      setState(() {});
    }
    super.didChangeDependencies();
  }

  void handleSearch(String value) {

    setState(() {
      Provider.of<VideoLessons>(context,listen: false).searchLeason(value);
    });

  }


  @override
  Widget build(BuildContext context) {

    double screenHeight = MediaQuery.of(context).size.height;
    final lessonData = Provider.of<VideoLessons>(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          _isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : lessonData.foundItems.length > 0
                  ? Container(
                      height: screenHeight * 0.7,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return VideoItem(lessonData.foundItems[index]);
                        },
                        itemCount: lessonData.foundItems.length,
                      ),
                    )
                  : Center(
                      child: Text("No data found"),
                    )
        ],
      ),
    );
  }
}