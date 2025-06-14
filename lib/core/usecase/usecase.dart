

import 'package:fpdart/fpdart.dart';

import '../errors/errors.dart';

abstract interface class UseCase<SuccessType, Params> {
  Future<Either<Failure, SuccessType>> call(Params params);
}

class NoParams {}

abstract interface class AuthUseCase<ErrorType, SuccessType, Params> {
  Future<Either<ErrorType, SuccessType>> call(Params params);
}