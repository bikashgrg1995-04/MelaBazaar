import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/others/extensions.dart';

import '../routes/route_name_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(
      const Duration(seconds: 5),
      () async {
        Get.offAllNamed(RouteNames.products);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 0.2.sh(context),
          ),
          SizedBox(
            height: 0.5.sh(context),
            width: 0.9.sw(context),
            child: Image.asset('assets/icons/logo.png'),
          ),
          SizedBox(
            height: 0.2.sh(context),
          ),
          // SpinKitThreeBounce(
          //   itemBuilder: (BuildContext context, int index) {
          //     return const DecoratedBox(
          //       decoration: BoxDecoration(
          //         color: Colors.black,
          //         shape: BoxShape.circle,
          //       ),
          //     );
          //   },
          // )
        ],
      ),
    );
  }
}
