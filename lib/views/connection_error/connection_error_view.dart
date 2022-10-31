import 'package:flutterframework/export.dart';
class ConnectionErrorView extends StatelessWidget {
  ConnectionErrorView({Key? key}) : super(key: key);

  final ConnectionController connectionController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ConnectionError'.tr),
      ),
      body: Center(
        child: FloatingActionButton(
          onPressed: () {
            connectionController.checkConnection();
          },
        ),
      ),
    );
  }
}
