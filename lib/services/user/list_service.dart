import 'package:flutterframework/export.dart';
import 'package:flutterframework/models/music_list/music_list_model.dart';

class ListService {
  Future<MusicListModel> getList(BuildContext context) async {
    final response = await DefaultAssetBundle.of(context).loadString('assets/json/music_list.json');
    final data = await json.decode(response);
    return MusicListModel.fromJson(data);
  }
}
