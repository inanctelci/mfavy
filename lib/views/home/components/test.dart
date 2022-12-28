import 'package:encrypt/encrypt.dart' as enc;

import '../../../export.dart';

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      child: ElevatedButton(
        child: Text('data'),
        onPressed: (() {
          final plainText = '65';
          final key = enc.Key.fromUtf8('my 32 length key................');
          final iv = enc.IV.fromLength(16);

          final encrypter = enc.Encrypter(enc.AES(key));

          final encrypted = encrypter.encrypt(plainText, iv: iv);
          print(encrypted.base16);
          final decrypted = encrypter.decrypt(encrypted, iv: iv);
        }),
      ),
    ));
  }
}
