import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:inyigisho_app/constants/apis.dart';

import 'package:inyigisho_app/models/Leason.dart';

class Leasons with ChangeNotifier {
  List<Leason> _items = [];
  List<Leason> _foundItems = [];

  Future<void> fetchLasons() async {
    try {
      final response = await http.get(Uri.parse(AppApi.LEASONS_API));
      final Map<String, dynamic>? extractedData =
          json.decode(response.body) as Map<String, dynamic>;
      final List<Leason> loadedLeasons = [];
      if (extractedData == null) {
        _items = [];

        return;
      }

      var decodedLeasons = extractedData['lesons'] as List<dynamic>;
      print('Type:${decodedLeasons.runtimeType}');

      decodedLeasons.forEach((leason) {
        loadedLeasons.add(Leason(
            id: int.parse(leason['id']),
            title: leason['title'],
            audionUrl: leason['audio_url'],
            description: leason['leason_description'],
            doneOn: leason['done_on'],
            featureImageUrl: '${AppApi.LEASONS_API}${leason['featureimage_url']}',
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

  List<Leason> get items {
    return [..._items];
  }

  List<Leason> get foundItems {
    //_foundItems = _items;

    return [..._foundItems];
  }

  Leason findleason(int id) {
    return _items.firstWhere((leason) => leason.id == id);
  }

  void searchLeason(String enteredKeyword) {
    List<Leason> results = [];
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
    print(foundItems);
    notifyListeners();
  }
}
