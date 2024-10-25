import 'package:get/get.dart';
import 'package:task/routes/route_name_manager.dart';
import 'package:task/views/product_details.dart';
import 'package:task/views/products.dart';

class AppRoute {
  static final routes = [
    GetPage(
        name: RouteNames.products,
        page: () => const ProductScreen(),
        transition: Transition.fade),
    GetPage(
        name: RouteNames.productDetail,
        page: () => const ProductDetailScreen(),
        transition: Transition.fade),
  ];
}
