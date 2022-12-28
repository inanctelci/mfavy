import '../../export.dart';

class ChangeLanguageBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(LanguageController());
  }
}
