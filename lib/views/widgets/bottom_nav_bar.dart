import 'package:mfavymusic/controllers/navigation_bar/navigation_bar_controller.dart';
import 'package:mfavymusic/export.dart';

class BottomNavBar extends StatelessWidget {
  BottomNavBar({Key? key}) : super(key: key);
  final NavigationBarController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xFF252525).withOpacity(0.31),
              const Color(0xFF252525),
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
                    // Get.toNamed(NavigationConstants.home);
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
                    // Get.toNamed(NavigationConstants.library);
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
