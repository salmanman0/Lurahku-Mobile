import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/api_service.dart';
import '../../../template/color_app.dart';


class ForgetController extends GetxController {
  var emailTEC = TextEditingController();

  RxBool isLoading = false.obs;
  RxBool warn = false.obs;
  RxString note = "".obs;
  Color warna = Colors.white;

  Future<void> forgotPassword() async {
    isLoading.value = true;
    final email = emailTEC.text;
    if (email.isEmpty) {
      warn.value = true;
      note.value = "Silahkan isi form";
      isLoading.value = false;
    } else if (!email.isEmail) {
      warn.value = true;
      note.value = "Gunakan format email yang benar";
      isLoading.value = false;
    } else {
      final apiService = Get.put(ApiService());
      final response = await apiService.forgotPassword(email);
      if (response != null) {
        if (response['status'] == 'sukses') {
          warn.value = true;
          note.value = '${response['message']} Silahkan cek email anda!';
          warna = sukses;
        } else if (response['status'] == 'gagal') {
          warn.value = true;
          note.value = 'Gagal! ${response['message']}';
          warna = gagal;
        } else {
          warn.value = true;
          note.value = 'Terjadi kesalahan, periksa koneksi anda!';
          warna = gagal;
        }
        isLoading.value = false;
      } else {
        warn.value = true;
        note.value = 'Tidak dapat membaca respon, periksa koneksi anda!';
        warna = gagal;
      }
      isLoading.value = false;
    }
  }
}
