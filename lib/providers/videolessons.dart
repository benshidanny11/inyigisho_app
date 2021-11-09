import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:inyigisho_app/constants/apis.dart';

import 'package:inyigisho_app/models/videolesson.dart';



class VideoLessons with ChangeNotifier{


 List<VideoLesson> _items = [];
  List<VideoLesson> _foundItems = [];

    List<VideoLesson> get items {
    return [..._items];
  }

  List<VideoLesson> get foundItems {
    //_foundItems = _items;

    return [..._foundItems];
  }


  Future<void> fetchLasons() async {
    try {
      final response = await http.get(Uri.parse(AppApi.VIDEO_LESSONS_API));
      final Map<String, dynamic>? extractedData =
          json.decode(response.body) as Map<String, dynamic>;
      final List<VideoLesson> loadedLeasons = [];
      if (extractedData == null) {
        _items = [];

        return;
      }

      var decodedLeasons = extractedData['videolesons'] as List<dynamic>;
 

      decodedLeasons.forEach((leason) {
        print(leason['id']);
        loadedLeasons.add(VideoLesson(
            id: int.parse(leason['id']),
            title: leason['title'],
            videoUrl: leason['video_url'],
            description: leason['description'],
            doneOn: leason['done_on'],
            posterName: leason['posted_by'],
            commentCount: int.parse(leason['comment_count'])));
      });

      _items = loadedLeasons;
      _foundItems = _items;
      notifyListeners();
    } catch (error) {
      _items = [];
      print(error);
      throw (error);
    }
  }

   VideoLesson findleason(int id) {
    return _items.firstWhere((leason) => leason.id == id);
  }

    void searchLeason(String enteredKeyword) {
    List<VideoLesson> results = [];
    if (enteredKeyword.isEmpty) {
      results = _items;
    } else {
      results = _items
          .where((leason) => leason.title
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

  
    _foundItems = [];
    _foundItems = results;
    notifyListeners();
  }
  
}