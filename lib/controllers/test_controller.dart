import 'package:mfavymusic/export.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TestController extends GetxController {
  late YoutubePlayerController controller1;
  late YoutubePlayerController controller2;
  late YoutubePlayerController controller3;
  late YoutubePlayerController controller4;

  @override
  void onInit() {
    controller1 = YoutubePlayerController(
      initialVideoId: 'jSoTzM-E4v0',
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        forceHD: true,
      ),
    );
    controller2 = YoutubePlayerController(
      initialVideoId: 'jSoTzM-E4v0',
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        forceHD: true,
      ),
    );
    controller3 = YoutubePlayerController(
      initialVideoId: 'jSoTzM-E4v0',
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        forceHD: true,
      ),
    );
    controller4 = YoutubePlayerController(
      initialVideoId: 'jSoTzM-E4v0',
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        forceHD: true,
      ),
    );

    super.onInit();
  }
}
