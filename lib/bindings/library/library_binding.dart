import 'package:flutterframework/controllers/library/library_controller.dart';
import 'package:flutterframework/export.dart';

class LibraryBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LibraryController());
  }
}
