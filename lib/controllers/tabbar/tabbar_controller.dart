import 'package:flutterframework/export.dart';

class TabBarController extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController controller;

  late RxInt index;

  final List<Tab> myTabs = <Tab>[
    const Tab(
      text: 'Bugün',
    ),
    const Tab(
      text: 'Bu Hafta',
    ),
    const Tab(
      text: 'Bu Ay',
    )
  ];

  @override
  void onInit() {
    controller = TabController(length: 3, vsync: this);
    index = controller.index.obs;
    super.onInit();
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }
}
