import 'package:flutterframework/export.dart';
import 'package:flutterframework/models/top_rate/top_rate_model.dart';

class DailyTopService {
  Future<TopRateModel> getDailyTopList(BuildContext context) async {
    final response = await DefaultAssetBundle.of(context).loadString('assets/json/daily_top.json');
    final data = await json.decode(response);
    return TopRateModel.fromJson(data);
  }
}
