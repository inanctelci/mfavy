import '../../controllers/deeplink/deeplink_controller.dart';
import '../../controllers/future/future_controller.dart';
import '../../controllers/subscription/subscription_controller.dart';
import '../../export.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ConnectionController());
    Get.put(FutureContoller());
    Get.put(SubsController());
    Get.put(DeepLinkController());
    // Get.put(NativeAdController());
    // Get.put(BannerAdController());
  }
}
