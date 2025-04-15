import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:with_diet/models/user_model.dart';
import 'package:with_diet/repository/auth_repository.dart';
import 'package:with_diet/service/auth_service.dart';
import 'package:with_diet/views/auth/auth_screen.dart';
import 'package:with_diet/views/home/home_screen.dart';

enum LoginType { emailWithPassword, google, apple }

class AuthController extends GetxController {
  final AuthRepository _authRepository = AuthRepository();
  final firebaseAuth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  AuthService authService = AuthService();
  User? user;
  UserModel? userModel;

  @override
  void onInit() async {
    super.onInit();
    await Future.delayed(Duration(milliseconds: 500));
    if (userLoggedIn()) {
      user = firebaseAuth.currentUser!;
      Get.offAll(() => HomeScreen());
      return;
    } else {
      Get.offAll(() => AuthScreen());
    }
  }

  Future<String?> signUp({
    required String email,
    required String password,
    required LoginType loginType,
  }) async {
    try {
      userModel = await _authRepository.saveUserIntoFirebase(
        email: email,
        password: password,
        loginType: loginType,
      );
      update();
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      }
    } catch (e) {
      return '$e';
    }
    return null;
  }

  Future<String?> login(
    LoginType loginType, {
    String? email,
    String? password,
  }) async {
    try {
      UserCredential? userCredential;
      switch (loginType) {
        case LoginType.emailWithPassword:
          userCredential = await authService.signInWithEmailAndPassword(
            email: email!,
            password: password!,
          );
          break;
        case LoginType.google:
          userCredential = await authService.signInWithGoogle();
          break;
        case LoginType.apple:
          userCredential = await authService.signInWithApple();
          break;
      }

      return null;
    } catch (e) {
      return e.toString();
    }
  }

  bool userLoggedIn() {
    return firebaseAuth.currentUser != null;
  }

  void listenUser() {
    firebaseAuth.authStateChanges().listen((User? user) {
      this.user = user;
      if (this.user == null) {
        print('${this.user!.uid} User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
  }

  void sendPasswordResetEmail() async {
    if (userLoggedIn()) {
      firebaseAuth.sendPasswordResetEmail(email: user!.email ?? "");
    }
  }

  void logOut() {
    FirebaseAuth.instance.signOut();
    user = null;
    Get.to(() => AuthScreen());
  }
}
