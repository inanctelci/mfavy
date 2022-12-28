import 'package:mfavymusic/controllers/subscription/subscription_controller.dart';
import 'package:purchases_flutter/models/customer_info_wrapper.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../../controllers/library/library_controller.dart';
import '../../controllers/navigation_bar/navigation_bar_controller.dart';
import '../../controllers/tops/daily_top_controller.dart';
import '../../export.dart';
import '../library/library_view.dart';
import '../widgets/main_drawer.dart';
import '../widgets/mini_player.dart';

class NavigationView extends StatelessWidget {
  const NavigationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LibraryController libraryController = Get.find<LibraryController>();
    NavigationBarController navigationBarController = Get.find<NavigationBarController>();
    SubsController subsController = Get.find<SubsController>();
    PageController pageController = PageController(viewportFraction: 0.99);

    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return WillPopScope(
      onWillPop: () async {
        if (pageController.page == 1) {
          navigationBarController.currentIndex = 0;
          pageController.animateToPage(0, duration: const Duration(milliseconds: 300), curve: Curves.ease);
          return false;
        } else {
          return false;
        }
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: const Color(0xFF252525),
        drawer: const MainDrawer(),
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          children: [
            HomeView(
              onDrawerTap: () {
                scaffoldKey.currentState!.openDrawer();
              },
            ),
            LibraryView(),
          ],
        ),
        floatingActionButton: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 5,
            ),
            MiniPlayer(),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
        bottomNavigationBar: Container(
          height: Get.height * 0.08,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0xFF252525).withOpacity(0.31),
                const Color(0xFF252525),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: BlurryContainer(
            blur: 16,
            borderRadius: BorderRadius.zero,
            height: 72,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 2,
                  child: GestureDetector(
                    onTap: () {
                      pageController.animateToPage(0, duration: const Duration(milliseconds: 300), curve: Curves.ease);
                      DailyTopController().update();
                      Future.delayed(
                        const Duration(milliseconds: 300),
                      );
                      navigationBarController.currentIndex = 0;
                      // Get.toNamed(NavigationConstants.home);
                    },
                    child: Obx(
                      () {
                        return SvgPicture.asset(
                          navigationBarController.currentIndex == 0 ? 'assets/icons/home-filled.svg' : 'assets/icons/home.svg',
                          height: 30,
                        );
                      },
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: GestureDetector(
                    onTap: () {
                      pageController.animateToPage(1, duration: const Duration(milliseconds: 300), curve: Curves.ease);
                      libraryController.update();
                      Future.delayed(
                        const Duration(milliseconds: 300),
                      );
                      navigationBarController.currentIndex = 1;
                      // Get.toNamed(NavigationConstants.library);
                    },
                    child: Obx(
                      () {
                        return SvgPicture.asset(
                          navigationBarController.currentIndex == 1 ? 'assets/icons/music-playlist-filled.svg' : 'assets/icons/music-library.svg',
                          height: 30,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
