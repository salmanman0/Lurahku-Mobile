import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:lurahku_remake/app/template/color_app.dart';

import '../../../data/api_service.dart';
import '../../../routes/app_pages.dart';

class RegistController extends GetxController {
  var emailTEC = TextEditingController();
  var noKKTEC = TextEditingController();
  var passwordTEC = TextEditingController();
  var confirmPassTEC = TextEditingController();

  RxBool isLoading = false.obs;
  RxBool lihat1 = true.obs;
  RxBool lihat2 = true.obs;

  RxBool warn = false.obs;
  RxString note = ''.obs;

  void isPeek1() {
    lihat1.value = !lihat1.value;
  }

  void isPeek2() {
    lihat2.value = !lihat2.value;
  }

  Future<void> register() async {
    
    isLoading.value = true;
    final email = emailTEC.text;
    final noKK = noKKTEC.text;
    final password = passwordTEC.text;
    final confirmPass = confirmPassTEC.text;


    if (password.isNotEmpty &&noKK.isNotEmpty&&email.isNotEmpty&&confirmPass.isNotEmpty) {
      if (!email.isEmail) {
        warn.value = true;
        note.value = 'Format email anda salah';
        isLoading.value = false;
      }
      else if (noKK.length < 16) {
        warn.value = true;
        note.value = "Nomor KK yang anda masukkan tidak valid";
        isLoading.value = false;
      }
      else if(!noKK.isNumericOnly){
        warn.value = true;
        note.value = "Nomor KK hanya dapat berupa angka";
        isLoading.value = false;
      }
      else if (password.length < 8) {
        warn.value = true;
        note.value = "Password minimal memiliki 8 karakter";
        isLoading.value = false;
      } else if (password != confirmPass) {
        warn.value = true;
        note.value = "Password tidak sama";
        isLoading.value = false;
      } else {
        final apiService = Get.put(ApiService());
        final response = await apiService.register(email, noKK, password);
        if (response != null) {
          if (response['status'] == 'sukses') {
            warn.value = false;
            note.value = '';
            Get.offAllNamed(Routes.LOGIN);
            Get.snackbar("Sukses", "Akun kamu berhasil dibuat", backgroundColor: sukses.withOpacity(0.8), colorText: white);
            isLoading.value = false;
          } else {
            warn.value = true;
            note.value = 'Maaf, ${response['message']}';
            isLoading.value = false;
          }
        } else {
          warn.value = true;
          note.value = 'Gagal, silahkan coba lagi';
          isLoading.value = false;
        }
        isLoading.value = false;
      }
    } else {
      warn.value = true;
      note.value = 'Silahkan isi semua kolom';
      isLoading.value = false;
    }
  }
}
