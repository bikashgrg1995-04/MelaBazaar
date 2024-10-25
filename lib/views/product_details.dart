import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:get/get.dart';
import 'package:task/others/controller.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Wait for the first frame to complete
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Access child elements here safely
      checkInternet();
      addImage();
    });
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

  addImage() {
    appCtrls.productsController.imageList.add(appCtrls
        .productsController.productDetail.value.data!.image!.first.path
        .toString());
    for (int i = 0;
        i <
            appCtrls.productsController.productDetail.value.data!
                .variantDetails!.length;
        i++) {
      appCtrls.productsController.imageList.add(appCtrls.productsController
          .productDetail.value.data!.variantDetails![i].image!.first.path
          .toString());
    }
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
      body: Column(
        children: [
          ImageSlideshow(
            /// Width of the [ImageSlideshow].
            width: double.infinity,

            /// Height of the [ImageSlideshow].
            height: 200,

            /// The page to show when first creating the [ImageSlideshow].
            initialPage: 0,

            /// The color to paint the indicator.
            indicatorColor: Colors.blue,

            /// The color to paint behind th indicator.
            indicatorBackgroundColor: Colors.grey,

            /// Auto scroll interval.
            /// Do not auto scroll with null or 0.
            autoPlayInterval: 3000,

            /// Loops back to first slide.
            isLoop: true,
            children: [
              for (int i = 0;
                  i < appCtrls.productsController.imageList.length;
                  i++)
                Image.network(
                  appCtrls.productsController.imageList[i],
                  fit: BoxFit.cover,
                ),
            ],
          )
        ],
      ),
    );
  }
}
