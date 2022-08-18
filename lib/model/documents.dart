// To parse this JSON data, do
//
//     final Document = DocumentFromJson(jsonString);

import 'dart:convert';
import 'package:ssl_app/model/documents.dart';
// To parse this JSON data, do
//
//     final Document = DocumentFromJson(jsonString);

import 'dart:convert';

Document DocumentFromJson(String str) => Document.fromJson(json.decode(str));

String DocumentToJson(Document data) => json.encode(data.toJson());

class Document {
  Document({
    required this.subject,
    required this.serial,
    required this.year,
    required this.docTypeId,
    required this.createdBy,
    required this.docDate,
    required this.id,
  });

  String subject;
  int serial;
  int year;
  int docTypeId;
  String createdBy;
  DateTime docDate;
  int id;

  factory Document.fromJson(Map<String, dynamic> json) => Document(
        subject: json["subject"],
        serial: json["serial"],
        year: json["year"],
        docTypeId: json["docTypeID"],
        createdBy: json["createdBy"],
        docDate: DateTime.parse(json["docDate"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "subject": subject,
        "serial": serial,
        "year": year,
        "docTypeID": docTypeId,
        "createdBy": createdBy,
        "docDate":
            "${docDate.year.toString().padLeft(4, '0')}-${docDate.month.toString().padLeft(2, '0')}-${docDate.day.toString().padLeft(2, '0')}",
        "id": id,
      };
}
