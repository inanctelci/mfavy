import 'package:flutterframework/controllers/player_contoller/player_controller.dart';
import 'package:flutterframework/export.dart';
import 'package:flutterframework/views/widgets/song_card_shimmer.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeVideoPlayer extends StatelessWidget {
  YoutubeVideoPlayer({Key? key, required this.videoId}) : super(key: key);

  final String videoId;

  @override
  Widget build(BuildContext context) {
    PlayerController _playerController = Get.put(PlayerController());
    _playerController.init(videoId);
    return Center(
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: YoutubePlayer(
              actionsPadding: EdgeInsets.zero,
              controller: _playerController.youtubePlayerController,
              bottomActions: [],
              onReady: () {},
            ),
          ),
        ],
      ),
    );
  }
}
