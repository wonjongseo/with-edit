import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';

class AppSnackbar {
  static showErrorSnackBar({String message = '실패'}) {
    if (Get.isSnackbarOpen) {
      Get.closeAllSnackbars();
    }
    Get.rawSnackbar(
      icon: Icon(FontAwesomeIcons.circleExclamation),
      margin: EdgeInsets.symmetric(horizontal: 10 * 1.5),
      borderRadius: 10,
      // message: message,
      backgroundColor: Colors.redAccent,
      snackPosition: SnackPosition.TOP,
      messageText: Text(message, style: TextStyle(color: Colors.black)),
    );
  }

  static showSuccessSnackBar({String message = '성공'}) {
    if (Get.isSnackbarOpen) {
      Get.closeAllSnackbars();
    }
    Get.rawSnackbar(
      icon: Icon(FontAwesomeIcons.circleCheck),
      margin: EdgeInsets.symmetric(horizontal: 10 * 1.5),
      borderRadius: 10,
      // message: message,
      backgroundColor: Colors.greenAccent,
      snackPosition: SnackPosition.TOP,
      messageText: Text(message, style: TextStyle(color: Colors.black)),
    );
  }
}
