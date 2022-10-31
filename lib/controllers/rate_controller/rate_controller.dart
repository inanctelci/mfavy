import 'package:flutterframework/export.dart';

class RateController extends GetxController {
  final _tappedIndex = 0.obs;
  get tappedIndex => _tappedIndex.value;
  set tappedIndex(value) => _tappedIndex.value = value;
}
