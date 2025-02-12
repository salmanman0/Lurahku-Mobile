import 'dart:async';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../routes/app_pages.dart';

class SplashController extends GetxController {
  final box = GetStorage();
  void checkLoginStatus() {
    Timer(const Duration(milliseconds: 2500), () {
      String? token = box.read('token');
      if (token != null && token.isNotEmpty) {
        Get.offAllNamed(Routes.HOME);
      } else {
        Get.offAllNamed(Routes.LOGIN);
      }
    });
  }
}
