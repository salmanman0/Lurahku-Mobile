import 'package:get/get.dart';

import '../controllers/konfirmasi_warga_controller.dart';

class KonfirmasiWargaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KonfirmasiWargaController>(
      () => KonfirmasiWargaController(),
    );
  }
}
