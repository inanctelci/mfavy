import '../../export.dart';

class LibraryListItem extends StatelessWidget {
  const LibraryListItem({
    Key? key,
    required this.onTap,
    required this.isGrid,
    required this.title,
    required this.img,
  }) : super(key: key);

  final VoidCallback onTap;
  final bool isGrid;
  final Widget title;
  final Widget img;

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
                  child: ClipRRect(child: img),
                ),
                SizedBox(
                  height: Get.height * 0.01,
                ),
                Flexible(child: title),
              ],
            )
          : Row(
              children: [
                Container(
                  height: Get.width * 0.2,
                  width: Get.width * 0.2,
                  color: Colors.black,
                  child: ClipRRect(
                    child: img,
                  ),
                ),
                SizedBox(
                  width: Get.width * 0.04,
                ),
                Flexible(child: title)
              ],
            ),
    );
  }
}
