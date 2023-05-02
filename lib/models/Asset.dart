//*       [ASSET] : Model
//*       [IMPORT]
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:deep_pick/deep_pick.dart';
//*       [@lib]
import 'package:admin/constants.dart'; //*   Purpose: Storing constant variables throughout the application.

class Asset {
  Asset({
    required this.title,
    required this.description,
    required this.exchange,
    required this.ticker,
    required this.slug,
    required this.tags,
    required this.img,
  });

  String title;
  String description;
  String exchange;
  String ticker;
  String slug;
  List<String>? tags;
  String img;

  factory Asset.fromJson(Map<String, dynamic> json) => Asset(
        title: json["title"],
        description: json["description"],
        exchange: json["exchange"],
        ticker: json["ticker"],
        slug: json["slug"],
        img: json["img"],
        tags: List<String>.from(json["tags"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "exchange": exchange,
        "ticker": ticker,
        "slug": slug,
        "tags": List<dynamic>.from(tags!.map((x) => x)),
        "img": img,
      };
}

Future<Asset> fetchAssetData(
    // Currently using fetchAsset and not fetchAssetData
    http.Client client,
    String assetClass,
    String assetName) async {
  final url = 'https://kbve.com/asset/$assetClass/$assetName.json';

  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    var xr = json.decode(response.body);

    return Asset.fromJson(xr);
  } else {
    throw Exception('Failed to load json');
  }
}

List<Asset> assetFromJson(String str) =>
    List<Asset>.from(json.decode(str).map((x) => Asset.fromJson(x)));

String assetToJson(List<Asset> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

Future<List<Asset>> fetchAsset(
    http.Client client, String assetClass, String assetName) async {
  final url = 'https://kbve.com/asset/$assetClass/$assetName.json';
  final response = await client.get(Uri.parse(url));
  //return (parseAsset(response.body));
  return compute(assetFromJson, response.body);
}

List<Asset> parseAsset(String responseBody) {
  debugPrint('Starting...' + '$responseBody');
  final parsed = jsonDecode(responseBody);
  debugPrint("Parsing" + parsed.toString());
  return parsed.map<Asset>((json) => Asset.fromJson(json)).toList();
}

dynamic getAssetMap(List<dynamic> assetList) {
  List<Map<String, dynamic>> map = [];
  assetList.forEach((element) {
    map.add(element.toMap());
  });
  return map;
}
