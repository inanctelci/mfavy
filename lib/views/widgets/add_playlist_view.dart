import '../../controllers/library/library_controller.dart';
import '../../controllers/mini_player/mini_player_controller.dart';
import '../../export.dart';
import '../../models/music_list/add_music_to_list_req_model.dart';
import '../../models/user_list/change_listName_req_model.dart';
import '../../models/user_list/create_list_req_model.dart';
import '../../models/user_list/user_lists_model.dart';
import '../../services/list/list_music_service.dart';
import '../../services/list/list_service.dart';
import 'playlist_widget.dart';

class AddPlaylist extends StatelessWidget {
  AddPlaylist({Key? key}) : super(key: key);

  final MiniPlayerController _miniPlayerController = Get.find<MiniPlayerController>();
  final LibraryController _libraryController = Get.find<LibraryController>();
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Map<String, String> args = Get.arguments;
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
      body: Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.fromSwatch(
            accentColor: Colors.white,
          ),
        ),
        child: SingleChildScrollView(
          child: GetBuilder<LibraryController>(
              id: 'addTo_playlist',
              builder: (builderContext) {
                return FutureBuilder<UserListsModel>(
                    future: ListService().getList(context, 1),
                    builder: (context, snapshot) {
                      return !snapshot.hasData
                          ? const CircularProgressIndicator()
                          : Column(
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
                                      SizedBox(
                                        width: Get.width * 0.5,
                                        height: Get.height * 0.06,
                                        child: TextFormField(
                                          // focusNode: node,
                                          // controller: _textContoller,
                                          cursorColor: Colors.white,
                                          style: const TextStyle(
                                            fontFamily: 'Mulish-Medium',
                                            color: Colors.white,
                                          ),
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: AppConstants.kAppGrey,
                                            prefixIcon: Padding(
                                              padding: EdgeInsets.all(Get.width * 0.035),
                                              child: SvgPicture.asset(
                                                'assets/icons/search.svg',
                                              ),
                                            ),
                                            suffixIcon: GestureDetector(
                                              onTap: () {
                                                // _controller.isSearching = false;
                                              },
                                              child: const Icon(
                                                Icons.close_rounded,
                                                color: AppConstants.kHintText,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(4),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(4),
                                              borderSide: const BorderSide(
                                                color: Colors.white,
                                                width: 2,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return Dialog(
                                                backgroundColor: Colors.transparent,
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
                                                          controller: _textController,
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
                                                            focusedBorder: UnderlineInputBorder(
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
                                                            onTap: () async {
                                                              ListService()
                                                                  .createList(CreateListReqModel(listName: _textController.text, thumbnail: "."))
                                                                  .then((value) {
                                                                if (value.success == 1) {
                                                                  Get.back();
                                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                                    SnackBar(
                                                                      duration: const Duration(milliseconds: 1200),
                                                                      content: Container(
                                                                        height: Get.height * 0.05,
                                                                        width: Get.width,
                                                                        decoration: BoxDecoration(
                                                                          color: AppConstants.kAppGrey.withOpacity(0.8),
                                                                          borderRadius: BorderRadius.circular(4),
                                                                        ),
                                                                        child: Padding(
                                                                          padding: const EdgeInsets.all(8.0),
                                                                          child: Row(
                                                                            children: [
                                                                              SvgPicture.asset('assets/icons/like.svg'),
                                                                              const SizedBox(
                                                                                width: 5,
                                                                              ),
                                                                              Text(
                                                                                'Çalma Listesi Oluşturuldu.',
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
                                                                } else {
                                                                  Get.back();
                                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                                    SnackBar(
                                                                      duration: const Duration(milliseconds: 1200),
                                                                      content: Container(
                                                                        height: Get.height * 0.05,
                                                                        width: Get.width,
                                                                        decoration: BoxDecoration(
                                                                          color: AppConstants.kAppGrey.withOpacity(0.8),
                                                                          borderRadius: BorderRadius.circular(4),
                                                                        ),
                                                                        child: Padding(
                                                                          padding: const EdgeInsets.all(8.0),
                                                                          child: Row(
                                                                            children: [
                                                                              SvgPicture.asset(
                                                                                'assets/icons/message-question.svg',
                                                                                color: Colors.red.shade600,
                                                                              ),
                                                                              const SizedBox(
                                                                                width: 5,
                                                                              ),
                                                                              Text(
                                                                                'Bir şeyler ters gitti. Lütfen tekrar deneyiniz',
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
                                                                }
                                                                _libraryController.updatePage('addTo_playlist');
                                                              });
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
                                SizedBox(
                                  height: Get.width * 0.22 * 12,
                                  child: ListView.separated(
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: Get.width * 0.04,
                                        ),
                                        child: LibraryListItem(
                                          isGrid: false,
                                          onTap: () {
                                            ListMusicService().getList(snapshot.data!.data[0].datas![index].id!).then((value) {
                                              if (value.data[0].result!.datas!.isEmpty) {
                                                ListService()
                                                    .changeListName(ChangeListNameReqModel(
                                                        id: snapshot.data!.data[0].datas![index].id!,
                                                        listName: snapshot.data!.data[0].datas![index].listName!,
                                                        thumbnail: args['thumbnail']!))
                                                    .then((value) {});
                                              }
                                            });
                                            ListMusicService()
                                                .addMusicToList(
                                                    AddMusicToListReqModel(listID: snapshot.data!.data[0].datas![index].id!, yMusicID: args['id']!))
                                                .then(
                                              (value) {
                                                if (value.success == 1) {
                                                  Get.back();
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                    SnackBar(
                                                      duration: const Duration(milliseconds: 1200),
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
                                                              const SizedBox(
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
                                                } else {
                                                  Get.back();
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                    SnackBar(
                                                      duration: const Duration(milliseconds: 1200),
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
                                                              SvgPicture.asset('assets/icons/message-question.svg'),
                                                              const SizedBox(
                                                                width: 5,
                                                              ),
                                                              Text(
                                                                'Bir şeyler ters gitti.',
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
                                                }
                                              },
                                            );
                                          },
                                          img: snapshot.data!.data[0].datas![index].thumbnail == "."
                                              ? Image.asset('assets/images/playlist.png')
                                              : Image.network(
                                                  snapshot.data!.data[0].datas![index].thumbnail!,
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (context, error, stackTrace) {
                                                    return SizedBox();
                                                  },
                                                ),
                                          title: Obx(
                                            () {
                                              return _miniPlayerController.playingPlaylistIndex == snapshot.data!.data[0].datas![index].id
                                                  ? Text(
                                                      snapshot.data!.data[0].datas![index].listName!,
                                                      style: const TextStyle(
                                                        fontFamily: 'Mulish-ExtraBold',
                                                        color: AppConstants.kPrimaryColor,
                                                        fontSize: 16,
                                                      ),
                                                    )
                                                  : Text(
                                                      snapshot.data!.data[0].datas![index].listName!,
                                                      style: const TextStyle(
                                                        fontFamily: 'Mulish-Medium',
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                      ),
                                                    );
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return SizedBox(
                                        height: Get.height * 0.02,
                                      );
                                    },
                                    itemCount: snapshot.data!.data[0].datas!.length,
                                  ),
                                ),
                              ],
                            );
                    });
              }),
        ),
      ),
    );
  }
}
