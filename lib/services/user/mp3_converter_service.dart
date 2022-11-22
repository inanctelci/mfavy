import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/mp3/mp3_model.dart';

class Mp3Service {
  Future<Mp3Model> getMp3(String id) async {
    final response = await http.get(
      Uri.parse(
        'https://youtube-mp3-download1.p.rapidapi.com/dl?id=$id',
      ),
      headers: {
        'X-RapidAPI-Key': 'f9c985a0afmsh4a4617bf175904ep153debjsn98728be75cb0',
        'X-RapidAPI-Host': 'youtube-mp3-download1.p.rapidapi.com',
      },
    );

    if (response.statusCode == 200) {
      print('200OK');
      return Mp3Model.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load mp3');
    }
  }
}
