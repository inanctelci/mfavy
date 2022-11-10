import 'package:flutterframework/export.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'playlist_widget.dart';

class AddPlaylist extends StatelessWidget {
  const AddPlaylist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.kAppBlack,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppConstants.kAppBlack,
        centerTitle: true,
        title: Text(
          'Çalma Listesine Ekle',
          style: TextStyle(
            fontFamily: 'Mulish-ExtraBold',
            color: Colors.white,
            fontSize: Get.width * 0.05,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: SvgPicture.asset('assets/icons/arrow-left.svg'),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: Get.height * 0.04,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Get.width * 0.04,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: Get.height * 0.05,
                    width: Get.width * 0.5,
                    decoration: BoxDecoration(
                      color: AppConstants.kAppGrey,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: Get.width * 0.04,
                        ),
                        SvgPicture.asset(
                          'assets/icons/search.svg',
                          width: Get.width * 0.05,
                        ),
                        SizedBox(
                          width: Get.width * 0.02,
                        ),
                        Text(
                          'Çalma Listesi Ara',
                          style: TextStyle(
                            color: AppConstants.kHintText,
                            fontSize: Get.width * 0.03,
                            fontFamily: 'Mulish-Medium',
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            child: Container(
                              width: Get.width,
                              height: Get.height * 0.2,
                              decoration: BoxDecoration(
                                color: AppConstants.kAppBlack,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'Çalma listesine bir isim ver',
                                    style: TextStyle(
                                      fontFamily: 'Mulish-ExtraBold',
                                      color: Colors.white,
                                      fontSize: Get.width * 0.035,
                                    ),
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.6,
                                    child: TextFormField(
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: Get.width * 0.03,
                                        fontFamily: 'Mulish-Medium',
                                      ),
                                      cursorColor: Colors.white,
                                      decoration: const InputDecoration(
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.white,
                                          ),
                                        ),
                                        focusedBorder: const UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Get.back();
                                        },
                                        child: Container(
                                          height: Get.height * 0.04,
                                          width: Get.width * 0.3,
                                          decoration: BoxDecoration(
                                            color: AppConstants.kHintText,
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Center(
                                            child: Text(
                                              'İptal',
                                              style: TextStyle(
                                                color: AppConstants.kAppBlack,
                                                fontSize: Get.width * 0.04,
                                                fontFamily: 'Mulish-Bold',
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: Get.width * 0.06,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Get.back();
                                        },
                                        child: Container(
                                          height: Get.height * 0.04,
                                          width: Get.width * 0.3,
                                          decoration: BoxDecoration(
                                            color: AppConstants.kPrimaryColor,
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Center(
                                            child: Text(
                                              'Oluştur',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: Get.width * 0.04,
                                                fontFamily: 'Mulish-Bold',
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      height: Get.height * 0.05,
                      width: Get.width * 0.35,
                      decoration: BoxDecoration(
                        color: AppConstants.kPrimaryColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          'Yeni Oluştur',
                          style: TextStyle(
                            fontFamily: 'Mulish-ExtraBold',
                            color: Colors.white,
                            fontSize: Get.width * 0.03,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
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
                      Get.back();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Container(
                            height: Get.height * 0.05,
                            width: Get.width,
                            decoration: BoxDecoration(
                              color: AppConstants.kAppBlack,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  SvgPicture.asset('assets/icons/like.svg'),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'Şarkı, Çalma Listesine başarıyla eklendi',
                                    style: TextStyle(
                                      fontFamily: 'Mulish-ExtraBold',
                                      color: Colors.white,
                                      fontSize: Get.width * 0.03,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
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
    );
  }
}
