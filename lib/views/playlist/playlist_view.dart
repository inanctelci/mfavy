import 'package:flutterframework/controllers/scroll_controller/scroll_controller.dart';
import 'package:flutterframework/export.dart';
import 'package:flutterframework/views/widgets/song_card.dart';

class PlaylistView extends StatelessWidget {
  PlaylistView({Key? key}) : super(key: key);

  FocusNode _node = FocusNode();

  @override
  Widget build(BuildContext context) {
    PlaylistScrollController controller = Get.find();
    var _textController = controller.textController as TextEditingController;
    return Scaffold(
      backgroundColor: AppConstants.kAppBlack,
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: Get.height * 0.04,
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
                          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
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
                                    child: Obx(() {
                                      return TextFormField(
                                        controller: _textController,
                                        focusNode: _node,
                                        cursorColor: Colors.white,
                                        style: TextStyle(
                                          fontFamily: 'Mulish-Medium',
                                          color: Colors.white,
                                        ),
                                        onTap: () {
                                          _node.requestFocus();
                                          controller.isSearching = true;
                                        },
                                        decoration: InputDecoration(
                                          hintText: 'Ara',
                                          hintStyle: TextStyle(
                                            color: AppConstants.kHintText,
                                            fontFamily: 'Mulish-SemiBold',
                                          ),
                                          filled: true,
                                          fillColor: AppConstants.kAppGrey,
                                          contentPadding: EdgeInsets.all(1),
                                          prefixIcon: Padding(
                                            padding: EdgeInsets.all(Get.width * 0.04),
                                            child: SvgPicture.asset(
                                              'assets/icons/search.svg',
                                              color: Colors.white,
                                            ),
                                          ),
                                          suffixIcon: controller.isSearching
                                              ? GestureDetector(
                                                  onTap: () {
                                                    _textController.clear();
                                                    _node.unfocus();
                                                    controller.isSearching = false;
                                                  },
                                                  child: Icon(
                                                    Icons.close_rounded,
                                                    color: Colors.white,
                                                  ),
                                                )
                                              : SizedBox(),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8),
                                            borderSide: BorderSide(
                                              width: 2,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.09,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      controller.shuffle = !controller.shuffle;
                                    },
                                    child: Obx(() {
                                      return SvgPicture.asset(
                                        'assets/icons/shuffle.svg',
                                        color: controller.shuffle ? AppConstants.kPrimaryColor : AppConstants.kHintText,
                                      );
                                    }),
                                  ),
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
                          title: 'Ebru Gündeş - Demir attım yalnızlığa',
                          videoId: 'feQhHStBVLE',
                          widget: GestureDetector(
                            onTap: () {},
                            child: Container(
                              height: Get.height * 0.125,
                              width: Get.width * 0.32,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR5d7NQxPsQYQ18rSwd5t5vzMFl6rggWgSGTTpZ_8N_WA&s'),
                                ),
                              ),
                            ),
                          ),
                          imgUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR5d7NQxPsQYQ18rSwd5t5vzMFl6rggWgSGTTpZ_8N_WA&s',
                          rate: 'rate',
                          watch: 'watch',
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
                  horizontal: Get.width * 0.04,
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
                                              GestureDetector(
                                                onTap: () {
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                    SnackBar(
                                                      content: Container(
                                                        height: Get.height * 0.05,
                                                        width: Get.width,
                                                        decoration: BoxDecoration(
                                                          color: AppConstants.kAppGrey.withOpacity(0.8),
                                                          borderRadius: BorderRadius.circular(4),
                                                        ),
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(8.0),
                                                          child: Row(
                                                            children: [
                                                              SvgPicture.asset(
                                                                'assets/icons/trash.svg',
                                                                color: Colors.redAccent,
                                                              ),
                                                              SizedBox(
                                                                width: 5,
                                                              ),
                                                              Text(
                                                                'Çalma Listesi Silindi.',
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
                                                      backgroundColor: Colors.transparent,
                                                      elevation: 0,
                                                      behavior: SnackBarBehavior.floating,
                                                    ),
                                                  );
                                                  Get.back();
                                                  Get.back();
                                                },
                                                child: Row(
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
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                width: Get.width * 0.15,
                                height: Get.width * 0.15,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppConstants.kPrimaryColor,
                                ),
                                child: SvgPicture.asset('assets/icons/play.svg'),
                              ),
                            ),
                            controller.shuffle
                                ? Align(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                      width: Get.width * 0.05,
                                      height: Get.width * 0.05,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppConstants.kPrimaryColor,
                                        border: Border.all(
                                          color: AppConstants.kAppBlack,
                                        ),
                                      ),
                                      child: Center(
                                        child: SvgPicture.asset(
                                          'assets/icons/shuffle.svg',
                                          color: Colors.white,
                                          width: Get.width * 0.035,
                                        ),
                                      ),
                                    ),
                                  )
                                : SizedBox(),
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
