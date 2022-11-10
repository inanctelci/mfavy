import 'package:flutterframework/controllers/home_search/home_search_controller.dart';
import 'package:flutterframework/controllers/navigation_bar/navigation_bar_controller.dart';
import 'package:flutterframework/controllers/tabbar/tabbar_controller.dart';
import 'package:flutterframework/export.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ThemeController());
    Get.put(UserController());
    Get.put(NavigationBarController());
    Get.put(TabBarController());
    Get.put(HomeSearchController());
  }
}
