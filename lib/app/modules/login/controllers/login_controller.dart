import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../data/api_service.dart';
import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  final box = GetStorage();
  var noKKTEC = TextEditingController();
  var passwordTEC = TextEditingController();
  var isLoading = false.obs;
  RxBool lihat = true.obs;
  RxBool warn = false.obs;
  RxString note = "".obs; 

  Future<void> login() async {
    isLoading.value = true;

    final noKK = noKKTEC.text;
    final password = passwordTEC.text;

    if (password.isNotEmpty && noKK.isNotEmpty) {
      final apiService = Get.put(ApiService());
      final response = await apiService.login(noKK, password);
      if (response != null) {
        if (response['status'] == 'sukses') {
          final box = GetStorage();
          box.write('token', response['access_token']);
          warn.value = false;
          note.value = '';
          Get.offAllNamed(Routes.HOME);
        } else {
          warn.value = true;
          note.value = 'Password atau nomor KK salah!';
        }
        isLoading.value = false;
      } else {
        warn.value = true;
        note.value = 'Password atau nomor KK salah!';
      }
      isLoading.value = false;
    } else {
      warn.value = true;
      note.value = 'Silahkan isi semua kolom';
      isLoading.value = false;
    }
  }

  void isPeek() {
    lihat.value = !lihat.value;
  }

}
