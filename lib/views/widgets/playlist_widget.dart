import 'package:flutterframework/export.dart';

class LibraryListItem extends StatelessWidget {
  const LibraryListItem({
    Key? key,
    required this.onTap,
    required this.isGrid,
    required this.title,
    required this.imgUrl,
  }) : super(key: key);

  final VoidCallback onTap;
  final bool isGrid;
  final String title;
  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //h 36 w 42
      onTap: onTap,
      child: isGrid
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: Get.width * 0.36,
                  width: Get.width * 0.42,
                  color: Colors.transparent,
                  child: ClipRRect(
                    child: Image.network(
                      imgUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.01,
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Mulish-SemiBold',
                    fontSize: Get.width * 0.03,
                    color: Colors.white,
                  ),
                ),
              ],
            )
          : Row(
              children: [
                Container(
                  height: Get.width * 0.2,
                  width: Get.width * 0.2,
                  color: Colors.transparent,
                  child: ClipRRect(
                    child: Image.network(
                      imgUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  width: Get.width * 0.04,
                ),
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Mulish-Medium',
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
    );
  }
}
