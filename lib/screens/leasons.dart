import 'package:flutter/material.dart';
import 'package:inyigisho_app/items/leasonitem.dart';
import 'package:inyigisho_app/providers/Leasons.dart';
import 'package:provider/provider.dart';

class LeasonsScreen extends StatefulWidget {
  @override
  _LeasonsState createState() => _LeasonsState();
}

class _LeasonsState extends State<LeasonsScreen> {
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
       if(mounted){
          setState(() {
          _isLoading = false;
        });
       }
      });
    }
    _isInit = false;
   if( Provider.of<Leasons>(context).items.length>0){
     setState(() {
       
     });
   }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    final leasonData = Provider.of<Leasons>(context);
    
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height:screenHeight*.12,
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
              : leasonData.items.length > 0
                  ? Container(
                      height: screenHeight*0.6,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return LeasonItem(leasonData.items[index]);
                        },
                        itemCount: leasonData.items.length,
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
