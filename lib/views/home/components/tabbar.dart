import '../../../controllers/tabbar/tabbar_controller.dart';
import '../../../controllers/tops/daily_top_controller.dart';
import '../../../controllers/tops/monthly_top_controller.dart';
import '../../../controllers/tops/weekly_top_controller.dart';
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
                switch (value) {
                  case 0:
                    DailyTopController().tapCounter += 1;
                    if (DailyTopController().tapCounter == 2) {
                      DailyTopController().update();
                      DailyTopController().tapCounter = 0;
                    }
                    break;
                  case 1:
                    WeeklyTopController().tapCounter += 1;
                    if (WeeklyTopController().tapCounter == 2) {
                      WeeklyTopController().update();
                      WeeklyTopController().tapCounter = 0;
                    }
                    break;
                  case 2:
                    MonthlyTopController().tapCounter += 1;
                    if (MonthlyTopController().tapCounter == 2) {
                      MonthlyTopController().update();
                      MonthlyTopController().tapCounter = 0;
                    }
                    break;
                  default:
                    break;
                }
              }),
            ),
          ),
        ),
        SizedBox(
          height: Get.height * 0.015,
        ),
        SizedBox(
          width: Get.width,
          height: (Get.height * 0.158 * 9) + (4 * Get.height * 0.21) + (Get.height * 0.0775 * 4) + (Get.height * 0.2),
          child: TabBarView(
            clipBehavior: Clip.hardEdge,
            viewportFraction: 0.99,
            controller: tabController.controller,
            children: [DailyTop(), WeeklyTop(), MonthlyTop()],
          ),
        ),
      ],
    );
  }
}
