import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ssl_app/model/documents.dart';
import 'package:ssl_app/utils/failures.dart';
import 'package:ssl_app/view/usecases/create_document.dart';
import 'package:ssl_app/view/usecases/get_doc_type.dart';

class RemoteDataSource {
  var data = [];
  List<Document> results = [];
  String urlList = 'https://jawadtestapi.herokuapp.com/Docs';

  Future<List<Document>> getDocument({String? query}) async {
    var url = Uri.parse(urlList);
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        data = json.decode(response.body);
        results = data.map((e) => Document.fromJson(e)).toList();
        if (query != null) {
          results = results
              .where((element) => element.createdBy!
                  .toLowerCase()
                  .contains((query.toLowerCase())))
              .toList();
        }
      } else {
        print("fetch error");
      }
    } on Exception catch (e) {
      print('error: $e');
    }
    return results;
  }

  Future<Either<Failure, List<DocTypeItem>>> getDocumentTypes() async {
    const url = "http://84.242.34.7/MobileAPItask/api/DocTypes?Languge=En";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200 && response.body.isNotEmpty) {
        final docs = jsonDecode(response.body);

        return right(
            List<DocTypeItem>.from(docs.map((x) => DocTypeItem.fromJson(x))));
      }

      return const Left(GetDocumentFailure("SOME THING WENT WRONG"));
    } on SocketException catch (e) {
      return Left(HttpFailure(e.message));
    } catch (e) {
      return const Left(GetDocumentFailure("SOME THING WENT WRONG"));
    }
  }

  Future<Either<Failure, bool>> createDocument(
      CreateDocumentParams param) async {
    const url = "https://jawadtestapi.herokuapp.com/Docs";

    try {
      final response = await http.post(Uri.parse(url),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          },
          body: jsonEncode(param.toJson()));

      if (response.statusCode == 200 && response.body.isNotEmpty) {
        return right(true);
      }

      return const Left(CreateDocumentFailure("SOME THING WENT WRONG"));
    } on SocketException catch (e) {
      return Left(HttpFailure(e.message));
    } catch (e) {
      return const Left(GetDocumentFailure("SOME THING WENT WRONG"));
    }
  }
}
