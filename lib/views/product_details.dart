import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:get/get.dart';
import 'package:task/others/controller.dart';
import 'package:task/others/extensions.dart';

import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

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
    final product = appCtrls.productsController.productDetail.value.data;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mela Bazaar"),
        elevation: 0,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.trolley))
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: _showMessageDialog, child: Icon(Icons.message_rounded)),
      body: Obx(() {
        // Check if imageList has images before displaying the slideshow
        if (appCtrls.productsController.imageList.isEmpty) {
          return const Center(
              child:
                  CircularProgressIndicator()); // Placeholder or loading indicator
        }

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.02.toRes(context)),
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                SizedBox(
                  height: 0.02.sh(context),
                ),
                Text(
                  product!.name.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 0.025.toRes(context),
                  ),
                ),
                SizedBox(
                  height: 0.01.sh(context),
                ),
                Text(
                  "NRs. ${product.strikePrice.toString()}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 0.014.toRes(context),
                  ),
                ),
                HtmlWidget(
                  product.description.toString(),
                  // select the render mode for HTML body
                  // by default, a simple `Column` is rendered
                  // consider using `ListView` or `SliverList` for better performance
                  renderMode: RenderMode.column,

                  // set the default styling for text
                  textStyle: TextStyle(fontSize: 14),
                ),
                SizedBox(
                  height: 0.01.sh(context),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    onPressed: () {
                      appCtrls.productsController.cartList
                          .add(appCtrls.productsController.productDetail.value);
                      Get.snackbar("Product Added.",
                          "Product is sucessfully added to cart");
                    },
                    child: const Text("Add to Cart"),
                  ),
                ),
                SizedBox(
                  height: 0.01.sh(context),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  // Function to show the message dialog
  void _showMessageDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController messageController = TextEditingController();

        return AlertDialog(
          title: const Text("Send a Message"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: messageController,
                decoration: const InputDecoration(
                  hintText: "Type your message here",
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                // Handle the sending message logic here
                String message = messageController.text;
                if (message.isNotEmpty) {
                  _sendPushNotification(message);
                  Navigator.of(context).pop(); // Close the dialog
                  Get.snackbar("Message Sent", "Your message has been sent.");
                } else {
                  Get.snackbar("Error", "Please enter a message.");
                }
              },
              child: const Text("Send"),
            ),
          ],
        );
      },
    );
  }

  void _sendPushNotification(String message) async {
    // Here you would usually call your backend service to send the notification
    // For demonstration purposes, we're simulating a push notification trigger.
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // Set the message payload
    String payload = 'Thank you for Contacting Us';

    // Send the notification (You would normally send this to a backend service)
    // For this example, we are just printing it
    print("Notification sent: $payload");

    // This would usually be where you handle actual notifications from the server
    Get.snackbar("Notification", payload);
  }
}
