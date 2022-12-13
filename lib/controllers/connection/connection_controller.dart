import '../../export.dart';

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
      Get.offAllNamed(NavigationConstants.navigation);
    } else {
      Get.snackbar(
        'İnternet Bağlantısı Yok',
        'Lütfen internet bağlantınızı kontrol edip tekrar deneyiniz'.tr,
        titleText: Text(
          'İnternet Bağlantısı yok',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Mulish-ExtraBold',
          ),
        ),
        messageText: Text(
          'Lütfen internet bağlantınızı kontrol edip tekrar deneyiniz',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Mulish-SemiBold',
          ),
        ),
        backgroundColor: AppConstants.kBoxGrey,
      );
    }
  }
}
