import 'errors.dart';

class ServerFailure extends Failure {
  ServerFailure({super.message, required super.statusCode});
}

class ErrorResponseFailure extends Failure {
  ErrorResponseFailure({super.message, required super.statusCode});
}
