import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:with_diet/controller/auth_controller.dart';
import 'package:with_diet/models/user_model.dart';
import 'package:with_diet/service/auth_service.dart';

class AuthRepository {
  AuthService _authService = AuthService();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserModel> saveUserIntoFirebase({
    String? userName,
    required String email,
    required String password,
    required LoginType loginType,
  }) async {
    try {
      UserCredential? userCredential;
      switch (loginType) {
        case LoginType.emailWithPassword:
          userCredential = await _authService.createUserWithEmailAndPassword(
            email: email,
            password: password,
          );
        case LoginType.google:
          userCredential = await _authService.signInWithGoogle();
        case LoginType.apple:
          userCredential = await _authService.signInWithApple();
      }

      // if (userCredential == null || userCredential.user == null) return;

      String uid = userCredential!.user!.uid;
      UserModel userModel = UserModel(
        uid: uid,
        userName: userName,
        email: email,
      );

      await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .set(userModel.toMap());

      return userModel;
    } catch (e) {
      rethrow;
    }
  }
}
