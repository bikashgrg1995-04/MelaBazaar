import 'package:get/get.dart';
import 'package:task/controllers/global_controller.dart';
import 'package:task/controllers/product_screen_controller.dart';
import 'package:task/internet_connection/getx_network_manager.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(GetXNetworkManager());
    Get.put(GlobalController());
    Get.lazyPut(() => ProductsController());
    // Get.lazyPut(() => LoginController());
    // Get.put(AuthController());
    // Get.lazyPut(() => DonorScreenController());
    // Get.lazyPut(() => RequestScreenController());
  }

  // static afterNeworkCheck() {7
  //   Get.put(AuthController(), permanent: true);
  //   Get.lazyPut(() => AuthController());
  // }

  static lateInit() {
    // Get.put(NavigationController());
  }
}
