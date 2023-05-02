//*       [Stock] : Model
//*       [IMPORT]
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/foundation.dart';
//*       [@lib]
import 'package:admin/constants.dart'; //*   Purpose: Storing constant variables throughout the application.

class Stock {
  Stock ({
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

  factory Stock.fromJson(Map<String, dynamic> json) => Stock(
        title: json["title"],
        description: json["description"],
        exchange: json["exchange"],
        ticker: json["ticker"],
        slug: json["slug"],
        img: json["img"],
        tag: List<String>.from(json["tags"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "exchange": exchange,
        "ticker": ticker,
        "slug": slug,
        "tags": List<dynamic>.from(tag!.map((x) => x)),
        "img": img,
      };
}

