import 'package:get/get_navigation/src/routes/get_route.dart';

import '../features/auth/presentaion/binindings/auth_binding.dart';
import '../features/auth/presentaion/pages/login_page.dart';
import '../features/auth/presentaion/pages/sign_in.dart';
import '../features/auth/presentaion/pages/splash_screen.dart';
import '../features/home/presentation/pages/task_page.dart';

class AppRoutes {
  static final pages = [
    GetPage(name: '/', page: () => const SplashWidget()),
    GetPage(name: '/signup', page: () => SignUpPage(), binding: AuthBinding()),
    GetPage(name: '/login', page: () => LoginPage(), binding: AuthBinding()),
    GetPage(name: '/tasks', page: () => TaskPage(), binding: AuthBinding()),
  ];
}
