import 'dart:math';

import 'package:flutterframework/controllers/mini_player/mini_player_controller.dart';
import 'package:flutterframework/export.dart';

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    MiniPlayerController _miniPlayerController = Get.find<MiniPlayerController>();
    return Obx(
      () {
        return _miniPlayerController.isTapPlay
            ? Container(
                width: Get.width * 0.88,
                height: Get.height * 0.08,
                decoration: BoxDecoration(
                  color: Color(0xFF252525),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: Get.width * 0.06),
                              height: Get.height * 0.04,
                              width: Get.height * 0.04,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                // image: DecorationImage(
                                //   image: NetworkImage(
                                //     _miniPlayerController.imgUrl ??
                                //         'https://iasbh.tmgrup.com.tr/19c8c8/0/0/0/0/0/0?u=https://isbh.tmgrup.com.tr/sb/album/2021/09/19/1632038198585.jpg&mw=600&l=1',
                                //   ),
                                //   fit: BoxFit.cover,
                                // ),
                              ),
                            ),
                            SizedBox(
                              width: Get.width * 0.02,
                            ),
                            Obx(() {
                              return Text(
                                _miniPlayerController.title ?? 'Ebru Gundes - Demir Attım Yalnızlığa',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              );
                            }),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: Get.width * 0.06),
                          child: Obx(
                            () {
                              return _miniPlayerController.buttons
                                  ? GestureDetector(
                                      onTap: () {
                                        _miniPlayerController.player.value.stop();
                                        _miniPlayerController.buttons = false;
                                      },
                                      child: SvgPicture.asset('assets/icons/pause.svg'))
                                  : GestureDetector(
                                      onTap: () {
                                        _miniPlayerController.player.value.play();
                                        _miniPlayerController.buttons = true;
                                      },
                                      child: SvgPicture.asset('assets/icons/play.svg'));
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.005,
                    ),
                    SizedBox(
                      width: Get.width * 0.77,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Obx(() {
                          //   return Text(
                          //     _miniPlayerController.positionText,
                          //     style: TextStyle(
                          //       color: Colors.white,
                          //       fontFamily: 'Mulish-SemiBold',
                          //     ),
                          //   );
                          // }),
                          Expanded(
                            child: SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                trackHeight: 1,
                                thumbShape: RoundSliderThumbShape(
                                  enabledThumbRadius: 2,
                                  pressedElevation: 6,
                                ),
                                overlayShape: RoundSliderOverlayShape(
                                  overlayRadius: 1,
                                ),
                                activeTrackColor: Colors.white,
                                inactiveTrackColor: Colors.white.withOpacity(0.2),
                                thumbColor: AppConstants.kHintText,
                                overlayColor: Colors.white,
                              ),
                              child: Obx(() {
                                return Slider(
                                  min: 0,
                                  max: _miniPlayerController.player.value.duration?.inSeconds.toDouble() ?? 20,
                                  value: _miniPlayerController.sliderValue ?? 0,
                                  onChanged: (value) {
                                    _miniPlayerController.dragValue = value;
                                    _miniPlayerController.player.value.seek(
                                      Duration(
                                        seconds: value.toInt(),
                                      ),
                                    );
                                  },
                                );
                              }),
                            ),
                          ),
                          // Text(
                          //   _miniPlayerController.formatDuration(_miniPlayerController.player.value.duration!),
                          //   style: TextStyle(
                          //     color: Colors.white,
                          //     fontFamily: 'Mulish-SemiBold',
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : SizedBox();
      },
    );
  }
}
