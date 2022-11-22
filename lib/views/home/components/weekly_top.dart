import 'package:flutterframework/views/widgets/song_card.dart';

import '../../../export.dart';

class WeeklyTop extends StatelessWidget {
  const WeeklyTop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.kAppBlack,
      body: ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        itemCount: 10,
        separatorBuilder: (context, index) {
          return Column(
            children: [
              SizedBox(
                height: Get.height * 0.02,
              ),
              Container(
                height: Get.height * 0.0015,
                width: Get.width * 0.92,
                decoration: BoxDecoration(
                  color: AppConstants.kBoxGrey,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
            ],
          );
        },
        itemBuilder: (context, index) {
          return SongCard(
            showCrowns: false,
            index: index,
            title: 'Ebru Gündeş - Demir attım yalnızlığa',
            videoId: 'feQhHStBVLE',
            imgUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR5d7NQxPsQYQ18rSwd5t5vzMFl6rggWgSGTTpZ_8N_WA&s',
            rate: 'rate',
            watch: 'watch',
            widget: Image.network(
              'https://iasbh.tmgrup.com.tr/19c8c8/0/0/0/0/0/0?u=https://isbh.tmgrup.com.tr/sb/album/2021/09/19/1632038198585.jpg&mw=600&l=1',
              fit: BoxFit.cover,
            ),
          );
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
            style: TextStyle(
              fontFamily: 'Mulish-ExtraBold',
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        );
    }
  }
}
