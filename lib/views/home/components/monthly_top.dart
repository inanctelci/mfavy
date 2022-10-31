import 'package:flutterframework/export.dart';
import 'package:flutterframework/views/widgets/song_card.dart';
import 'package:http/http.dart';

class MonthlyTop extends StatelessWidget {
  const MonthlyTop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.kAppBlack,
      body: ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        itemCount: 10,
        separatorBuilder: (context, index) {
          return SizedBox(
            height: Get.height * 0.025,
          );
        },
        itemBuilder: (context, index) {
          return SongCard(
            index: index,
            showCrowns: true,
          );
        },
      ),
    );
  }
}
