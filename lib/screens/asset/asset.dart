// Async
import 'dart:async';

// JSON Converter
import 'dart:convert';

// Foundation
import 'package:flutter/foundation.dart';

// HTTP (The other option would be to use our networking.dart but that might be later down the line.)
import 'package:http/http.dart' as http;

// Constants
import 'package:admin/constants.dart';

// Menu Controller
import 'package:admin/controllers/MenuController.dart';

// Networking Library (We will most likely remove this import.)
import 'package:admin/networking.dart';

// Responsive
import 'package:admin/responsive.dart';

// Header
import 'package:admin/screens/dashboard/components/header.dart';

// Side Menu
import 'package:admin/screens/main/components/side_menu.dart';

// UI / UX from Material
import 'package:flutter/material.dart';

// Provider
import 'package:provider/provider.dart';

// API Location
const apiLoc = 'https://kbve.com/assets/';

class AssetDB {
  late Map<String, dynamic> data;

  FutureOr<void> fetchFor(String asset) async {
    data = (await NetService.getJson<Map<String, dynamic>>('$apiLoc$asset'))!;
  }

  List<String> getAssetExchange() {
    return (data['asset'] as List)
        .map<String>((m) => (m as Map)['exchange'])
        .toList();
  }
}

class Asset {
  final String? title;
  final String? exchange;
  final int? id;
  final Map<String, dynamic>? assetData;

  const Asset({
    this.title,
    this.exchange,
    this.id,
    this.assetData,
  });

  factory Asset.fromJson(Map<String, dynamic> json) {
    return Asset(
      exchange: json['exchange'] as String,
      id: json['id'] as int,
      title: json['title'] as String,
    );
  }
}

Future<Asset> fetchAsset(String kbve) async {
  final res = await http.get(Uri.parse('$apiLoc$kbve'));
  // Use the compute function to run parsePhotos in a separate isolate.
  return Asset.fromJson(jsonDecode(res.body));
}

class AssetRender extends StatefulWidget {
  final Asset? asset;
  AssetRender({Key? key, this.asset}) : super(key: key);

  @override
  _AssetRender createState() => _AssetRender();
}

class _AssetRender extends State<AssetRender> {
  get asset => this.asset;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<MenuController>().scaffoldKey,
      drawer: SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: SideMenu(),
              ),
            Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: AssetChart(asset: asset),
            ),
          ],
        ),
      ),
    );
  }
}

class AssetChart extends StatefulWidget {
  final Asset? asset;
  AssetChart({Key? key, required this.asset}) : super(key: key);

  @override
  _AssetChart createState() => _AssetChart();
}

class _AssetChart extends State<AssetChart> {
  String get asset => this.asset;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<MenuController>().scaffoldKey,
      drawer: SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: SideMenu(),
              ),
            Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: Text(asset),
            ),
          ],
        ),
      ),
    );
  }
}

class AssetScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text('KBVE Asset')),
      key: context.read<MenuController>().scaffoldKey,
      drawer: SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: SideMenu(),
              ),
            Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: __AssetScreen(),
            ),
          ],
        ),
      ),
    );
  }
}

class __AssetScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header(),
            SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      AssetDetails(),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class AssetDetails extends StatelessWidget {
  const AssetDetails({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Asset Details",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: defaultPadding),
        ],
      ),
    );
  }
}
