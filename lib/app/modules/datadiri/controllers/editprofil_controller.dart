import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lurahku_remake/app/modules/home/controllers/home_controller.dart';

import '../../../data/api_service.dart';
import '../../../template/color_app.dart';

class EditProfileDialogController extends GetxController {
  var selectedImage = "".obs; 
  final HomeController hController = Get.find<HomeController>();

  RxBool isLoading = false.obs;

  final noKKController = TextEditingController();
  final emailController = TextEditingController();
  final noHpController = TextEditingController();
  final alamatController = TextEditingController();
  void pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImage.value = pickedFile.path;
    }
  }

  Future<void> updateProfil(String? pathFile) async {
    var noKK = noKKController.text;
    var email = emailController.text;
    var noHp = noHpController.text;
    var alamat = alamatController.text;

    final box = GetStorage();
    isLoading.value = true;
    final token = box.read('token');
    final apiService = Get.put(ApiService());
    try {
      if (noKK.length < 16) {
        Get.snackbar('Gagal', "Nomor Kartu Keluarga harus memiliki 16 digit");
      } else if (!email.isEmail) {
        Get.snackbar('Gagal', "Gunakan format email yang benar");
      } else {
        final response = await apiService.updateProfil(noKK, email, pathFile, alamat, noHp, token);
        if (response?['status'] == 'sukses') {
          Get.back(closeOverlays: true);
          Get.snackbar(
            'Sukses',
            response?['message'] ?? 'Profil berhasil diperbaharui',
            backgroundColor: Colors.green.withOpacity(0.35),
            colorText: white,
            snackPosition: SnackPosition.TOP,
          );
        } else {
          Get.snackbar(
            'Gagal',
            response?['message'] ?? 'Gagal memperbaharui profil',
            backgroundColor: Colors.red.withOpacity(0.2),
            colorText: black,
            snackPosition: SnackPosition.TOP,
          );
        }
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Terjadi kesalahan: ${e.toString()}',
        backgroundColor: Colors.red.withOpacity(0.2),
        colorText: black,
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    noKKController.text = hController.userData['noKK'];
    emailController.text = hController.userData['email'];
    noHpController.text = hController.userData['noHp'];
    alamatController.text = hController.userData['alamat'];
  }
  @override
  void onClose() {
    selectedImage.value = "";
    noKKController.text = "";
    emailController.text = "";
    noHpController.text = "";
    alamatController.text = "";
    super.onClose();
  }
}
