import 'package:flutterframework/export.dart';
import 'package:flutterframework/models/video_results/video_results_model.dart';
import 'package:youtube_api/youtube_api.dart';

class HomeSearchController extends GetxController {
  RxBool _isSearching = false.obs;
  RxBool _isTypeing = false.obs;
  TextEditingController textController = TextEditingController();
  RxBool _isAPIworking = false.obs;
  RxList _videoResult = [].obs;
  RxInt _tappedIndex = (-1).obs;

  get isSearching => _isSearching.value;
  set isSearching(value) => _isSearching.value = value;

  get isTypeing => _isTypeing.value;
  set isTypeing(value) => _isTypeing.value = value;

  get videoResults => _videoResult.value;
  set videoResults(value) => _videoResult.value = value;

  get isAPIworking => _isAPIworking.value;
  set isAPIworking(value) => _isAPIworking.value = value;

  get tappedIndex => _tappedIndex.value;
  set tappedIndex(value) => _tappedIndex.value = value;
}
