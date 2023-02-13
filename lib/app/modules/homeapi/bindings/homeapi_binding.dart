import 'package:get/get.dart';

import '../controllers/homeapi_controller.dart';

class HomeapiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeapiController>(
      () => HomeapiController(),
    );
  }
}
