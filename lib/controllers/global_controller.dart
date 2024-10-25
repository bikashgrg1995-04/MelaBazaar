import 'package:get/get.dart';

class GlobalController extends GetxController {
  static GlobalController instance = Get.find();

  RxBool isFirstTime = true.obs;
  RxBool internetConnection = false.obs;
}
