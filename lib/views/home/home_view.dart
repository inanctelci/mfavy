import 'package:flutterframework/views/widgets/banner_ad.dart';

import '../../controllers/home_search/home_search_controller.dart';
import '../../export.dart';
import '../widgets/ad_helper.dart';
import 'components/home_handline.dart';
import 'components/search_bar.dart';
import 'components/search_view.dart';
import 'components/tabbar.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key, required this.onDrawerTap}) : super(key: key);

  final ThemeController themeController = Get.find();
  final UserController userController = Get.find();
  final HomeSearchController _searchController = Get.find();
  final VoidCallback onDrawerTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.kAppBlack,
      body: Theme(
        data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.fromSwatch(
          accentColor: Colors.white,
        )),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HomeHeadLine(
                  onTap: onDrawerTap,
                ),
                const SearchBar(),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Obx(() {
                  return _searchController.isSearching
                      ? SearchView()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: Get.width * 0.04,
                              ),
                              child: SizedBox(
                                height: Get.height * 0.03,
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.center,
                                      child: Container(
                                        height: 2,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Container(
                                        color: AppConstants.kAppBlack,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
                                          child: Text(
                                            'Üst Sıradakiler',
                                            style: TextStyle(
                                              fontFamily: 'Mulish-ExtraBold',
                                              fontSize: Get.width * 0.045,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: Get.height * 0.025,
                            ),
                            const TabBarWidget(),
                          ],
                        );
                }),
                const BannerAdWidget(),
              ],
            ),
          ),
        ),
      ),
      // bottomNavigationBar: Column(
      //   mainAxisSize: MainAxisSize.min,
      //   children: [
      //     MiniPlayer(),
      //     BottomNavBar(),
      //   ],
      // ),
    );
  }
}
