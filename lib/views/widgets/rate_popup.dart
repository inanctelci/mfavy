import 'package:flutter/gestures.dart';
import 'package:flutterframework/controllers/rate_controller/rate_controller.dart';
import 'package:flutterframework/export.dart';

class RatePopup extends StatelessWidget {
  const RatePopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RateController rateController = Get.put(RateController());
    return Container(
      width: double.infinity,
      height: Get.height * 0.3,
      decoration: BoxDecoration(
        color: AppConstants.kAppBlack,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          RichText(
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Ebru Gündeş',
                  style: TextStyle(fontFamily: 'Mulish-ExtraBold', fontSize: Get.width * 0.035),
                ),
                TextSpan(
                  text: ' - ',
                  style: TextStyle(fontFamily: 'Mulish-Medium', fontSize: Get.width * 0.035),
                ),
                TextSpan(
                  text: 'Demir attım yalnızlığa',
                  style: TextStyle(fontFamily: 'Mulish-Medium', fontSize: Get.width * 0.035),
                ),
              ],
            ),
          ),
          Text(
            'Puan ver',
            style: TextStyle(fontFamily: 'Mulish-Medium', fontSize: Get.width * 0.035, color: Colors.white),
          ),
          SizedBox(
            width: Get.width * 0.6,
            height: Get.height * 0.1,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              separatorBuilder: (context, index) {
                return SizedBox(
                  width: Get.width * 0.025,
                );
              },
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    rateController.tappedIndex = index + 1;
                  },
                  child: Obx(
                    () {
                      Duration(milliseconds: 200);
                      return SvgPicture.asset(
                        'assets/icons/star.svg',
                        width: Get.width * 0.1,
                        color: index + 1 <= rateController.tappedIndex ? AppConstants.kStarYellow : Colors.white,
                      );
                    },
                  ),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  Get.delete<RateController>();
                },
                child: Container(
                  height: Get.height * 0.04,
                  width: Get.width * 0.3,
                  decoration: BoxDecoration(
                    color: AppConstants.kHintText,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      'İptal',
                      style: TextStyle(
                        color: AppConstants.kAppBlack,
                        fontSize: Get.width * 0.04,
                        fontFamily: 'Mulish-Bold',
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: Get.width * 0.06,
              ),
              Obx(
                () {
                  return GestureDetector(
                    onTap: rateController.tappedIndex == 0
                        ? () {}
                        : () {
                            Navigator.pop(context);
                            Get.delete<RateController>();
                          },
                    child: Container(
                      height: Get.height * 0.04,
                      width: Get.width * 0.3,
                      decoration: BoxDecoration(
                        color: rateController.tappedIndex == 0 ? AppConstants.kHintText : AppConstants.kPrimaryColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          'Gönder',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: Get.width * 0.04,
                            fontFamily: 'Mulish-Bold',
                          ),
                        ),
                      ),
                    ),
                  );
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
