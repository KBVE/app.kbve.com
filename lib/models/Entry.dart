//*       [Entry] : Test Case
//*       [IMPORT]
import 'package:deep_pick/deep_pick.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
//*       [@lib]

class Entry {
  Entry({
    required this.entry,
  });

  String entry;
}

Future<String?> fetchEntry(
    http.Client client, String assetClass, String assetName) async {
  final url = 'https://kbve.com/asset/$assetClass/$assetName.json';
  final response = await client.get(Uri.parse(url));
  final json = jsonDecode(response.body);
  final String? version = pick(json, 'entry', 'id').asStringOrNull();
  debugPrint('We got $version');
  return version;
}
