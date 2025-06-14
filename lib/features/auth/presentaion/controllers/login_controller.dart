import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/services/hive_storage.dart';
import '../../domain/usecases/login_use_case.dart';
import '../../domain/usecases/logout_use_case.dart';

class LoginController extends GetxController {
  final LoginUseCase loginUseCase;
  final LogoutUseCase logoutUseCase;
  final HiveStorage hiveStorage;

  LoginController(this.loginUseCase, this.logoutUseCase, this.hiveStorage);

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

    result.fold((failure) => errorMessage.value = failure.message, (
      userData,
    ) async {
      final token = await userData.getIdToken();
      if (token != null) {
        hiveStorage.saveAuthToken(token);
        print("token: $token");
      }
      print("User logged in: $userData");
      Get.offAllNamed('/tasks');
      Get.snackbar(
        'Success',
        "Login Successful",
        backgroundColor: Colors.white,
        colorText: Colors.blue,
        snackPosition: SnackPosition.BOTTOM,
      );
    });

    isLoading.value = false;
  }

  Future<void> logout() async {
    final result = await logoutUseCase();
    result.fold(
      (failure) {
        Get.snackbar('Error', failure.message);
      },
      (_) {
        hiveStorage.clearAuthToken();
        Get.snackbar(
          'Success',
          "Logout Successful",
          backgroundColor: Colors.white,
          colorText: Colors.blue,
          snackPosition: SnackPosition.BOTTOM,
        );
        Get.offAllNamed('/login');
      },
    );
  }
}
