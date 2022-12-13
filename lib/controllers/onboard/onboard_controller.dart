import 'package:flutterframework/export.dart';

class OnBoardController extends GetxController {
  RxInt _currentIndex = 0.obs;
  Rx<PageController> pageController = PageController(viewportFraction: 0.99).obs;

  // get pageController => _pageController.value;
  // set pageController(value) => _pageController.value = value;
  get currentIndex => _currentIndex.value;
  set currentIndex(value) => _currentIndex.value = value;
}
