import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/errors.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/auth_repository.dart';

class LoginUseCase implements UseCase<User, LoginParams> {
  final AuthRepository authRepository;

  LoginUseCase(this.authRepository);

  @override
  Future<Either<Failure, User>> call(LoginParams params) async {
    return await authRepository.login(params.email, params.password);
  }
}

class  LoginParams {
  final String email;
  final String password;

  LoginParams(this.email, this.password);
}
