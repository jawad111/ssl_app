import 'package:dartz/dartz.dart';
import 'package:ssl_app/utils/failures.dart';

abstract class UseCase<T, L> {
  Future<Either<Failure, T>> call(L params);
}

class NoParams {}
