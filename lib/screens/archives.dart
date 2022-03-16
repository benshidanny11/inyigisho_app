import 'package:flutter/material.dart';
import 'package:inyigisho_app/items/leasonitem.dart';
import 'package:inyigisho_app/providers/ArchiveLessons.dart';
import 'package:inyigisho_app/providers/Years.dart';
import 'package:provider/provider.dart';

class Archives extends StatefulWidget {
  Archives({Key? key}) : super(key: key);

  @override
  _ArchivesState createState() => _ArchivesState();
}

class _ArchivesState extends State<Archives> {
  List<DropdownMenuItem<MonthOption>> _months = [];

  MonthOption? _defaultMonth;
  String _defaultYear = "";
  bool _isInit = true;
  bool _isLoading = false;
  static final DateTime now = DateTime.now();

  @override
  void initState() {
    super.initState();
    if (mounted) {
      setState(() {
        _defaultYear = now.year.toString();
      });

      List<MonthOption> months = MonthOption.allMonths;

      // Initialise your items only once
      _months = months.map<DropdownMenuItem<MonthOption>>(
        (MonthOption monthOption) {
          return DropdownMenuItem<MonthOption>(
            value: monthOption,
            child: Text(monthOption.monName),
          );
        },
      ).toList();

      // Initialiste your dropdown with the first country in the list
      // (might be different in your specific scenario)
      _defaultMonth = months[0];
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    var now = new DateTime.now();
    int currentMon = now.month;
   
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<ArchiveLessons>(context)
          .fetchLasons(currentMon.toString(), now.year.toString())
          .then((_) {
        setState(() {
          _isLoading = false;
        });
      }).catchError((err){
         setState(() {
          _isLoading = false;
        });
      });
      _isInit = false;
    }
  }

  void _handleFetchArchives(String year, String month) {
    setState(() {
      _isLoading = true;
    });
    Provider.of<ArchiveLessons>(context, listen: false)
        .fetchLasons(month, year)
        .then((_) {
      setState(() {
        _isLoading = false;
      });
    }).catchError((error) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final years = Provider.of<Years>(context).yearItems;

    final lessonData = Provider.of<ArchiveLessons>(context);
    double screenHeight = MediaQuery.of(context).size.height;

    return Material(
      child: Container(
        child: Column(
          children: [
            AppBar(
              title: Text("Archives"),
              automaticallyImplyLeading: false,
              leading: Navigator.canPop(context)
                  ? IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () => Navigator.of(context).pop(),
              )
                  : null,
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  width: screenWidth * .35,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                    border: Border.all(
                      color: Colors.grey[300] as Color,
                      width: 0.7,
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      menuMaxHeight: 300,
                      value: _defaultYear,
                      items: years
                          .map((year) => DropdownMenuItem(
                        child: Text(year),
                        value: year,
                      ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _defaultYear = value.toString();
                        });
                      },
                      hint: Text("Select year"),
                    ),
                  ),
                ),
                Container(
                  width: screenWidth * .35,
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                    border: Border.all(
                      color: Colors.grey[300] as Color,
                      width: 0.7,
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<MonthOption>(
                      menuMaxHeight: 300,
                      value: _defaultMonth,
                      isExpanded: true,
                      items: _months,
                      onChanged: (value) {
                        setState(() {
                          _defaultMonth = value;
                        });
                      },
                      hint: Text("Select month"),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _handleFetchArchives(_defaultYear, _defaultMonth!.monKey);
                  },
                  child: Icon(
                    Icons.search,
                    size: 35,
                    color: Theme.of(context).primaryColor,
                  ),
                )
              ],
            ),
            Divider(),
            SizedBox(
              height: 5,
            ),
            _isLoading
                ? Center(
              child: CircularProgressIndicator(),
            )
                : lessonData.archiveItems.length > 0
                ? Container(
              height: screenHeight * 0.6,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return LeasonItem(lessonData.archiveItems[index]);
                },
                itemCount: lessonData.archiveItems.length,
              ),
            )
                : Center(
              child: Text("No data found"),
            )
          ],
        ),
      ),
    );
  }
}

class MonthOption {
  final String monKey;
  final String monName;

  MonthOption(this.monKey, this.monName);

  static List<MonthOption> get allMonths => [
        MonthOption('1', 'January'),
        MonthOption('2', 'February'),
        MonthOption('3', 'March'),
        MonthOption('4', 'April'),
        MonthOption('5', 'May'),
        MonthOption('6', 'June'),
        MonthOption('7', 'July'),
        MonthOption('8', 'August'),
        MonthOption('9', 'September'),
        MonthOption('10', 'October'),
        MonthOption('11', 'November'),
        MonthOption('12', 'December'),
      ];
}
