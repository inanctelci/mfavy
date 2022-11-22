import 'package:http/http.dart' as http;

Future<http.Response> getResults(String query) {
  final API_KEY = "AIzaSyDZaGEqRJiRKB-8dCwX2lQbSeLn_5qMvHo";
  return http.get(
    Uri.parse('https://youtube.googleapis.com/youtube/v3/search?q=$query&key=${API_KEY}'),
  );
}
