import 'package:flutterframework/controllers/navigation_bar/navigation_bar_controller.dart';
import 'package:flutterframework/export.dart';

class BottomNavBar extends StatelessWidget {
  BottomNavBar({Key? key}) : super(key: key);
  NavigationBarController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Color(0xFF252525),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF252525).withOpacity(0.31),
              Color(0xFF252525),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: BlurryContainer(
          blur: 16,
          borderRadius: BorderRadius.zero,
          height: 72,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 2,
                child: GestureDetector(
                  onTap: () {
                    _controller.currentIndex = 0;
                    Get.toNamed(NavigationConstants.home);
                  },
                  child: Obx(
                    () {
                      return SvgPicture.asset(
                        _controller.currentIndex == 0 ? 'assets/icons/home-filled.svg' : 'assets/icons/home.svg',
                        height: 30,
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: GestureDetector(
                  onTap: () {
                    _controller.currentIndex = 1;
                    Get.toNamed(NavigationConstants.library);
                  },
                  child: Obx(
                    () {
                      return SvgPicture.asset(
                        _controller.currentIndex == 1 ? 'assets/icons/music-playlist-filled.svg' : 'assets/icons/music-library.svg',
                        height: 30,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
