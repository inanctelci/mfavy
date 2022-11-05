import 'package:flutterframework/controllers/scroll_controller/scroll_controller.dart';
import 'package:flutterframework/export.dart';
import 'package:flutterframework/views/widgets/song_card.dart';

class PlaylistView extends StatelessWidget {
  const PlaylistView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PlaylistScrollController controller = Get.find();
    return Scaffold(
      backgroundColor: AppConstants.kAppBlack,
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: Get.height * 0.06,
            ),
            child: Column(
              children: [
                Opacity(
                  opacity: controller.imageOpacity.clamp(0, 1.0),
                  child: Center(
                    child: Obx(() {
                      return Container(
                        width: controller.imageSize,
                        height: controller.imageSize,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: AssetImage('assets/images/ebrugundes.png'),
                          fit: BoxFit.cover,
                        )),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            controller: controller.controller,
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Container(
                  width: Get.width,
                  child: Padding(
                    padding: EdgeInsets.only(top: Get.height * 0.08),
                    child: Column(
                      children: [
                        SizedBox(height: controller.initialSize),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Türkçe pop listem',
                                style: TextStyle(
                                  fontFamily: 'Mulish-Medium',
                                  color: Colors.white,
                                  fontSize: Get.width * 0.05,
                                ),
                              ),
                              SizedBox(
                                height: Get.height * 0.05,
                              ),
                              Row(
                                children: [
                                  Container(
                                    height: Get.height * 0.06,
                                    width: Get.width * 0.5,
                                    decoration: BoxDecoration(
                                      color: AppConstants.kAppGrey,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: Get.width * 0.04,
                                        ),
                                        SvgPicture.asset(
                                          'assets/icons/search.svg',
                                          width: Get.width * 0.05,
                                        ),
                                        SizedBox(
                                          width: Get.width * 0.02,
                                        ),
                                        Text(
                                          'Ara',
                                          style: TextStyle(
                                            color: AppConstants.kHintText,
                                            fontSize: Get.width * 0.04,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.06,
                                  ),
                                  SvgPicture.asset('assets/icons/shuffle.svg'),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * 2,
                  child: ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return SongCard(
                          showCrowns: false,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: Get.height * 0.025,
                        );
                      },
                      itemCount: 12),
                ),
              ],
            ),
          ),
          Positioned(
            child: Obx(() {
              return AnimatedContainer(
                duration: Duration(milliseconds: 250),
                color: controller.showTopBar ? AppConstants.kAppGrey.withOpacity(1) : AppConstants.kAppGrey.withOpacity(0),
                padding: EdgeInsets.symmetric(
                  horizontal: Get.width * 0.06,
                  vertical: Get.height * 0.04,
                ),
                child: Container(
                  height: Get.height * 0.05,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        left: 0,
                        top: Get.height * 0.02,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: SvgPicture.asset('assets/icons/arrow-left.svg'),
                        ),
                      ),
                      Positioned(
                        top: Get.height * 0.02,
                        child: AnimatedOpacity(
                          duration: Duration(milliseconds: 250),
                          opacity: controller.showTopBar ? 1 : 0,
                          child: Text(
                            "Türkçe pop listem",
                            style: TextStyle(
                              fontFamily: 'Mulish-Medium',
                              color: Colors.white,
                              fontSize: Get.width * 0.05,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        top: Get.height * 0.02,
                        child: GestureDetector(
                          onTap: controller.showTopBar
                              ? () {}
                              : () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Dialog(
                                        alignment: Alignment.bottomCenter,
                                        insetPadding: EdgeInsets.zero,
                                        child: Container(
                                          width: Get.width,
                                          height: Get.height * 0.16,
                                          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.08, vertical: Get.width * 0.04),
                                          color: AppConstants.kAppBlack,
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  SvgPicture.asset(
                                                    'assets/icons/trash.svg',
                                                    color: AppConstants.kPrimaryColor,
                                                    width: Get.width * 0.06,
                                                  ),
                                                  SizedBox(
                                                    width: Get.width * 0.05,
                                                  ),
                                                  Text(
                                                    'Çalma listesini sil',
                                                    style: TextStyle(
                                                      fontFamily: 'Mulish-SemiBold',
                                                      fontSize: Get.width * 0.04,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: Get.height * 0.03,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return Dialog(
                                                        alignment: Alignment.bottomCenter,
                                                        insetPadding: EdgeInsets.zero,
                                                        child: Container(
                                                          height: Get.height * 0.45,
                                                          width: Get.width,
                                                          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.08, vertical: Get.width * 0.04),
                                                          color: AppConstants.kAppBlack,
                                                          child: Column(
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  SvgPicture.asset(
                                                                    'assets/icons/instagram.svg',
                                                                    color: AppConstants.kPrimaryColor,
                                                                    width: Get.width * 0.08,
                                                                  ),
                                                                  SizedBox(
                                                                    width: Get.width * 0.05,
                                                                  ),
                                                                  Text(
                                                                    'İnstagram\'da paylaş',
                                                                    style: TextStyle(
                                                                      fontFamily: 'Mulish-SemiBold',
                                                                      fontSize: Get.width * 0.04,
                                                                      color: Colors.white,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: Get.height * 0.03,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  SvgPicture.asset(
                                                                    'assets/icons/whatsapp.svg',
                                                                    color: AppConstants.kPrimaryColor,
                                                                    width: Get.width * 0.08,
                                                                  ),
                                                                  SizedBox(
                                                                    width: Get.width * 0.05,
                                                                  ),
                                                                  Text(
                                                                    'Whatsapp\'da paylaş',
                                                                    style: TextStyle(
                                                                      fontFamily: 'Mulish-SemiBold',
                                                                      fontSize: Get.width * 0.04,
                                                                      color: Colors.white,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: Get.height * 0.03,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  SvgPicture.asset(
                                                                    'assets/icons/twitter.svg',
                                                                    color: AppConstants.kPrimaryColor,
                                                                    width: Get.width * 0.08,
                                                                  ),
                                                                  SizedBox(
                                                                    width: Get.width * 0.05,
                                                                  ),
                                                                  Text(
                                                                    'Twitter\'da paylaş',
                                                                    style: TextStyle(
                                                                      fontFamily: 'Mulish-SemiBold',
                                                                      fontSize: Get.width * 0.04,
                                                                      color: Colors.white,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: Get.height * 0.03,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  SvgPicture.asset(
                                                                    'assets/icons/sms.svg',
                                                                    color: AppConstants.kPrimaryColor,
                                                                    width: Get.width * 0.08,
                                                                  ),
                                                                  SizedBox(
                                                                    width: Get.width * 0.05,
                                                                  ),
                                                                  Text(
                                                                    'Sms ile paylaş',
                                                                    style: TextStyle(
                                                                      fontFamily: 'Mulish-SemiBold',
                                                                      fontSize: Get.width * 0.04,
                                                                      color: Colors.white,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: Get.height * 0.03,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  SvgPicture.asset(
                                                                    'assets/icons/sms.svg',
                                                                    color: AppConstants.kPrimaryColor,
                                                                    width: Get.width * 0.08,
                                                                  ),
                                                                  SizedBox(
                                                                    width: Get.width * 0.05,
                                                                  ),
                                                                  Text(
                                                                    'Eposta ile paylaş',
                                                                    style: TextStyle(
                                                                      fontFamily: 'Mulish-SemiBold',
                                                                      fontSize: Get.width * 0.04,
                                                                      color: Colors.white,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: Get.height * 0.03,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  SvgPicture.asset(
                                                                    'assets/icons/link.svg',
                                                                    color: AppConstants.kPrimaryColor,
                                                                    width: Get.width * 0.08,
                                                                  ),
                                                                  SizedBox(
                                                                    width: Get.width * 0.05,
                                                                  ),
                                                                  Text(
                                                                    'Linki kopyala',
                                                                    style: TextStyle(
                                                                      fontFamily: 'Mulish-SemiBold',
                                                                      fontSize: Get.width * 0.04,
                                                                      color: Colors.white,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  );
                                                },
                                                child: Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/icons/share.svg',
                                                      color: AppConstants.kPrimaryColor,
                                                      width: Get.width * 0.06,
                                                    ),
                                                    SizedBox(
                                                      width: Get.width * 0.05,
                                                    ),
                                                    Text(
                                                      'Paylaş',
                                                      style: TextStyle(
                                                        fontFamily: 'Mulish-SemiBold',
                                                        fontSize: Get.width * 0.04,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                          child: SvgPicture.asset(
                            'assets/icons/more.svg',
                            color: controller.showTopBar ? Colors.white.withOpacity(0) : Colors.white.withOpacity(1),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        top: Get.height * 0.05 + controller.buttonPosition.clamp(0, double.infinity),
                        child: Stack(
                          children: [
                            Container(
                              width: Get.width * 0.15,
                              height: Get.width * 0.15,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppConstants.kPrimaryColor,
                              ),
                              child: SvgPicture.asset('assets/icons/play.svg'),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
