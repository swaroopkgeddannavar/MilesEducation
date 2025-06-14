import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/usecases/login_use_case.dart';

class LoginController extends GetxController {
  final LoginUseCase loginUseCase;

  LoginController(this.loginUseCase);

  final email = ''.obs;
  final password = ''.obs;
  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final obscurePassword = true.obs;
  final Rxn<User> user = Rxn<User>();

  Future<void> login() async {
    isLoading.value = true;
    errorMessage.value = '';

    final result = await loginUseCase(
      LoginParams(email.value.trim(), password.value.trim()),
    );

    result.fold(
          (failure) => errorMessage.value = failure.message,
          (userData) {
            print("User logged in: $userData");
        Get.offAllNamed('/tasks');
            Get.snackbar('Success', "Login Successful");
      },
    );


    isLoading.value = false;
  }
}
