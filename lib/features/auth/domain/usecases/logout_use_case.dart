import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/errors.dart';
import '../repository/auth_repository.dart';

class LogoutUseCase {
  final AuthRepository repository;

  LogoutUseCase(this.repository);

  Future<Either<Failure, void>> call() {
    return repository.logout();
  }
}