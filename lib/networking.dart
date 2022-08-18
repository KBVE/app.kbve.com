import 'dart:convert';

import 'package:http/http.dart' as http;

class NetService {
  /* ---------------------------------------------------------------------------- */
  static Future<T?> getJson<T>(String url) {
    return http.get(Uri.parse(url)).then((response) {
      if (response.statusCode == 200) {
        return jsonDecode(response.body) as T;
      }
      print('Status Code : ${response.statusCode}...');
      return null;
    }).catchError((err) => print(err));
  }
}
