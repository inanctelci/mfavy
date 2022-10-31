import 'package:flutterframework/export.dart';

class NavigationBarController extends GetxController {
  // ignore: prefer_final_fields
  var _currentIndex = 0.obs;
  get currentIndex => _currentIndex.value;
  set currentIndex(value) => _currentIndex.value = value;
}
