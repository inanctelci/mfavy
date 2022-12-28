import '../../controllers/home_search/home_search_controller.dart';
import '../../controllers/subscription/subscription_controller.dart';
import '../../export.dart';
import '../widgets/banner_ad.dart';
import 'components/home_handline.dart';
import 'components/search_bar.dart';
import 'components/search_view.dart';
import 'components/tabbar.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key, required this.onDrawerTap}) : super(key: key);

  final ThemeController themeController = Get.find();
  final HomeSearchController _searchController = Get.find();
  final VoidCallback onDrawerTap;
  SubsController subsController = Get.find<SubsController>();
  // BannerAdController bannerAdController = Get.find<BannerAdController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.kAppBlack,
      body: Theme(
        data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.fromSwatch(
          accentColor: Colors.white,
        )),
        child: GetBuilder<HomeSearchController>(builder: (context) {
          return SingleChildScrollView(
            controller: _searchController.scrollController,
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  HomeHeadLine(
                    onTap: onDrawerTap,
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  const SearchBar(),
                  subsController.currentPlan.value == 0
                      ? Column(
                          children: [
                            SizedBox(
                              height: Get.height * 0.02,
                            ),
                            BannerAdWidget(),
                          ],
                        )
                      : const SizedBox(),
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
                ],
              ),
            ),
          );
        }),
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
