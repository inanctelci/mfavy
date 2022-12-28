import '../../../controllers/subscription/subscription_controller.dart';
import '../../../export.dart';
import '../../navigation/components/premium_plan.dart';
import '../../navigation/components/remove_ads.dart';

class HomeHeadLine extends StatelessWidget {
  const HomeHeadLine({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    SubsController subsController = Get.find<SubsController>();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
      height: Get.height * 0.1,
      color: AppConstants.kAppBlack,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: onTap,
                child: Padding(
                  padding: EdgeInsets.only(right: Get.width * 0.03),
                  child: const Icon(
                    Icons.menu_rounded,
                    color: AppConstants.kPrimaryColor,
                  ),
                ),
              ),
              Text(
                'MFavy'.tr,
                style: TextStyle(
                  color: AppConstants.kPrimaryColor,
                  fontFamily: 'Gvtime',
                  fontSize: Get.width * 0.11,
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    insetAnimationCurve: Curves.ease,
                    insetPadding: EdgeInsets.zero,
                    alignment: Alignment.bottomCenter,
                    child: subsController.currentPlan.value == 0 ? const RemoveAds() : const PremiumPlan(),
                  );
                },
              );
            },
            child: subsController.currentPlan.value == 0
                ? Container(
                    width: Get.width * 0.4,
                    height: Get.height * 0.04,
                    decoration: BoxDecoration(
                      color: AppConstants.kPrimaryColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/icons/ads.svg',
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: Get.width * 0.01,
                          ),
                          Text(
                            'Reklamları Kaldır',
                            style: TextStyle(
                              fontFamily: 'Mulish-ExtraBold',
                              color: Colors.white,
                              fontSize: Get.width * 0.03,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Container(
                    width: Get.width * 0.4,
                    height: Get.height * 0.04,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: AppConstants.kPrimaryColor),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/icons/crown.svg',
                            color: AppConstants.kPrimaryColor,
                          ),
                          SizedBox(
                            width: Get.width * 0.01,
                          ),
                          Text(
                            'Premium',
                            style: TextStyle(
                              fontFamily: 'Mulish-ExtraBold',
                              color: Colors.white,
                              fontSize: Get.width * 0.03,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
