import 'package:encrypt/encrypt.dart' as enc;
import 'package:uni_links/uni_links.dart';

import '../../export.dart';

class DeepLinkController extends GetxController {
  late StreamSubscription _sub;
  _initUniLink() {
    _sub = linkStream.listen((String? link) {
      if (link != null) {
        var uri = Uri.parse(link);
        var text = uri.path.split('/').last;
        var iv = enc.IV.fromUtf8('mfavy');
        var key = enc.Key.fromUtf8('cAz9eKLHbgh692p8wkrZxzfLPRMTJHvm');
        var arg = enc.Encrypter(enc.AES(key)).decrypt16(text, iv: iv);
        Get.toNamed(NavigationConstants.sharedPlaylist, arguments: arg);
      }
    }, onError: (err) {});
  }

  @override
  void onInit() {
    _initUniLink();
    super.onInit();
  }
}
