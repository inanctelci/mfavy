import 'package:flutterframework/export.dart';
import 'package:shimmer/shimmer.dart';

class SongCardShimmer extends StatelessWidget {
  const SongCardShimmer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.withOpacity(0.3),
        highlightColor: Colors.white.withOpacity(0.2),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.01),
          height: Get.height * 0.15,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: AppConstants.kBoxGrey.withOpacity(0.5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: Get.height * 0.125,
                width: Get.width * 0.32,
                decoration: BoxDecoration(
                  color: AppConstants.kBoxGrey,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              SizedBox(
                width: Get.width * 0.02,
              ),
              SizedBox(
                height: Get.height * 0.125,
                width: Get.width * 0.54,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: Get.height * 0.054,
                      color: AppConstants.kBoxGrey,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: Get.height * 0.018,
                              width: Get.width * 0.1,
                              color: AppConstants.kBoxGrey,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              height: Get.height * 0.018,
                              width: Get.width * 0.1,
                              color: AppConstants.kBoxGrey,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              height: Get.width * 0.08,
                              width: Get.width * 0.08,
                              decoration: BoxDecoration(
                                color: AppConstants.kBoxGrey,
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Container(
                              height: Get.width * 0.08,
                              width: Get.width * 0.08,
                              decoration: BoxDecoration(
                                color: AppConstants.kBoxGrey,
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Container(
                              height: Get.width * 0.08,
                              width: Get.width * 0.08,
                              decoration: BoxDecoration(
                                color: AppConstants.kBoxGrey,
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
