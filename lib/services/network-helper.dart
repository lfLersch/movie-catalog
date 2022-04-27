import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper(this.url);

  static const urlPostsBank = 'https://image.tmdb.org/t/p/original';

  final String url;

  Future getData() async {
    Uri? uri = Uri.tryParse(url);
    http.Response response = await http.get(uri!);

    if (response.statusCode == 200) {
      String data = response.body;

      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}