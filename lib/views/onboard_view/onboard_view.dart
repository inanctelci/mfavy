import '../../controllers/onboard/onboard_controller.dart';
import '../../export.dart';

class OnboardView extends StatelessWidget {
  const OnboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OnBoardController controller = Get.put<OnBoardController>(OnBoardController());
    return Scaffold(
      backgroundColor: AppConstants.kAppBlack,
      appBar: AppBar(
        backgroundColor: AppConstants.kAppBlack,
        elevation: 0,
        leading: Obx(() {
          return controller.currentIndex > 0
              ? TextButton(
                  onPressed: () {
                    controller.pageController.value
                        .animateToPage(controller.currentIndex == 2 ? 1 : 0, duration: const Duration(milliseconds: 800), curve: Curves.ease);
                  },
                  child: const Text(
                    'Geri',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                )
              : const SizedBox();
        }),
        actions: [
          Obx(() {
            return controller.currentIndex == 2
                ? const SizedBox()
                : TextButton(
                    onPressed: () {
                      Get.offAllNamed(NavigationConstants.navigation);
                    },
                    child: const Text(
                      'Atla',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  );
          }),
        ],
      ),
      body: PageView(
        controller: controller.pageController.value,
        children: [
          const OnboardOne(),
          const OnboardTwo(),
          const OnboardThree(),
        ],
        onPageChanged: (value) {
          controller.currentIndex = value;
          print(value);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: Container(
        height: Get.width * 0.15,
        width: Get.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Obx(() {
                  return Container(
                    width: Get.width * 0.025,
                    margin: EdgeInsets.only(
                      left: Get.width * 0.04,
                      right: Get.width * 0.02,
                    ),
                    decoration: BoxDecoration(
                      color: controller.currentIndex == 0 ? AppConstants.kPrimaryColor : AppConstants.kAppGrey,
                      shape: BoxShape.circle,
                    ),
                  );
                }),
                Obx(() {
                  return Container(
                    width: Get.width * 0.025,
                    margin: EdgeInsets.only(
                      right: Get.width * 0.02,
                    ),
                    decoration: BoxDecoration(
                      color: controller.currentIndex == 1 ? AppConstants.kPrimaryColor : AppConstants.kAppGrey,
                      shape: BoxShape.circle,
                    ),
                  );
                }),
                Obx(() {
                  return Container(
                    width: Get.width * 0.025,
                    decoration: BoxDecoration(
                      color: controller.currentIndex == 2 ? AppConstants.kPrimaryColor : AppConstants.kAppGrey,
                      shape: BoxShape.circle,
                    ),
                  );
                }),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(right: Get.width * 0.04),
              child: ElevatedButton(
                onPressed: () {
                  if (controller.currentIndex < 2) {
                    controller.pageController.value
                        .animateToPage(controller.currentIndex == 0 ? 1 : 2, duration: const Duration(milliseconds: 800), curve: Curves.ease);
                  } else {
                    Get.offAndToNamed(NavigationConstants.navigation);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppConstants.kPrimaryColor,
                ),
                child: SizedBox(
                  width: Get.width * 0.1,
                  height: Get.height * 0.04,
                  child: Center(
                    child: Obx(() {
                      return Text(
                        controller.currentIndex < 2 ? 'İleri' : 'Başla',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Mulish-ExtraBold',
                          fontSize: Get.width * 0.03,
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: null,
        height: Get.height * 0.05,
      ),
    );
  }
}

class OnboardOne extends StatelessWidget {
  const OnboardOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.kAppBlack,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/onboard_3.png',
              width: Get.width * 0.8,
            ),
            SizedBox(
              height: Get.height * 0.1,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Get.width * 0.04,
                ),
                child: Text(
                  'En iyi müziğin adresine hoş geldin!.',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Mulish-Bold',
                    fontSize: Get.width * 0.05,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Get.width * 0.04,
                ),
                child: Text(
                  'En sevdiğin şarkıları dinle, puan ver\nsevdiğin şarkı listelerde üst sıraya çıksın.',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Mulish-Medium',
                    fontSize: Get.width * 0.04,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardTwo extends StatelessWidget {
  const OnboardTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.kAppBlack,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/onboard_2.png',
              width: Get.width * 0.8,
            ),
            SizedBox(
              height: Get.height * 0.1,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Get.width * 0.04,
                ),
                child: Text(
                  'Dinlemeyi sevdiğin müzikleri listene kaydet!',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Mulish-Bold',
                    fontSize: Get.width * 0.05,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Get.width * 0.04,
                ),
                child: Text(
                  'Yeni keşfettiğin veyaz vazgeçemediğin şarkıları listene kaydet. Dilediğin zaman tekrar dinle.',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Mulish-Medium',
                    fontSize: Get.width * 0.04,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardThree extends StatelessWidget {
  const OnboardThree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.kAppBlack,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/onboard_1.png',
              width: Get.width * 0.8,
            ),
            SizedBox(
              height: Get.height * 0.1,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Get.width * 0.04,
                ),
                child: Text(
                  'Çalma listeni arkadaşlarınla paylaş',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Mulish-Bold',
                    fontSize: Get.width * 0.05,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Get.width * 0.04,
                ),
                child: Text(
                  'Oluşturduğun çalma listesiyle DJ yeteneklerini sergile\narkadaşların müzik zevkine hayran kalsın!',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Mulish-Medium',
                    fontSize: Get.width * 0.04,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
