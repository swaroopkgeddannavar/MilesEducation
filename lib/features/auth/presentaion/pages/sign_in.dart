import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/sign_up_controller.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  final controller = Get.find<SignupController>();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
          child: Form(
            key: _formKey,
            child: Column(
              children: [ CircleAvatar(
                radius: 100,
                backgroundImage: AssetImage("assets/images/logo.png"),
              ),
                SizedBox(height: 40),
                Icon(Icons.person_add_alt_1_rounded,
                    size: 50, color: theme.colorScheme.primary),
                const SizedBox(height: 20),
                Text(
                  "Create Account",
                  style: theme.textTheme.headlineLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  "Join us to start learning today!",
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(height: 32),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Email",
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (val) => controller.email.value = val.trim(),
                  validator: (val) =>
                  val!.isEmpty ? "Email cannot be empty" : null,
                ),
                const SizedBox(height: 16),
                Obx(() => TextFormField(
                  obscureText: controller.obscurePassword.value,
                  decoration: InputDecoration(
                    labelText: "Password",
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(controller.obscurePassword.value
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () => controller.obscurePassword.toggle(),
                    ),
                    border: const OutlineInputBorder(),
                  ),
                  onChanged: (val) =>
                  controller.password.value = val.trim(),
                  validator: (val) => val!.length < 6
                      ? "Password must be at least 6 characters"
                      : null,
                )),
                const SizedBox(height: 24),

                // Submit
                Obx(() => ElevatedButton.icon(
                  icon: controller.isLoading.value
                      ? const SizedBox(
                    height: 18,
                    width: 18,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                      : const Icon(Icons.arrow_forward),
                  label: Text(
                    controller.isLoading.value ? "Creating..." : "Sign Up",
                  ),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      controller.signup();
                    }
                  },
                )),

                const SizedBox(height: 24),

                // Already have an account?
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?"),
                    TextButton(
                      onPressed: () {
                        Get.offNamed('/login');
                      },
                      child: const Text("Login"),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
