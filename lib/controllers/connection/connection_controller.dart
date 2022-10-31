import 'package:flutterframework/export.dart';
class ConnectionController extends GetxController {
  Connectivity connectivity = Connectivity();

  @override
  void onInit() {
    connectionListen();
    super.onInit();
  }

  connectionListen() {
    connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none && Get.currentRoute != NavigationConstants.connectionError) {
        Get.offAllNamed(NavigationConstants.connectionError);
      }
    });
  }

  checkConnection() async {
    ConnectivityResult result = await connectivity.checkConnectivity();
    if (result != ConnectivityResult.none) {
      Get.offAllNamed(NavigationConstants.home);
    } else {
      Get.snackbar('ConnectionError'.tr, 'YouAreNotConnectedToTheInternet'.tr, backgroundColor: Colors.black.withOpacity(0.5));
    }
  }
}
