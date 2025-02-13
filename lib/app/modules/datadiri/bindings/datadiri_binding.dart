import 'package:get/get.dart';

import '../controllers/datadiri_controller.dart';

class DatadiriBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DatadiriController>(
      () => DatadiriController(),
    );
  }
}
