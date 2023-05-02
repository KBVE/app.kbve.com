//*       [Stock] : Model
//*       [IMPORT]
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/foundation.dart';
//*       [@lib]
import 'package:admin/constants.dart'; //*   Purpose: Storing constant variables throughout the application.

class Error {
  Error({
    required this.title,
    required this.description,
    required this.url,
  });

  final String title, description, url;
}

class ErrorMessage {
  final String? icon, title, date, size;
  ErrorMessage({this.icon, this.title, this.date, this.size});
}
