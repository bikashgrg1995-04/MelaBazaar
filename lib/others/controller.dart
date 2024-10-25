import 'package:task/controllers/global_controller.dart';
import 'package:task/controllers/product_screen_controller.dart';

final ControllersInstance appCtrls = ControllersInstance._();

class ControllersInstance {
  ControllersInstance._();
  static ControllersInstance ctrl() => ControllersInstance._();

  GlobalController globalCtrl = GlobalController.instance;
  ProductsController productsController = ProductsController.instance;
}
