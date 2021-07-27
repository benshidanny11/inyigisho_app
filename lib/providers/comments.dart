import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:inyigisho_app/constants/apis.dart';

import 'package:inyigisho_app/models/comment.dart';

class Comments with ChangeNotifier {
  List<Comment> _items = [];

  List<Comment> get items {
    return [..._items];
  }

  Future<void> fetchComments(int lessId) async {
    try {
      final response =
          await http.get(Uri.parse('${AppApi.COMMENTS_API}$lessId'));

      final extractedData = json.decode(response.body) as Map<String, dynamic>;

      if (extractedData == null) {
        return;
      }
      var decodedComments = extractedData['comments'] as List<dynamic>;

      final List<Comment> loadedComments = [];
      decodedComments.forEach((comment) {
        loadedComments.add(Comment(
            id: int.parse(comment['id']),
            userName: comment['userfullname'],
            doneOn: comment['doneon'],
            lessonId: comment['leason_id'],
            commentContent: comment['comment']));
      });

      _items = loadedComments;
      notifyListeners();
    } catch (error) {
      _items = [];
      notifyListeners();
      print(error);
      throw (error);
    }
  }

  Future<void> addComment(Comment comment) async {
    try {
      final res = await http.post(Uri.parse(AppApi.ADDCOMMENT_API),body: {
        
      });
    } catch (error) {
      _items = [];
      notifyListeners();
      print(error);
      throw (error);
    }
  }
}
