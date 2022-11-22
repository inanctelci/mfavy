import 'package:flutterframework/export.dart';

class SongCardController extends GetxController {
  final _isTapped = false.obs;
  final _isPlaying = false.obs;

  get isTapped => _isTapped.value;
  set isTapped(value) => _isTapped.value = value;

  get isPlaying => _isPlaying.value;
  set isPlaying(value) => _isPlaying.value = value;
}
