// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale ) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> ar = {
  "appTitle": "نسخة تجريبية لتطبيق SSL",
  "searchPage": "صفحة البحث",
  "addDocument": "أضف وثيقة",
  "titleDocuments": "وثائق",
  "hintSearch": "يبحث",
  "hintSearchMain": "البحث عن الخالق",
  "createdBy": "انشأ من قبل",
  "DocumentId": "معرف المستند",
  "Documentdate": "تاريخ الوثيقة",
  "serialNo": "رقم سري",
  "hintSubject": "موضوعات",
  "hintDocumentType": "نوع الوثيقة",
  "hintDocumentTypeOut": "منفتح",
  "hintDocumentTypeIn": "واردة",
  "hintDocumentDate": "تاريخ الوثيقة",
  "hintSerialNo": "رقم سري",
  "hintYear": "سنة",
  "saveButton": "يحفظ",
  "clearButton": "صافي",
  "correctioSubject": "أدخل موضوعًا صالحًا",
  "correctioType": "الرجاء تحديد قيمة صالحة",
  "correctioDate": "تاريخ غير صالح",
  "correctioSerial": "الرقم التسلسلي غير صحيح",
  "correctioYear": "عام غير صالح"
};
static const Map<String,dynamic> en = {
  "appTitle": "SSL App Demo",
  "searchPage": "Search Page",
  "addDocument": "Add Document",
  "titleDocuments": "Documents",
  "hintSearch": "Search",
  "hintSearchMain": "Search Creator",
  "createdBy": "Created By",
  "DocumentId": "Document ID",
  "Documentdate": "Document Date",
  "serialNo": "Serial No",
  "hintSubject": "Subject",
  "hintDocumentType": "Document Type",
  "hintDocumentTypeOut": "OutGoing",
  "hintDocumentTypeIn": "Incoming",
  "hintDocumentDate": "Document Date",
  "hintSerialNo": "Serial Number",
  "hintYear": "Year",
  "saveButton": "Save",
  "clearButton": "Clear",
  "correctioSubject": "Enter a valid subject.",
  "correctioType": "please select a valid value",
  "correctioDate": "Invalid date",
  "correctioSerial": "Invalid Serial Number",
  "correctioYear": "Invalid Year."
};
static const Map<String, Map<String,dynamic>> mapLocales = {"ar": ar, "en": en};
}
