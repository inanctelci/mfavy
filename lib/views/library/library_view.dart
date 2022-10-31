import 'package:flutterframework/views/widgets/bottom_nav_bar.dart';

import '../../export.dart';

class LibraryView extends StatelessWidget {
  const LibraryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF252525),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: Get.height * 0.04,
              ),
              PlaylistHeadLine(),
              SizedBox(
                height: Get.height * 0.04,
              ),
              PlaylistViewOptions(),
              SizedBox(
                height: Get.height * 0.04,
              ),
              Container(
                height: Get.width * 0.22 * 12,
                child: ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return PlaylistWidget(
                      onTap: () {
                        Get.toNamed(NavigationConstants.playlist);
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: Get.height * 0.02,
                    );
                  },
                  itemCount: 12,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}

class PlaylistWidget extends StatelessWidget {
  const PlaylistWidget({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Get.width * 0.06,
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Container(
                      height: Get.width * 0.1,
                      width: Get.width * 0.1,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            'assets/images/ebrugundes.png',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      height: Get.width * 0.1,
                      width: Get.width * 0.1,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/ebrugundes.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      height: Get.width * 0.1,
                      width: Get.width * 0.1,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/ebrugundes.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      height: Get.width * 0.1,
                      width: Get.width * 0.1,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/ebrugundes.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              width: Get.width * 0.04,
            ),
            Text(
              'Türkçe Pop Listem',
              style: TextStyle(
                fontFamily: 'Mulish-Medium',
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PlaylistViewOptions extends StatelessWidget {
  const PlaylistViewOptions({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Get.width * 0.06,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SvgPicture.asset('assets/icons/sort-by.svg'),
              SizedBox(
                width: 5,
              ),
              Text(
                'En Yakın Tarihli',
                style: TextStyle(
                  fontFamily: 'Mulish-Medium',
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Row(
            children: [
              SvgPicture.asset('assets/icons/grid-rows.svg'),
              // SvgPicture.asset('assets/icons/grid-square.svg'),
            ],
          ),
        ],
      ),
    );
  }
}

class PlaylistHeadLine extends StatelessWidget {
  const PlaylistHeadLine({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Listelerim',
            style: TextStyle(
              fontFamily: 'Mulish-ExtraBold',
              fontSize: 24,
              color: Colors.white,
            ),
          ),
          Row(
            children: [
              SvgPicture.asset(
                'assets/icons/search.svg',
                height: Get.width * 0.06,
                color: Colors.white,
              ),
              SizedBox(
                width: 20,
              ),
              SvgPicture.asset(
                'assets/icons/add.svg',
                width: Get.width * 0.06,
                color: Colors.white,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
