import '../../export.dart';

class SongCardController extends GetxController {
  final RxString _title = ''.obs;
  final RxString _id = ''.obs;
  final RxString _thumbnail = ''.obs;

  get title => _title.value;
  set title(value) => _title.value = value;

  get id => _id.value;
  set id(value) => _id.value = value;

  get thumbnail => _thumbnail.value;
  set thumbnail(value) => _thumbnail.value = value;
}
