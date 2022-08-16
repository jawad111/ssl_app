// To parse this JSON data, do
//
//     final Document = DocumentFromJson(jsonString);

import 'dart:convert';
import 'package:ssl_app/model/documents.dart';

List<Document> DocumentFromJson(String str) =>
    List<Document>.from(json.decode(str).map((x) => Document.fromJson(x)));

String DocumentToJson(List<Document> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Document {
  Document({
    required this.docId,
    required this.createdOn,
    required this.docTypeAr,
    required this.docTypeEn,
    required this.subject,
    required this.serial,
    required this.year,
    required this.docTypeId,
    required this.createdBy,
    required this.docDate,
  });

  int docId;
  DateTime createdOn;
  String docTypeAr;
  String docTypeEn;
  String subject;
  int serial;
  int year;
  int docTypeId;
  String createdBy;
  DateTime docDate;

  factory Document.fromJson(Map<String, dynamic> json) => Document(
        docId: json["docID"],
        createdOn: DateTime.parse(json["createdOn"]),
        docTypeAr: json["docType_Ar"],
        docTypeEn: json["docType_En"],
        subject: json["subject"],
        serial: json["serial"],
        year: json["year"],
        docTypeId: json["docTypeID"],
        createdBy: json["createdBy"],
        docDate: DateTime.parse(json["docDate"]),
      );

  Map<String, dynamic> toJson() => {
        "docID": docId,
        "createdOn": createdOn.toIso8601String(),
        "docType_Ar": docTypeAr,
        "docType_En": docTypeEn,
        "subject": subject,
        "serial": serial,
        "year": year,
        "docTypeID": docTypeId,
        "createdBy": createdBy,
        "docDate": docDate.toIso8601String(),
      };
}
