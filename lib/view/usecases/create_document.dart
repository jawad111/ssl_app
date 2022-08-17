import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:ssl_app/controller/service.dart';
import 'package:ssl_app/utils/failures.dart';
import 'package:ssl_app/utils/usecases.dart';

class CreateDocument extends UseCase<bool, CreateDocumentParams> {
  final RemoteDataSource service;
  CreateDocument(this.service);
  @override
  Future<Either<Failure, bool>> call(CreateDocumentParams params) {
    return service.createDocument(params);
  }
}

class CreateDocumentParams extends Equatable {
  final String subject;
  final String docDate;
  final String docType;
  final String createdBy;
  final int serialNumber;
  final int year;
  final int docId;

  const CreateDocumentParams({
    required this.subject,
    required this.docDate,
    required this.docType,
    required this.createdBy,
    required this.serialNumber,
    required this.year,
    required this.docId,
  });

  Map<String, dynamic> toJson() => {
    "subject": subject,
    "serial": serialNumber,
    "year": year,
    "docTypeID": docId,
    "createdBy": createdBy,
    "docDate": docDate,
  };

  @override
  List<Object?> get props => [
        subject,
        docDate,
        docType,
        createdBy,
        serialNumber,
      ];
}
