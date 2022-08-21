// JSON Converter
import 'dart:convert';
// HTTP
import 'package:http/http.dart' as http;

// NetService - WIP
// Known error -> "A value of type 'void' can't be returned by the 'onError' handler because it must be assignable to FutureOr<T?>"
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
