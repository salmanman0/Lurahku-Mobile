import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lurahku_remake/app/data/api_service.dart';
import 'package:lurahku_remake/app/modules/datadiri/controllers/listData.dart' as ld;
import 'package:lurahku_remake/app/template/color_app.dart';

class DatadiriController extends GetxController {
  
  final RxList<Map<String, dynamic>> keluarga = <Map<String, dynamic>>[].obs;
  final apiService = Get.put(ApiService());
  final box = GetStorage();
  // Text controllers for form input fields
  var namaController = TextEditingController();
  var nikController = TextEditingController();
  var tempatLahirController= TextEditingController();
  var peran = ''.obs;
  var jenisKelamin = ''.obs;
  var agama = ''.obs;
  var statusPerkawinan = ''.obs;
  var pendidikan = ''.obs;
  var golonganDarah = ''.obs;
  var pekerjaan = ''.obs;
  var tanggalLahir = ''.obs;

  var listPekerjaan = ld.listPekerjaan;
  var listGolDar = ld.listGolDar;
  var listPendidikan = ld.listPendidikan;
  var listAgama = ld.listAgama;
  var listStatusPerkawinan = ld.listStatusPerkawinan;

  var newPassword = ''.obs;
  var confirmPassword = ''.obs;
  var isPasswordMatch = false.obs;
  var lihat1 = true.obs;
  var lihat2 = true.obs;

  var showEmptyMessage = false.obs;
  
  var warn = ''.obs;
  var galat = false.obs;

  var checkRekom = false.obs;

  RxBool isLoading = false.obs;
  var errorMessage = ''.obs;

  RxString selectedRW = '01'.obs;
  RxString selectedRT = '01'.obs;

  List<Map<String, dynamic>> rwList = [];
  void setRW(String value) {
    selectedRW.value = value;
  }
  void setRT(String value) {
    selectedRT.value = value;
  }
  void setTanggalLahir(DateTime pickedDate) {
    final DateFormat formatter = DateFormat("dd MMMM yyyy");
    tanggalLahir.value = formatter.format(pickedDate);
  }
  void isPeek1(){
    lihat1.value = !lihat1.value;
  }
  void isPeek2(){
    lihat2.value = !lihat2.value;
  }
  var selectedImage = ''.obs;
  var valid = false.obs;

  // Method untuk memilih gambar dari galeri atau kamera
  Future<void> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      selectedImage.value = pickedFile.path; // Simpan path gambar yang dipilih
      valid.value = true; // Set gambar valid
    } else {
      print("Tidak ada gambar yang dipilih.");
      valid.value = false; // Tidak ada gambar yang dipilih
    }
    valid.value = false;
  }
  Future<void> getWilayah() async {
    final token = box.read('token');
    
    try {
      final response = await apiService.getWilayah(token);
      if(response != null && response['status'] == 'sukses'){
      final wilayah = response['wilayah'];
      for (var i in wilayah) {
        rwList.add({
          'rw': i['rw'],
          'jumlah_rt': List.generate(i['jumlah_rt'], (index) => (index + 1).toString().padLeft(2, '0')),
        });
      }
      }
    }catch (e) {
      print("Terjadi kesalahan saat mendapatkan wilayah");
    } finally {
    }
  }
  Future<void> updateGambarKK(String pathFile) async {
    isLoading.value = true;
    final token = box.read('token');
    
    try {
      final response = await apiService.updateGambarKK(pathFile, token);
      if (response != null && response['status'] == 'sukses') {
        Get.snackbar(
          'Sukses', 
          response['message'] ?? 'Gambar Kartu Keluarga berhasil diupload',
          backgroundColor: Colors.green.withOpacity(0.2),
          colorText: black,
          snackPosition: SnackPosition.TOP,
        );
      } else {
        Get.snackbar(
          'Gagal', 
          response?['message'] ?? 'Gambar Kartu Keluarga gagal diupload',
          backgroundColor: Colors.red.withOpacity(0.2),
          colorText: black,
          snackPosition: SnackPosition.TOP,
        );
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
  Future<void> getKeluarga() async {
    final token = box.read('token');
    
    try {
      final response = await apiService.getKeluarga(token);
      if (response != null && response['status'] == 'sukses') {
        keluarga.assignAll(List<Map<String, dynamic>>.from(response['keluarga']));
        update();
        
      } else {
        keluarga.assignAll(List<Map<String, dynamic>>.from(response?['keluarga']));
        update();
      }
    } catch (e) {
      print("Gagal silahkan coba lagi $e");
    }
  }
  Future<void> postKeluarga(String namaP, String nikP, String tempatLahirP, String ttlP, String peranP, String jenisKelaminP, String pendidikanP, String golDarahP, String pekerjaanP, String agamaP, String statusPerkawinanP) async {
    isLoading.value = true;
    final token = box.read('token');
    
    if(namaController.text.isEmpty || nikController.text.isEmpty || tempatLahirController.text.isEmpty || peran.value.isEmpty || jenisKelamin.value.isEmpty || agama.value.isEmpty || tanggalLahir.value.isEmpty || pendidikan.value.isEmpty || golonganDarah.value.isEmpty || pekerjaan.value.isEmpty || statusPerkawinan.value.isEmpty){
      Get.snackbar("Gagal", "Lengkapi seluruh data pribadi anda!", backgroundColor: gagal.withOpacity(0.5), colorText: white.withOpacity(0.8));
    }
    else if(nikController.text.length < 16){
      warn.value = "Gunakan NIK yang valid";
      galat.value = true;
    }
    else{
      final response = await apiService.postKeluarga(token, namaP, nikP, tempatLahirP, peranP, jenisKelaminP, pendidikanP, golDarahP, pekerjaanP, agamaP, ttlP, statusPerkawinanP);
      Future.delayed(const Duration(milliseconds: 250), () {
      if(response!=null && response['status'] == 'sukses'){
        Get.back();
        Get.snackbar("Berhasil", response['message'], backgroundColor: sukses.withOpacity(0.5), colorText: black.withOpacity(0.8));
        namaController.clear();
        nikController.clear();
        tempatLahirController.clear();
        peran.value = '';
        jenisKelamin.value = '';
        agama.value = '';
        tanggalLahir.value='';
        pendidikan.value = '';
        golonganDarah.value = '';
        pekerjaan.value = '';
        statusPerkawinan.value = '';
        warn.value = '';
        galat.value = false;
      }
      else if(response!=null && response['status'] == "perhatian"){
        Get.snackbar("Perhatian", response['message'], backgroundColor: gagal.withOpacity(0.5), colorText: white.withOpacity(0.8));
      }
      else {
        Get.snackbar("Gagal", "Gagal, silahkan coba lagi", backgroundColor: gagal.withOpacity(0.5), colorText: white.withOpacity(0.8));
      }
    });
    }
    isLoading.value = false;
  }
  Future<void> updateKeluarga(int wargaId, String namaP, String nikP, String tempatLahirP, String peranP, String jenisKelaminP, String pendidikanP, String golDarahP, String pekerjaanP, String agamaP, String statusPerkawinanP, String ttlP) async {
    final token = box.read('token');
    if(namaController.text.isEmpty || nikController.text.isEmpty || tempatLahirController.text.isEmpty || peran.value.isEmpty || jenisKelamin.value.isEmpty || agama.value.isEmpty || statusPerkawinan.value.isEmpty || tanggalLahir.value.isEmpty || pendidikan.value.isEmpty || golonganDarah.value.isEmpty || pekerjaan.value.isEmpty){
      Get.snackbar("Gagal", "Lengkapi seluruh data pribadi anda!", backgroundColor: gagal.withOpacity(0.5), colorText: white.withOpacity(0.8));
    }
    else if(nikController.text.length < 16){
      warn.value = "NIK anda kurang dari 16 digit";
      galat.value = true;
    }
    else{
      final response = await apiService.updateKeluarga(wargaId, namaP, nikP, tempatLahirP, peranP, jenisKelaminP,  agamaP, statusPerkawinanP, ttlP, pendidikanP, golDarahP, pekerjaanP, token);
      if(response!=null && response['status'] == 'sukses'){
        Get.back();
        Get.snackbar("Berhasil", response['message'], backgroundColor: sukses.withOpacity(0.5), colorText: black.withOpacity(0.8));
        namaController.clear();
        nikController.clear();
        tempatLahirController.clear();
        peran.value = '';
        jenisKelamin.value = '';
        agama.value = '';
        statusPerkawinan.value = '';
        tanggalLahir.value='';
        pendidikan.value = '';
        golonganDarah.value = '';
        pekerjaan.value = '';
        warn.value = '';
        galat.value = false;
      }
      else if(response!=null && response['status'] == "perhatian"){
        Get.snackbar("Perhatian", response['message'], backgroundColor: gagal.withOpacity(0.5), colorText: white.withOpacity(0.8));
      }
      else {
        Get.snackbar("Gagal", "Gagal, silahkan coba lagi", backgroundColor: gagal.withOpacity(0.5), colorText: white.withOpacity(0.8));
      }
    }
  }
  Future<void> deleteKeluarga(int wargaId) async {
    final token = box.read('token');
    
    final response = await apiService.deleteKeluarga(wargaId, token);
    if(response!=null){
      if(response['status'] == 'sukses'){
        Get.snackbar("Sukses", response['message'], backgroundColor: sukses.withOpacity(0.5), colorText: black.withOpacity(0.8));
      }
      else{
        Get.snackbar("Gagal", response['message'], backgroundColor: gagal.withOpacity(0.5), colorText: white.withOpacity(0.8));
      }
    }
    else {
      Get.snackbar("Gagal", "Gagal, silahkan coba lagi", backgroundColor: gagal.withOpacity(0.5), colorText: white.withOpacity(0.8));
    }
  }

  Future<void> getRekomPersonal() async {
    final token = box.read('token');
    
    try {
      final response = await apiService.getRekomPersonal(token);
      final response2 = await apiService.getUser(token);
      if(response != null && response['status'] == 'sukses' && response['rekom'] != null){
        checkRekom.value = true;
      }
      else if (response2!['users']['rt'] != "-" && response2['users']['rw'] != "-"){
        checkRekom.value = true;
      }
      else {
        checkRekom.value = false;
      }
    }catch (e) {
      print("Terjadi kesalahan saat mendapatkan rekom personal");
    } finally {
    }
  }
  Future<void> postRekom(int uId, String rt, String rw) async {
    final token = box.read('token');
    
    final response = await apiService.postRekom(token, uId, rt, rw);
    if(response!=null && response['status'] == 'sukses'){
      Get.back();
      Get.snackbar("Berhasil", response['message'], backgroundColor: sukses.withOpacity(0.5), colorText: white.withOpacity(0.8));
      selectedRT.value = '01';
      selectedRW.value = '01';
      getRekomPersonal();
    }
    else if(response!=null && response['status'] == "perhatian"){
      Get.snackbar("Perhatian", response['message'], backgroundColor: gagal.withOpacity(0.5), colorText: white.withOpacity(0.8));
    }
    else {
      Get.snackbar("Gagal", "Gagal, silahkan coba lagi", backgroundColor: gagal.withOpacity(0.5), colorText: white.withOpacity(0.8));
    }
  }
  
  Future<void> updatePassword(String password) async{
    final token = box.read('token');
    final response = await apiService.updatePassword(password, token);
    if(response!=null){
      if(response['status'] == 'sukses'){
        Get.snackbar("Berhasil", response['message'], backgroundColor: sukses.withOpacity(0.5), colorText: white.withOpacity(0.8));
      }
      else{
        Get.snackbar("Gagal", response['message'], backgroundColor: gagal.withOpacity(0.5), colorText: white.withOpacity(0.8));
      }
    }
    else{
        Get.snackbar("Gagal", "Gagal, Silahkan coba lagi", backgroundColor: gagal.withOpacity(0.5), colorText: white.withOpacity(0.8));
    }

  }
  void checkPasswordMatch() {isPasswordMatch.value = newPassword.value == confirmPassword.value;}
  @override
  void onInit() {
    getWilayah();
    super.onInit();
    getKeluarga();
    getRekomPersonal();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
