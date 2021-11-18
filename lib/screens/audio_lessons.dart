import 'package:flutter/material.dart';
import 'package:inyigisho_app/items/leasonitem.dart';
import 'package:inyigisho_app/providers/Leasons.dart';
import 'package:provider/provider.dart';

class AudioLessonsScreen extends StatefulWidget {
  @override
  _LessonsState createState() => _LessonsState();
}

class _LessonsState extends State<AudioLessonsScreen> {
  bool _isInit = true;
  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Leasons>(context).fetchLasons().then((_) {
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
    if (Provider.of<Leasons>(context).items.length > 0) {
      setState(() {});
    }
    super.didChangeDependencies();
  }

  void handleSearch(String value) {

    setState(() {
      Provider.of<Leasons>(context,listen: false).searchLeason(value);
    });

  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    final leasonData = Provider.of<Leasons>(context);

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
              : leasonData.foundItems.length > 0
                  ? Container(
                      height: screenHeight * 0.7,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return LeasonItem(leasonData.foundItems[index]);
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
