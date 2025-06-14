import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:miles_educations/features/auth/domain/usecases/logout_use_case.dart';
import 'package:miles_educations/features/auth/domain/usecases/sign_in_use_case.dart';
import 'package:miles_educations/features/auth/presentaion/controllers/sign_up_controller.dart';
import '../../../../core/services/fire_store_services.dart';
import '../../../../core/services/hive_storage.dart';
import '../../../home/presentation/controll/task_controller.dart';
import '../../data/repository/auth_repository_impl.dart';
import '../../domain/repository/auth_repository.dart';
import '../../domain/usecases/login_use_case.dart';
import '../controllers/login_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    // Firebase instances
    Get.lazyPut(() => FirebaseAuth.instance);
    Get.lazyPut(() => FirebaseFirestore.instance);

    // Repositories
    Get.lazyPut<AuthRepository>(() => AuthRepositoryImpl(Get.find()));

    // Services
    Get.lazyPut(() => HiveStorage());
    Get.lazyPut(() => TaskService(
      firestore: Get.find(),
      auth: Get.find(),
    ));

    // UseCases
    Get.lazyPut(() => LoginUseCase(Get.find()));
    Get.lazyPut(() => SignupUseCase(Get.find()));
    Get.lazyPut(() => LogoutUseCase(Get.find()));

    // Controllers
    Get.lazyPut(() => LoginController(Get.find(), Get.find(), Get.find()));
    Get.lazyPut(() => SignupController(Get.find()));
    Get.lazyPut(() => TaskController(service: Get.find()));
  }
}

