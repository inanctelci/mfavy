import 'package:mfavymusic/controllers/tops/monthly_top_controller.dart';
import 'package:mfavymusic/controllers/tops/weekly_top_controller.dart';

import '../../controllers/tops/daily_top_controller.dart';
import '../../controllers/home_search/home_search_controller.dart';
import '../../controllers/mini_player/mini_player_controller.dart';
import '../../controllers/navigation_bar/navigation_bar_controller.dart';
import '../../controllers/player_contoller/player_controller.dart';
import '../../controllers/tabbar/tabbar_controller.dart';
import '../../export.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ThemeController());
    Get.put(NavigationBarController());
    Get.put(TabBarController());
    Get.put(HomeSearchController());
    Get.put(MiniPlayerController());
    Get.put(PlayerController());
    Get.put(DailyTopController());
    Get.put(WeeklyTopController());
    Get.put(MonthlyTopController());
  }
}
