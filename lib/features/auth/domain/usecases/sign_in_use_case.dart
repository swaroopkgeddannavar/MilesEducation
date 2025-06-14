import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/errors.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/auth_repository.dart';

class SignupUseCase implements UseCase<User, SignupParams> {
  final AuthRepository authRepository;

  SignupUseCase(this.authRepository);

  @override
  Future<Either<Failure, User>> call(SignupParams params) {
    return authRepository.signup(params.email, params.password);
  }
}

class SignupParams {
  final String email;
  final String password;

  SignupParams(this.email, this.password);
}
