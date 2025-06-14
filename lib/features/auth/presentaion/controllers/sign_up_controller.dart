import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/errors/errors.dart';
import '../../domain/usecases/sign_in_use_case.dart';

class SignupController extends GetxController {
  final SignupUseCase signupUseCase;

  SignupController(this.signupUseCase);

  final email = ''.obs;
  final password = ''.obs;
  final isLoading = false.obs;
  final obscurePassword = true.obs;
  Future<void> signup() async {
    isLoading.value = true;
    final result = await signupUseCase(SignupParams(email.value, password.value));
    result.match(
          (failure) => Get.snackbar('Error', failure.message),
          (user) => Get.toNamed('/login'),


    );
    isLoading.value = false;
  }
}
