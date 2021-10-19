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

  Future<void> fetchComments(int lessId,String lessType) async {
    try {
      final response =
          await http.get(Uri.parse('${AppApi.getCommentURL(lessId,lessType)}'));

      final Map<String, dynamic>? extractedData =
          json.decode(response.body) as Map<String, dynamic>;
      List<Comment> loadedComments = [];
      if (extractedData == null) {
        loadedComments = [];
         _items = loadedComments;
         notifyListeners();
        return;
      }
      var decodedComments = extractedData['comments']!=null?extractedData['comments'] as List<dynamic>:[];

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

  Future<bool> addComment(
    String fullName,
    String commnetContent,
    int lessonId,
    String lessype
  ) async {
    try {
     
      await http.post(Uri.parse(AppApi.ADDCOMMENT_API),
          body: json.encode({
            "fullname": fullName,
            "leasonid": lessonId,
            "comment": commnetContent,
            "lessontype":lessype
          }));

      notifyListeners();
      return true;
    } catch (error) {
      _items = [];

      notifyListeners();
      print(error);
      return false;
    }
  }

  void emptyComments() {
    _items = [];
    notifyListeners();
  }

  void emptyCommentsForInit() {
    _items = [];
  }
}
