import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:ours_log/controller/onboarding_controller.dart';
// import 'package:ours_log/controller/user_controller.dart';

class AppColors {
  AppColors._();

  static Color get primaryColor {
    int selectedColorIndex = 0;
    // if (Get.isRegistered<OnboardingController>()) {
    //   OnboardingController onboardingController =
    //       Get.find<OnboardingController>();
    //   selectedColorIndex = onboardingController.selectedColorIndex;
    // }

    // if (Get.isRegistered<UserController>()) {
    //   UserController userController = Get.find<UserController>();
    //   if (userController.userModel != null) {
    //     selectedColorIndex = userController.userModel!.colorIndex ?? 3;
    //   }
    // }

    if (Get.isDarkMode) {
      switch (selectedColorIndex) {
        case 0:
          return priDarkPinkClr;
        case 1:
          return priDarkYellowClr;
        case 2:
          return priDarkGreenClr;
        case 3:
          return priDarkBluishClr;
        case 4:
          return priDarkPubbleClr;
      }
    } else {
      switch (selectedColorIndex) {
        case 0:
          return priPinkClr;
        case 1:
          return priYellowClr;
        case 2:
          return priGreenClr;
        case 3:
          return priBluishClr;

        case 4:
          return priPubbleClr;
      }
    }

    return priPubbleClr;
  }

  static Color get secondaryColor {
    int selectedColorIndex = 0;
    // if (Get.isRegistered<OnboardingController>()) {
    //   OnboardingController onboardingController =
    //       Get.find<OnboardingController>();
    //   selectedColorIndex = onboardingController.selectedColorIndex;
    // }

    // if (Get.isRegistered<UserController>()) {
    //   UserController userController = Get.find<UserController>();
    //   if (userController.userModel != null) {
    //     selectedColorIndex = userController.userModel!.colorIndex ?? 3;
    //   }
    // }

    if (Get.isDarkMode) {
      switch (selectedColorIndex) {
        case 0:
          return secDarkPinkClr;
        case 1:
          return secDarkYellowClr;
        case 2:
          return secDarkGreenClr;
        case 3:
          return secDarkBluishClr;
        case 4:
          return secDarkPubbleClr;
      }
    } else {
      switch (selectedColorIndex) {
        case 0:
          return secPinkClr;
        case 1:
          return secYellowClr;
        case 2:
          return secGreenClr;
        case 3:
          return secBluishClr;

        case 4:
          return secPubbleClr;
      }
    }

    return priPubbleClr;
  }

  static const Color priPinkClr = Color(0xFFff4667);
  static const Color priYellowClr = Color(0xFFFFB746);
  static const Color priGreenClr = Color(0xFF00C853);
  static const Color priBluishClr = Color(0xFF4e5ae8);
  static const Color priPubbleClr = Color(0xFF6200EA);

  static const Color secPinkClr = Color(0xFF6A1B9A);
  static const Color secYellowClr = Color(0xFF00BFA5);
  static const Color secGreenClr = Color(0xFFD50000);
  static const Color secBluishClr = Color(0xFF2962FF);
  static const Color secPubbleClr = Color(0xFFC51162);

  static const Color priDarkPinkClr = Color(0xFFb32d4c);
  static const Color priDarkYellowClr = Color(0xFFb27934);
  static const Color priDarkGreenClr = Color(0xFF007a38);
  static const Color priDarkBluishClr = Color(0xFF3a44b7);
  static const Color priDarkPubbleClr = Color(0xFF3e009e);

  static const Color secDarkPinkClr = Color(0xFF4A148C);
  static const Color secDarkYellowClr = Color(0xFF009688);
  static const Color secDarkGreenClr = Color(0xFFB71C1C);
  static const Color secDarkBluishClr = Color(0xFF1A237E);
  static const Color secDarkPubbleClr = Color(0xFF880E4F);

  //
  // static const Color secondaryColor = Color(0xFFFC2E20);
  static const Color greenDark = Color(0xFF00A884);
  static const Color greenLight = Color(0xFF008069);

  static const Color greyDark = Color(0xFF8696A0);
  static const Color greyLight = Color(0xFF667781);
  static const Color black = Color(0xFF111B21);
  static Color white = Colors.white.withOpacity(.95);
  static const Color darkBackground = Color(0xFF202C33);
  static const Color darkTextColor = Color(0xFFE0E0E0);
}
