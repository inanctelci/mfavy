import 'package:flutterframework/export.dart';
class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ConnectionController());
  }
}
