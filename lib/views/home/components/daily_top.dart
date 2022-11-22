import 'package:flutterframework/controllers/mini_player/mini_player_controller.dart';
import 'package:flutterframework/export.dart';
import 'package:flutterframework/views/widgets/song_card.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

class DailyTop extends StatelessWidget {
  const DailyTop({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MiniPlayerController miniPlayerController = Get.find<MiniPlayerController>();
    return Scaffold(
      backgroundColor: AppConstants.kAppBlack,
      body: ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        itemCount: 10,
        separatorBuilder: (context, index) {
          return Column(
            children: [
              SizedBox(
                height: Get.height * 0.02,
              ),
              Container(
                height: Get.height * 0.0015,
                width: Get.width * 0.92,
                decoration: BoxDecoration(
                  color: AppConstants.kBoxGrey,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
            ],
          );
        },
        itemBuilder: (context, index) {
          return SongCard(
            showCrowns: false,
            index: index,
            title: 'Ebru Gündeş - Demir attım yalnızlığa',
            videoId: 'feQhHStBVLE',
            imgUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR5d7NQxPsQYQ18rSwd5t5vzMFl6rggWgSGTTpZ_8N_WA&s',
            rate: index == 1 ? '4' : null,
            watch: 'watch',
            onTap: () async {
              await miniPlayerController.player.value.setAudioSource(
                AudioSource.uri(
                  Uri.parse(
                    "https://www.youtube.film/Downloads/a/5/b/f/7/c/f/1/3/d/4/e/7/9/5/e/2/4/2/d/e/d/8/0/a/5/6/8/1/c/6/d/2Pac_Sade_-_Jezebel_Legendado.mp3",
                  ),
                  tag: MediaItem(
                    id: '1',
                    title: "SoundHelix",
                  ),
                ),
              );
              miniPlayerController.title = 'Ebru Gundes';
              miniPlayerController.buttons = true;
              miniPlayerController.isTapPlay = true;
              miniPlayerController.player.value.play();
            },
            widget: Image.network(
              'https://iasbh.tmgrup.com.tr/19c8c8/0/0/0/0/0/0?u=https://isbh.tmgrup.com.tr/sb/album/2021/09/19/1632038198585.jpg&mw=600&l=1',
              fit: BoxFit.cover,
            ),
          );
          ;
        },
      ),
    );
  }

  Widget getCrowns(int index) {
    switch (index) {
      case 0:
        return Center(
          child: SvgPicture.asset(
            'assets/icons/crown.svg',
            color: AppConstants.kCrownGold,
          ),
        );
      case 1:
        return Center(
          child: SvgPicture.asset(
            'assets/icons/crown.svg',
            color: AppConstants.kCrownSilver,
          ),
        );
      case 2:
        return Center(
          child: SvgPicture.asset(
            'assets/icons/crown.svg',
            color: AppConstants.kCrownBronze,
          ),
        );
      default:
        return Center(
          child: Text(
            (index + 1).toString(),
            style: const TextStyle(
              fontFamily: 'Mulish-ExtraBold',
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        );
    }
  }
}
