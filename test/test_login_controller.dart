import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:miles_educations/features/auth/domain/usecases/login_use_case.dart';
import 'package:miles_educations/features/auth/domain/usecases/logout_use_case.dart';
import 'package:miles_educations/core/services/hive_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:miles_educations/features/auth/presentaion/controllers/login_controller.dart';
import 'package:mockito/mockito.dart';

class MockLoginUseCase extends Mock implements LoginUseCase {}
class MockLogoutUseCase extends Mock implements LogoutUseCase {}
class MockHiveStorage extends Mock implements HiveStorage {}
class MockUser extends Mock implements User {}

void main() {
  late LoginController controller;
  late MockLoginUseCase mockLoginUseCase;
  late MockLogoutUseCase mockLogoutUseCase;
  late MockHiveStorage mockHiveStorage;

  setUp(() {
    mockLoginUseCase = MockLoginUseCase();
    mockLogoutUseCase = MockLogoutUseCase();
    mockHiveStorage = MockHiveStorage();
    controller = LoginController(mockLoginUseCase, mockLogoutUseCase, mockHiveStorage);
  });

  test('Login sets token and navigates on success', () async {
    final mockUser = MockUser();
    final loginParams = LoginParams( 'test@test.com','password');
    when(mockLoginUseCase.call(loginParams)).thenAnswer((_) async => Right(mockUser));
    when(mockUser.getIdToken()).thenAnswer((_) async => 'token_123');

    controller.email.value = 'test@test.com';
    controller.password.value = 'password';

    await controller.login();

    verify(mockHiveStorage.saveAuthToken('token_123')).called(1);
    expect(controller.isLoading.value, false);
  });

  test('Logout clears token and navigates', () async {
    when(mockLogoutUseCase.call()).thenAnswer((_) async => const Right(null));
    when(mockHiveStorage.clearAuthToken()).thenAnswer((_) async {});

    await controller.logout();

    verify(mockHiveStorage.clearAuthToken()).called(1);
    expect(controller.isLoading.value, false);
  });

}
