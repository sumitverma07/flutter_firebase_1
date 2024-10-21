import 'dart:convert';

import 'package:http/http.dart' as http;

class CricketApiService {
  static const String apiUrl =
      'https://cricbuzz-cricket.p.rapidapi.com/series/v1/international';
  static const Map<String, String> headers = {
    'X-RapidAPI-Key': 'b3a8efc234mshfa17c179c5a4f0ap1d9febjsned7559305a83',
    'X-RapidAPI-Host': 'cricbuzz-cricket.p.rapidapi.com',
  };

  Future<Map<String, dynamic>> fetchSeriesList() async {
    final response = await http.get(Uri.parse(apiUrl), headers: headers);

    if (response.statusCode == 200) {
      print(response.body); // Add this line to print the response
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load series list');
    }
  }
}
