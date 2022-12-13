import 'package:flutterframework/controllers/player_contoller/player_controller.dart';
import 'package:flutterframework/export.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeVideoPlayer extends StatelessWidget {
  const YoutubeVideoPlayer({Key? key, required this.videoId}) : super(key: key);

  final String videoId;

  @override
  Widget build(BuildContext context) {
    PlayerController playerController = Get.find<PlayerController>();
    playerController.init(videoId);
    return Center(
      child: YoutubePlayer(
        aspectRatio: Get.width * 0.32 / Get.height * 0.125,
        width: Get.width * 0.32,
        controller: playerController.youtubePlayerController,
        bottomActions: [
          SizedBox(
            width: Get.width * 0.26,
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: 4,
                thumbShape: const RoundSliderThumbShape(
                  enabledThumbRadius: 6,
                  pressedElevation: 6,
                ),
                overlayShape: const RoundSliderOverlayShape(
                  overlayRadius: 1,
                ),
                activeTrackColor: Colors.white,
                inactiveTrackColor: AppConstants.kAppBlack,
                thumbColor: AppConstants.kHintText,
                overlayColor: Colors.white,
              ),
              child: Obx(() {
                return Slider(
                  min: 0,
                  max: playerController.youtubePlayerController.value.metaData.duration.inSeconds.toDouble(),
                  value: playerController.position ?? 0,
                  onChanged: (value) {
                    playerController.youtubePlayerController.seekTo(
                      Duration(
                        seconds: value.toInt(),
                      ),
                    );
                  },
                );
              }),
            ),
          )
        ],
        onReady: () {},
        onEnded: (metaData) {
          playerController.youtubePlayerController.load(metaData.videoId);
        },
      ),
    );
  }
}
