import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ssl_app/model/documents.dart';
import 'package:ssl_app/model/users.dart';

class Service {
  static const String url = 'https://jsonplaceholder.typicode.com/users';
  static List<Users> _doc = [];
  static Future<List<Users>> getDocuments() async {
    try {
      final response = await http.get(Uri.parse(url));

      debugPrint(response.statusCode.toString());

      if (200 == response.statusCode) {
        final List<Users> docs = UsersFromJson(response.body);
        return docs;
      } else {
        return _doc;
      }
    } catch (e) {
      return _doc;
    }
  }
}
