import 'package:flutterframework/export.dart';
import 'package:flutterframework/views/widgets/song_card.dart';

class DailyTop extends StatelessWidget {
  const DailyTop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.kAppBlack,
      body: ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        itemCount: 8,
        separatorBuilder: (context, index) {
          return SizedBox(
            height: Get.height * 0.018,
          );
        },
        itemBuilder: (context, index) {
          return SongCard(
              showCrowns: false, index: index, title: 'Ebru Gündeş - Demir attım yalnızlığa', imgUrl: 'imgUrl', rate: 'rate', watch: 'watch');
        },
      ),
    );
  }

  Widget getCrowns(int index) {
    switch (index) {
      case 0:
        return Center(
          child: SvgPicture.asset(
            'assets/icons/crown.svg',
            color: AppConstants.kCrownGold,
          ),
        );
      case 1:
        return Center(
          child: SvgPicture.asset(
            'assets/icons/crown.svg',
            color: AppConstants.kCrownSilver,
          ),
        );
      case 2:
        return Center(
          child: SvgPicture.asset(
            'assets/icons/crown.svg',
            color: AppConstants.kCrownBronze,
          ),
        );
      default:
        return Center(
          child: Text(
            (index + 1).toString(),
            style: const TextStyle(
              fontFamily: 'Mulish-ExtraBold',
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        );
    }
  }
}
