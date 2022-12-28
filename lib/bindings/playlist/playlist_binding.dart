import 'package:mfavymusic/controllers/scroll_controller/scroll_controller.dart';
import 'package:mfavymusic/export.dart';

class PlaylistBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(PlaylistScrollController());
  }
}
