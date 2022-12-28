import 'package:mfavymusic/controllers/library/library_controller.dart';
import 'package:mfavymusic/export.dart';

class LibraryBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LibraryController());
  }
}
