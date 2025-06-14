import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:miles_educations/core/errors/errors.dart';
import 'package:miles_educations/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _firebaseAuth;

  AuthRepositoryImpl(this._firebaseAuth);

  @override
  Future<Either<Failure, User>> login(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;
      if (user != null) {
        return Right(user);
      } else {
        return Left(UnknownFailure(message: "Login failed: No user returned."));
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          return Left(UnknownFailure(message: 'No user found for that email.'));
        case 'wrong-password':
          return Left(UnknownFailure(message: 'Wrong password provided.'));
        default:
          return Left(
            UnknownFailure(message: e.message ?? 'Authentication failed.'),
          );
      }
    } catch (e) {
      return Left(UnknownFailure(message: 'Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, User>> signup(String email, String password) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return right(credential.user!);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return Left(
          UnknownFailure(
            message:
                "The email address is already in use. Try logging in instead.",
          ),
        );
      }
      return Left(UnknownFailure(message: "${e.message}"));
    } catch (e) {
      return left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await _firebaseAuth.signOut();
      return const Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(UnknownFailure(message: e.message ?? "Logout failed"));
    }
  }
}
