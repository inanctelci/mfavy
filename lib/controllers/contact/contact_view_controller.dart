import '../../export.dart';

class ContactViewController extends GetxController {
  final RxString _value = ''.obs;
  final RxBool _categoryError = false.obs;
  final RxBool _nameError = false.obs;
  final RxBool _mailError = false.obs;
  final RxBool _messageError = false.obs;
  final RxBool _loading = false.obs;

  get loading => _loading.value;
  set loading(value) => _loading.value = value;

  get messageError => _messageError.value;
  set messageError(value) => _messageError.value = value;

  get mailError => _mailError.value;
  set mailError(value) => _mailError.value = value;

  get nameError => _nameError.value;
  set nameError(value) => _nameError.value = value;

  get value => _value.value;
  set value(value) => _value.value = value;

  get categoryError => _categoryError.value;
  set categoryError(value) => _categoryError.value = value;
}
