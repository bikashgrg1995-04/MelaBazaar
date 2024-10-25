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
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      addImage();
    });
  }

  addImage() {
    appCtrls.productsController.imageList.add(
      appCtrls.productsController.productDetail.value.data!.image!.first.path
          .toString(),
    );
    for (int i = 0;
        i <
            appCtrls.productsController.productDetail.value.data!
                .variantDetails!.length;
        i++) {
      appCtrls.productsController.imageList.add(
        appCtrls.productsController.productDetail.value.data!.variantDetails![i]
            .image!.first.path
            .toString(),
      );
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
      body: Obx(() {
        // Check if imageList has images before displaying the slideshow
        if (appCtrls.productsController.imageList.isEmpty) {
          return Center(
              child:
                  CircularProgressIndicator()); // Placeholder or loading indicator
        }

        return Column(
          children: [
            ImageSlideshow(
              width: double.infinity,
              height: 200,
              initialPage: 0,
              indicatorColor: Colors.blue,
              indicatorBackgroundColor: Colors.grey,
              autoPlayInterval: 3000,
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
            ),
          ],
        );
      }),
    );
  }
}
