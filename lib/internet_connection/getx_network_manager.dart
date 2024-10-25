import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:task/others/controller.dart';

class GetXNetworkManager extends GetxController {
  static GetXNetworkManager instance = Get.find();
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription _streamSubscription;

  @override
  void onInit() {
    super.onInit();
    getConnectivityType();
    _streamSubscription = _connectivity.onConnectivityChanged
        .listen((List<ConnectivityResult> results) {
      if (results.isNotEmpty) {
        _updateState(results.first); // Take the first result
      }
    });
  }

  Future<void> getConnectivityType() async {
    late ConnectivityResult connectivityResult;
    try {
      final List<ConnectivityResult> results =
          await _connectivity.checkConnectivity();
      connectivityResult =
          results.isNotEmpty ? results.first : ConnectivityResult.none;
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    return _updateState(connectivityResult);
  }

  _updateState(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.wifi || ConnectivityResult.mobile:
        appCtrls.globalCtrl.internetConnection.value = true;

        break;

      case ConnectivityResult.none:
        appCtrls.globalCtrl.internetConnection.value = false;
        break;
      default:
        break;
    }
    update();
    //logger.d("Network Change Type ${connectionType.value}");
  }

  @override
  void onClose() {
    _streamSubscription.cancel();
  }
}
