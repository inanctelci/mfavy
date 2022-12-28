import 'package:mfavymusic/export.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PlayerController extends GetxController {
  late YoutubePlayerController youtubePlayerController;
  final RxBool _isTappedPlay = false.obs;
  final RxDouble _position = 0.0.obs;

  get isTappedPlay => _isTappedPlay.value;
  set isTappedPlay(value) => _isTappedPlay.value = value;

  get position => _position.value;
  set position(value) => _position.value = value;

  void init(String videoId) {
    youtubePlayerController = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        enableCaption: false,
        disableDragSeek: true,
        useHybridComposition: false,
        showLiveFullscreenButton: false,
      ),
    );
    youtubePlayerController.addListener(() {
      position = youtubePlayerController.value.position.inSeconds.toDouble();
    });
  }

  @override
  void onClose() {
    youtubePlayerController.pause();
    super.onClose();
  }

  @override
  void dispose() {
    youtubePlayerController.dispose();
    super.dispose();
  }
}
