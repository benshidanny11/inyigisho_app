import 'package:flutter/material.dart';
import 'package:inyigisho_app/widgets/video_item.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/src/public_ext.dart';
import '../providers/videolessons.dart';

class VideoList extends StatefulWidget {
  const VideoList({Key? key}) : super(key: key);

  @override
  State<VideoList> createState() => _VideoListState();
}

class _VideoListState extends State<VideoList>
    with AutomaticKeepAliveClientMixin<VideoList> {
  @override

  bool _isInit = true;
  bool _isLoading = false;

  @override
  bool get wantKeepAlive => true;

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

  @override
  Widget build(BuildContext context) {
    final lessonData = Provider.of<VideoLessons>(context);
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : lessonData.foundItems.length > 0
            ? Container(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return VideoItem(lessonData.foundItems[index]);
                  },
                  itemCount: lessonData.foundItems.length,
                  shrinkWrap: true,
                ),
              )
            : Center(
                child: Text('no_data'.tr()),
              );
  }
}
