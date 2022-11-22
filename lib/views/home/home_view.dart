import 'package:audio_session/audio_session.dart';
import 'package:flutterframework/controllers/home_search/home_search_controller.dart';
import 'package:flutterframework/export.dart';
import 'package:flutterframework/views/home/components/search_view.dart';
import 'package:flutterframework/views/widgets/ad_widget.dart';
import 'package:flutterframework/views/widgets/bottom_nav_bar.dart';
import 'package:flutterframework/views/widgets/main_drawer.dart';
import 'package:flutterframework/views/widgets/mini_player.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

import 'components/home_handline.dart';
import 'components/search_bar.dart';
import 'components/tabbar.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);

  final ThemeController themeController = Get.find();
  final UserController userController = Get.find();
  final HomeSearchController _searchController = Get.find();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _player = AudioPlayer();

  Future<void> _init() async {
    // Inform the operating system of our app's audio attributes etc.
    // We pick a reasonable default for an app that plays speech.
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());
    // Listen to errors during playback.
    _player.playbackEventStream.listen((event) {}, onError: (Object e, StackTrace stackTrace) {
      print('A stream error occurred: $e');
    });
    // Try to load audio from a source and catch any errors.
    try {
      await _player.setAudioSource(
        AudioSource.uri(
          Uri.parse("https://ip132.ozelip.com/8070/stream"),
          tag: MediaItem(
            id: '1',
            title: "Radyo Frekans",
            artUri: Uri.parse("http://www.radyofrekans.com.tr/images/frekans-logo.png"),
          ),
        ),
      );
    } catch (e) {
      print("Error loading audio source: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    _init();
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppConstants.kAppBlack,
      drawer: MainDrawer(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeHeadLine(
                onTap: () {
                  _scaffoldKey.currentState!.openDrawer();
                },
              ),
              SearchBar(),
              SizedBox(
                height: Get.height * 0.04,
              ),
              Obx(() {
                return _searchController.isSearching
                    ? SearchView()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
                            child: Text(
                              'Üst Sıradakiler',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Mulish-ExtraBold',
                                fontSize: 16,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.025,
                          ),
                          TabBarWidget(),
                        ],
                      );
              }),
              AdWidget(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
      floatingActionButton: MiniPlayer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
    );
  }
}

class ControlButtons extends StatelessWidget {
  final AudioPlayer player;

  const ControlButtons(this.player, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width * 0.2,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// This StreamBuilder rebuilds whenever the player state changes, which
          /// includes the playing/paused state and also the
          /// loading/buffering/ready state. Depending on the state we show the
          /// appropriate button or loading indicator.
          StreamBuilder<PlayerState>(
            stream: player.playerStateStream,
            builder: (context, snapshot) {
              final playerState = snapshot.data;
              final processingState = playerState?.processingState;
              final playing = playerState?.playing;
              if (processingState == ProcessingState.loading || processingState == ProcessingState.buffering) {
                return Container(
                  margin: const EdgeInsets.all(8.0),
                  width: 64.0,
                  height: 64.0,
                  child: const CircularProgressIndicator(color: Color(0xFF422B73)),
                );
              } else if (playing != true) {
                return IconButton(
                  icon: const Icon(
                    Icons.play_arrow,
                    color: Color(0xFF422B73),
                  ),
                  iconSize: 64.0,
                  onPressed: player.play,
                );
              } else if (processingState != ProcessingState.completed) {
                return IconButton(
                  icon: const Icon(
                    Icons.stop,
                    color: Color(0xFF30195A),
                  ),
                  iconSize: 64.0,
                  onPressed: player.pause,
                );
              } else {
                return IconButton(
                  icon: const Icon(Icons.replay),
                  iconSize: 64.0,
                  onPressed: () => player.seek(Duration.zero),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
