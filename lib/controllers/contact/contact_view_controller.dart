import 'package:flutterframework/export.dart';

class ContactViewController extends GetxController {
  final RxString? _value = ''.obs;

  get value => _value?.value;
  set value(value) => _value?.value = value;
}
