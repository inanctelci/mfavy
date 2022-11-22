import 'package:flutterframework/export.dart';
import 'package:flutterframework/models/mp3/mp3_model.dart';
import 'package:flutterframework/services/user/mp3_converter_service.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: FutureBuilder<Mp3Model>(
        future: Mp3Service().getMp3('WaaEs2Pq9VA'),
        builder: (context, snapshot) {
          print(snapshot.data!.youtubeAPI);
          return Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  snapshot.data!.youtubeAPI.toString(),
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
