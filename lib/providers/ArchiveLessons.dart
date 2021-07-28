import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:inyigisho_app/constants/apis.dart';
import 'package:inyigisho_app/models/Leason.dart';

class ArchiveLessons with ChangeNotifier {
  List<Leason> _arciveItems = [];

  List<Leason> get archiveItems {
    return [..._arciveItems];
  }

  Future<void> fetchLasons(String month, String year) async {
    try {
      final response =
          await http.get(Uri.parse(AppApi.getArchiveApi(month, year)));
      final Map<String, dynamic>? extractedData =
          json.decode(response.body) as Map<String, dynamic>;

      if (extractedData == null) {
        _arciveItems = [];
        return;
      }
      var decodedLeasons = extractedData['lesons'] as List<dynamic>;
      print('Type:${decodedLeasons.runtimeType}');
      final List<Leason> loadedLeasons = [];
      decodedLeasons.forEach((leason) {
        print(leason['id']);
        loadedLeasons.add(Leason(
            id: int.parse(leason['id']),
            title: leason['title'],
            audionUrl: leason['audio_url'],
            description: leason['leason_description'],
            doneOn: leason['done_on'],
            featureImageUrl: '${AppApi.ROOT_API}${leason['featureimage_url']}',
            posterName: leason['posted_by']));
      });

      _arciveItems = loadedLeasons;
      notifyListeners();
    } catch (error) {
      _arciveItems = [];
      print(error);
      throw (error);
    }
  }
}
