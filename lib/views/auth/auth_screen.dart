import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:with_diet/controller/auth_controller.dart';
import 'package:with_diet/views/home/home_screen.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.put(AuthController());
    return Scaffold(
      body: FlutterLogin(
        savedEmail: 'visionwill3322@gmail.com',
        savedPassword: '123456',
        onSignup: (v) async {
          await authController.signUp(
            email: v.name!,
            password: v.password!,
            loginType: LoginType.emailWithPassword,
          );
        },
        onLogin: (v) async {
          return await authController.login(
            LoginType.emailWithPassword,
            email: v.name,
            password: v.password,
          );
        },
        onSubmitAnimationCompleted: () {
          Get.to(() => HomeScreen());
        },
        onRecoverPassword: (v) async {},
        loginProviders: [
          LoginProvider(
            icon: FontAwesomeIcons.google,
            callback: () async {
              await authController.login(LoginType.google);
            },
          ),
          LoginProvider(
            icon: FontAwesomeIcons.apple,
            callback: () async {
              await authController.login(LoginType.apple);
            },
          ),
        ],
      ),
    );
  }
}
