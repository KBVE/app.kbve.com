///
//*   Library:  Dart HTTP
///   Purpose:  Pulling information from static and server APIs.
///
import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:flutter/foundation.dart';

///
//*   Library: (Self) -> Constants
///   Purpose: Storing constant variables throughout the application.
import 'package:admin/constants.dart';

//*   <Asset> Class/Object that will have to be rebuilt in v2.
///   Title - Asset's Entity Name ? Legal D/B/A
///   Exchange - Asset's Exchange - Where the asset is traded / liquidated.
///   Ticker - TBD.
///   ISO - TBD.
///
class Asset {
  Asset({
    required this.title,
    required this.description,
    required this.exchange,
    required this.ticker,
    required this.slug,
    required this.tag,
    required this.img,
  });

  String title;
  String description;
  String exchange;
  String ticker;
  String slug;
  List<String>? tag;
  String img;

  factory Asset.fromJson(Map<String, dynamic> json) => Asset(
        title: json["title"],
        description: json["description"],
        exchange: json["exchange"],
        ticker: json["ticker"],
        slug: json["slug"],
        img: json["img"],
        tag: List<String>.from(json["tag"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "exchange": exchange,
        "ticker": ticker,
        "slug": slug,
        "tag": List<dynamic>.from(tag!.map((x) => x)),
        "img": img,
      };
}

Future<Asset> fetchAssetData(http.Client client, String assetLoc) async {
  final url = '$staticAPI' + 'asset/' + '$assetLoc' + '/data.json/';
  //final url = 'https://kbve.com/asset/aapl/data.json';
  /* final headers = {
    "Content-Type": "application/json",
    "Access-Control-Allow-Origin": "*",
    "Access-Control-Allow-Methods": "GET, POST, PUT, DELETE, HEAD, OPTIONS",
    "Access-Control-Allow-Credentials": "true"
  };
  final response = await client.get(Uri.parse(url), headers: headers);
  //if (response.isRedirect) {}
*/
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.

    var xr = json.decode(response.body);
    //final personMap = xr.jsonMap((e) => Asset.toJson(e));

    //final Map<String, dynamic> xxr = Map.castFrom(json.decode(response.body));

    return Asset.fromJson(xr);
    //return Asset.fromJson((jsonDecode(response.body) as Map<String, dynamic>));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load json');
  }
}

List<Asset> assetFromJson(String str) =>
    List<Asset>.from(json.decode(str).map((x) => Asset.fromJson(x)));

String assetToJson(List<Asset> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

Future<List<Asset>> fetchAsset(http.Client client, String assetLoc) async {
  final url = '$staticAPI' + 'asset/' + '$assetLoc' + '/data.json';
  final response = await client.get(Uri.parse(url));
  //return assetFromJson(response.body);
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
