import 'package:flutterframework/controllers/scroll_controller/scroll_controller.dart';
import 'package:flutterframework/export.dart';

class PlaylistBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(PlaylistScrollController());
  }
}
