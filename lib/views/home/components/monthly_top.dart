import 'package:flutterframework/export.dart';
import 'package:flutterframework/views/widgets/song_card.dart';

class MonthlyTop extends StatelessWidget {
  const MonthlyTop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.kAppBlack,
      body: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
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
            widget: Image.network(
              'https://iasbh.tmgrup.com.tr/19c8c8/0/0/0/0/0/0?u=https://isbh.tmgrup.com.tr/sb/album/2021/09/19/1632038198585.jpg&mw=600&l=1',
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}
