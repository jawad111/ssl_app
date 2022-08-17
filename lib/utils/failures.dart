import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);
}

class GetDocumentFailure extends Failure {
  const GetDocumentFailure(super.message);

  @override
  List<Object?> get props => [message];
}

class CreateDocumentFailure extends Failure {
  const CreateDocumentFailure(super.message);

  @override
  List<Object?> get props => [message];
}

class HttpFailure extends Failure {
  const HttpFailure(super.message);

  @override
  List<Object?> get props => [message];
}