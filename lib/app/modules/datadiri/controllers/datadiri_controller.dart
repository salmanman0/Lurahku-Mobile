import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../data/api_service.dart';
import '../../../template/color_app.dart';

class DatadiriController extends GetxController {
  final RxList<Map<String, dynamic>> keluarga = <Map<String, dynamic>>[].obs;
  final apiService = Get.put(ApiService());
  final box = GetStorage();

  var checkRekom = false.obs;

  RxString selectedRW = '01'.obs;
  RxString selectedRT = '01'.obs;

  List<Map<String, dynamic>> rwList = [];
  void setRW(String value) {
    selectedRW.value = value;
  }
  void setRT(String value) {
    selectedRT.value = value;
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

   @override
  void onInit() {
    super.onInit();
    getKeluarga();
    getRekomPersonal();
  }
}
