import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class HealthModel {
  final DateTime dateTime;
  final double value;
  HealthModel({required this.dateTime, required this.value});
}

class UserModel {
  String? uid;
  String? userName;
  String? email;
  String? phoneNumber;
  List<HealthModel>? steps;

  UserModel({
    this.uid,
    this.userName,
    this.email,
    this.phoneNumber,
    this.steps,
  });

  factory UserModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    return UserModel(
      uid: data?['uid'],
      userName: data?['userName'],
      email: data?['email'],
      phoneNumber: data?['phoneNumber'],
      steps: data?['steps'],
    );
  }
  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (uid != null) {
      result.addAll({'uid': uid});
    }
    if (userName != null) {
      result.addAll({'userName': userName});
    }
    if (email != null) {
      result.addAll({'email': email});
    }
    if (phoneNumber != null) {
      result.addAll({'phoneNumber': phoneNumber});
    }
    if (steps != null) {
      result.addAll({'steps': steps});
    }

    return result;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      userName: map['userName'],
      email: map['email'],
      phoneNumber: map['phoneNumber'],
      steps: map['steps'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}
