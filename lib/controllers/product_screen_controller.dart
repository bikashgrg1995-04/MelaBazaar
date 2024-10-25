import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:task/models/products.dart';
import 'package:task/others/constants.dart';
import 'package:task/routes/api_routes.dart';

class ProductsController extends GetxController {
  static ProductsController instance = Get.find();
  late Dio dio;

  RxBool isLoading = false.obs;
  Rx<ProductDetail> productDetail =
      ProductDetail().obs; // Reactive variable for product

  RxList<String> imageList = <String>[].obs;

  // Constructor to initialize Dio
  ProductsController() {
    dio = Dio(); // Initialize Dio instance
  }

  Future<void> getData() async {
    try {
      logger.d("Fetching products");
      isLoading(true);
      // Sending a GET request to fetch user profile by ID
      final response = await dio.get(ApiRoutes().getProducts());

      // Log the entire response data for debugging
      logger.d("Response data: ${response.data}");

      if (response.statusCode == 200) {
        // Parse and store the fetched data
        productDetail.value = productDetailFromJson(json.encode(response.data));
      } else {
        Get.snackbar("Error", "Failed to fetch products data.");
        logger.d("Error fetching data: ${response.extra}");
      }
    } catch (e) {
      // Handle any errors that occur during the fetch
      Get.snackbar("Error", "An error occurred while fetching products data.");
      logger.e("Error fetching products data: $e");
      isLoading(false);
    } finally {
      isLoading.value = false; // Ensure loading state is updated
    }
  }
}
