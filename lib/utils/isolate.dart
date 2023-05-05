//*       [ISOLate] - FlutterDeepLink Library
//*       [IMPORT]
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:deep_pick/deep_pick.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:convert';

//?       Once ISAR 3.0 works with web, we could swap out `hive` with it.

//?       fetchBody will check
Future<String?> fetchBody(String path, String file) async {
  debugPrint('[DIO] -> [Fetching Data]');
  Response response;
  response = await Dio().get('https://kbve.com/$path/$file.json');
  debugPrint('[DIO] -> Resposne $response');

  final json = (response.data);
  debugPrint('[DIO] -> JSON $json');
  final String? body = pick(json, 'entry', 'body').asStringOrNull();
  debugPrint('[DIO] -> [Fetch End] -> We got $body');
  return body;
}

//?       fetchHive
Future<String?> fetchHive(String path, String file) async {
  debugPrint('[Calling fetchBody]');
  debugPrint('[Opening HiveBox]');
  var dataBody = await Hive.openBox(path);

  var value = await dataBody.get(file, defaultValue: 'void');
  debugPrint('$value');
  if (value.toString() == 'void') {
    debugPrint('[Hive] -> [No Key]');
    value = fetchBody(path, file);
  }
  return value;
}
