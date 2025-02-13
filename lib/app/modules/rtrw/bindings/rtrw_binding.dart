import 'package:get/get.dart';

import '../controllers/rtrw_controller.dart';

class RtrwBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RtrwController>(
      () => RtrwController(),
    );
  }
}
