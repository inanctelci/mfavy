import '../../../controllers/tabbar/tabbar_controller.dart';
import '../../../export.dart';
import 'daily_top.dart';
import 'monthly_top.dart';
import 'weekly_top.dart';

class TabBarWidget extends StatelessWidget {
  const TabBarWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TabBarController tabController = Get.find();
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
          child: Container(
            width: Get.width,
            height: Get.height * 0.05,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: AppConstants.kAppGrey,
            ),
            child: TabBar(
              controller: tabController.controller,
              tabs: tabController.myTabs,
              padding: EdgeInsets.zero,
              indicatorWeight: 0,
              indicator: BoxDecoration(
                color: AppConstants.kPrimaryColor,
                borderRadius: BorderRadius.circular(4),
              ),
              labelStyle: const TextStyle(
                fontFamily: 'Mulish-ExtraBold',
                fontSize: 12,
              ),
              onTap: ((value) {
                tabController.index.value = value;
              }),
            ),
          ),
        ),
        SizedBox(
          height: Get.height * 0.015,
        ),
        SizedBox(
          width: Get.width,
          height: Get.height * 10 * 0.17,
          child: TabBarView(
            clipBehavior: Clip.none,
            viewportFraction: 0.99,
            controller: tabController.controller,
            children: [DailyTop(), const WeeklyTop(), const MonthlyTop()],
          ),
        ),
      ],
    );
  }
}
