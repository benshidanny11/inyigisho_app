import 'package:flutter/material.dart';
import 'package:inyigisho_app/items/videolessitem.dart';
import 'package:inyigisho_app/providers/videolessons.dart';
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


  @override
  Widget build(BuildContext context) {

    double screenHeight = MediaQuery.of(context).size.height;
    final leasonData = Provider.of<VideoLessons>(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: screenHeight * .12,
            padding: EdgeInsets.all(10),
            child: Card(
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Search here",
                  contentPadding:
                      EdgeInsets.only(top: 20), // add padding to adjust text
                  isDense: true,
                  prefixIcon: Padding(
                    padding:
                        EdgeInsets.only(top: 15), // add padding to adjust icon
                    child: Icon(Icons.search),
                  ),
                ),
                onChanged: (value) {
                 // handleSearch(value);
                },
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          _isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : leasonData.foundItems.length > 0
                  ? Container(
                      height: screenHeight * 0.7,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return VideoLessonItem(leasonData.foundItems[index]);
                        },
                        itemCount: leasonData.foundItems.length,
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