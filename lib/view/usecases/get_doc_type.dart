import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:ssl_app/controller/service.dart';
import 'package:ssl_app/utils/failures.dart';
import 'package:ssl_app/utils/usecases.dart';

class GetDocumentTypes extends UseCase<List<DocTypeItem>, NoParams> {
  final RemoteDataSource service;
  GetDocumentTypes(this.service);
  @override
  Future<Either<Failure, List<DocTypeItem>>> call(NoParams params) {
    return service.getDocumentTypes();
  }
}

class DocTypeItem extends Equatable {
  final int documentID;
  final String documentName;
  const DocTypeItem({required this.documentID, required this.documentName});

  factory DocTypeItem.fromJson(Map<String, dynamic> json) {
    return DocTypeItem(documentID: json['docTypeID'], documentName: json['docTypeName']);
  }

  @override
  List<Object?> get props => [documentID, documentName];
}
