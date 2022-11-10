import 'package:flutterframework/export.dart';
import 'package:flutterframework/models/video_results/video_results_model.dart';
import 'package:youtube_api/youtube_api.dart';

class HomeSearchController extends GetxController {
  RxBool _isSearching = false.obs;
  RxBool _isTypeing = false.obs;
  TextEditingController _textController = TextEditingController();
  RxList<dynamic> _videoResult = [].obs;

  get isSearching => _isSearching.value;
  set isSearching(value) => _isSearching.value = value;

  get isTypeing => _isTypeing.value;
  set isTypeing(value) => _isTypeing.value = value;

  get textController => _textController;

  get videoResults => _videoResult.value;
  set videoResults(value) => _videoResult.value = value;
}
