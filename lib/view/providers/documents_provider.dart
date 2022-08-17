import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ssl_app/utils/failures.dart';
import 'package:ssl_app/utils/usecases.dart';
import 'package:ssl_app/view/usecases/create_document.dart';
import 'package:ssl_app/view/usecases/get_doc_type.dart';

class DocumentProvider extends ChangeNotifier {
  final GetDocumentTypes getDocumentTypes;
  final CreateDocument createDocument;
  DocumentProvider({
    required this.getDocumentTypes,
    required this.createDocument,
  });

  bool loading = false;
  bool submitting = false;
  List<DocTypeItem> items = [];
  String subject = '';
  String docDate = '';
  String serialNumber = '';
  String year = '';
  String name = 'Jawad';
  DocTypeItem selectedItem = const DocTypeItem(documentID: -1, documentName: 'Document Type');
  DocTypeItem defaultValue = const DocTypeItem(documentID: -1, documentName: 'Document Type');
  Either<Failure, Unit> failureEither = right(unit);
  final firstDate = DateTime.now();
  final lastDate = DateTime(DateTime.now().year + 5);
  final format = DateFormat("yyyy-MM-dd");

  final TextEditingController subjectController = TextEditingController();
  final TextEditingController serialNumberController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final TextEditingController dateTimeFieldController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  void itemSelected(DocTypeItem item) {
    selectedItem = item;
    notifyListeners();
  }

  void subjectEntered(String value) {
    subject = value;
    notifyListeners();
  }

  void dateChanged(String date) {
    docDate = date;
    notifyListeners();
  }

  void serialNumberEntered(String number) {
    serialNumber = number;
    notifyListeners();
  }

  void yearEntered(String number) {
    year = number;
    notifyListeners();
  }

  Future<void> save() async {
    if(submitting) return;
    final bool valid = formKey.currentState!.validate();
    if (valid) {
      submitting = true;
      notifyListeners();
      int serial = int.parse(serialNumber);
      int yearNumber = int.parse(year);

      final param = CreateDocumentParams(
        subject: subject,
        docDate: docDate,
        docType: selectedItem.documentName,
        createdBy: name,
        serialNumber: serial,
        year: yearNumber,
        docId: selectedItem.documentID,
      );
      final resultEither = await createDocument(param);
      resultEither.fold(
        (l) {
          failureEither = left(l);
          submitting = false;
        },
        (r) {
          submitting = false;
          clear();
        },
      );
      notifyListeners();
    }
  }

  void clear() {
    if(submitting) return;
    subjectController.clear();
    yearController.clear();
    serialNumberController.clear();
    dateTimeFieldController.clear();
    selectedItem = defaultValue;

    notifyListeners();
  }

  Future<void> getDocTypes() async {
    loading = true;
    failureEither = right(unit);
    notifyListeners();

    final resultEither = await getDocumentTypes(NoParams());

    resultEither.fold(
      (failure) {
        loading = false;
        failureEither = left(failure);
      },
      (r) {
        loading = false;
        r.insert(0, selectedItem);
        items = [...r];
        selectedItem = r[0];
      },
    );
    notifyListeners();
  }
}
