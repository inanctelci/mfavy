import 'package:flutterframework/export.dart';
import 'package:flutterframework/views/widgets/bottom_nav_bar.dart';
import 'package:flutterframework/views/widgets/main_drawer.dart';

import 'components/home_handline.dart';
import 'components/search_bar.dart';
import 'components/tabbar.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);

  final ThemeController themeController = Get.find();
  final UserController userController = Get.find();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppConstants.kAppBlack,
      drawer: MainDrawer(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeHeadLine(
                onTap: () {
                  _scaffoldKey.currentState!.openDrawer();
                },
              ),
              SearchBar(),
              SizedBox(
                height: Get.height * 0.04,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
                child: Text(
                  'Üst Sıradakiler',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Mulish-ExtraBold',
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.025,
              ),
              TabBarWidget(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
