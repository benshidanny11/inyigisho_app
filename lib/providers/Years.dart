import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:inyigisho_app/constants/apis.dart';

class Years with ChangeNotifier {

  static final DateTime now = DateTime.now();

  List<String> _yearItems = [now.year.toString()];

  List<String> get yearItems {
    return [..._yearItems];
  }

  Future<void> fetchYears() async {
    try {
      final response = await http.get(Uri.parse('${AppApi.YEARS_API}'));

      final List<dynamic>? extractedData =
          json.decode(response.body) as List<dynamic>;

      List<String> loadedYears = [];
      if (extractedData == null) {
        loadedYears = [];
        _yearItems = loadedYears;
        notifyListeners();
        return;
      }

      extractedData.forEach((year) {
        loadedYears.add(year['year'].toString());
      });

      _yearItems = loadedYears;
      notifyListeners();
    } catch (error) {
      _yearItems = [];
      notifyListeners();
      print(error);
      throw (error);
    }
  }
}
