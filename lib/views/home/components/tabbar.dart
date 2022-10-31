import 'package:flutterframework/export.dart';
import '../../../controllers/tabbar/tabbar_controller.dart';

import 'daily_top.dart';
import 'monthly_top.dart';
import 'weekly_top.dart';

class TabBarWidget extends StatelessWidget {
  TabBarWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TabBarController _tabController = Get.find();
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
          child: Container(
            width: Get.width,
            height: Get.height * 0.05,
            child: TabBar(
              controller: _tabController.controller,
              tabs: _tabController.myTabs,
              indicator: BoxDecoration(
                color: AppConstants.kAppGrey,
                borderRadius: BorderRadius.circular(4),
              ),
              labelStyle: TextStyle(
                fontFamily: 'Mulish-ExtraBold',
                fontSize: 12,
              ),
            ),
          ),
        ),
        SizedBox(
          height: Get.height * 0.025,
        ),
        Container(
          width: Get.width,
          height: Get.height * 1.6,
          child: TabBarView(
            controller: _tabController.controller,
            children: [DailyTop(), WeeklyTop(), MonthlyTop()],
          ),
        ),
      ],
    );
  }
}
