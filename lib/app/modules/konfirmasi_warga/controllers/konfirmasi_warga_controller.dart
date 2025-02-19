import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../data/api_service.dart';
import '../../../template/color_app.dart';

class KonfirmasiWargaController extends GetxController {
  final box = GetStorage();
  final apiService = Get.put(ApiService());

  final RxList<Map<String, dynamic>> wargaRekom = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> suratRekom = <Map<String, dynamic>>[].obs;
  
  final noteController = TextEditingController();
  var warn = ''.obs;
  var kebenaran = false.obs;
  RxBool isLoading = false.obs;
  
  @override
  void onInit() {
    super.onInit();
    getRekom(); // Memanggil data saat controller diinisialisasi
    getSurat();
  }

  Future<void> getRekom() async {
    final token = box.read('token');
    try {
      final response = await apiService.getRekom(token);
      if (response != null && response['status'] == 'sukses') {
        wargaRekom.assignAll(List<Map<String, dynamic>>.from(response['rekom']));
      } else {
        print("Data rekom tidak ditemukan");
      }
    } catch (e) {
      print("Terjadi kesalahan saat mendapatkan rekom");
    }
  }
  Future<void> getSurat() async {
    final token = box.read('token');
    try {
      final response = await apiService.getSurat(token);
      if (response != null && response['status'] == 'sukses') {
        suratRekom.assignAll(List<Map<String, dynamic>>.from(response['surat']));
      } else {
        print("Data surat tidak ditemukan");
      }
    } catch (e) {
      print("Terjadi kesalahan saat mendapatkan surat");
    }
  }

  Future<void> updateRekom(int rekomId, String status) async {
    final token = box.read('token');
    try {
      final response = await apiService.updateRekom(rekomId, status, token);
      if (response != null) {
        if(response['status'] == 'sukses'){
        }
        else{
          Get.snackbar("Gagal", response['message']);
        }
      } else {
        Get.snackbar("Informasi", "Data warga tidak ditemukan");
      }
    } catch (e) {
      Get.snackbar("Gagal", "Terjadi kesalahan saat mendapatkan data");
    }
  }
  Future<void> updateSuratAccept(int suratId) async {
    final token = box.read('token');
    var catatan = noteController.text;
    try {
      isLoading.value = true;
      final response = await apiService.updateSuratAccept(token, suratId, catatan);
      if (response != null) {
        if(response['status'] == 'sukses'){
          Get.snackbar("Berhasil", response['message']);
          
        }
        else{
          Get.snackbar("Gagal", response['message']);
        }
      } else {
        Get.snackbar("Informasi", "Data warga tidak ditemukan");
      }
    } catch (e) {
      Get.snackbar("Gagal", "Terjadi kesalahan saat mendapatkan data");
    }
    finally{
      isLoading.value = false;
      noteController.clear();
      getSurat();
    }
  }
  Future<void> updateSuratReject(int suratId) async {
    final token = box.read('token');
    if (noteController.text.isNotEmpty){
      warn.value = "";
      kebenaran.value = false;
      var catatan = noteController.text;
      try {
        final response = await apiService.updateSuratReject(token, suratId, catatan);
        if (response != null) {
          if(response['status'] == 'sukses'){
            Get.snackbar("Berhasil", response['message']);
          }
          else{
            Get.snackbar("Gagal", response['message']);
          }
        } else {
          Get.snackbar("Informasi", "Data warga tidak ditemukan");
        }
      } catch (e) {
        Get.snackbar("Gagal", "Terjadi kesalahan saat mendapatkan data");
      }
      finally{
        noteController.clear();
      }
    }
    else{
      warn.value = "Silahkan isi kolom alasan penolakan";
      kebenaran.value = true;
      getSurat();
    }
  }

  Future<void> deleteRekom(int rekomId) async {
    final token = box.read('token');
    final response = await apiService.deleteRekom(rekomId, token);
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
}
