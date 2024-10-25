import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/others/controller.dart';
import 'package:task/others/wigdets.dart';
import 'package:task/routes/route_name_manager.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
    super.initState();

    // Wait for the first frame to complete
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Access child elements here safely
      checkInternet();
      getProducts();
    });
  }

  getProducts() async {
    await appCtrls.productsController.getData();
  }

  checkInternet() async {
    appCtrls.globalCtrl.internetConnection.isTrue
        ? Get.snackbar(
            'Internet Connected',
            'Internet connection Successful.',
            snackPosition: SnackPosition.BOTTOM,
          )
        : Get.snackbar(
            'No Internet',
            'Please check your internet connection.',
            snackPosition: SnackPosition.BOTTOM,
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mela Bazaar"),
        elevation: 0,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.trolley))
        ],
      ),
      body: Obx(
        () {
          if (appCtrls.productsController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          final product = appCtrls.productsController.productDetail.value.data;

          if (product == null) {
            return const Center(child: Text('No product data available.'));
          }
//api only provide single data so I have design for single product
//else I have to use Listview or gridview and list the products accordingly.
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () => Get.toNamed(RouteNames.productDetail),
                    child: productContainer(context,
                        title: product.name.toString(),
                        image: product.image?.first.path.toString() ?? "",
                        price: product.price.toString(),
                        views: product.viewCount.toString(),
                        colors: product.specification!
                            .where((element) =>
                                element.type.toString().toLowerCase() ==
                                "colors")
                            .first
                            .value
                            .toString()),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
