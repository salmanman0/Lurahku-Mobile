import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../data/api_service.dart';

class RiwayatController extends GetxController {
  final box = GetStorage();
  final apiService = Get.put(ApiService());
  
  final RxList<Map<String, dynamic>> riwayat = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    getRiwayat(); 
  }

  Future<void> getRiwayat() async {
    final token = box.read('token');
    try {
      final response = await apiService.getRiwayat(token);
      if (response != null && response['status'] == 'sukses') {
        riwayat.assignAll(List<Map<String, dynamic>>.from(response['riwayat']));
      } else {
        print("tidak ada riwayat");
      }
    } catch (e) {
        print("gagal riwayat");
    }
  }
}
