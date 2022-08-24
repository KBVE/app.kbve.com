//*  [INFO]  */
///  Library: Asset Dart
/// Purpose: Handling the asset data and screens for the application.
//?   ?CONCEPT: Refactor by reducing and reusing the main widget.
//?   ?SUGGESTION: Restructure the asset class.
//*  [START] */
///
///
//!  [IMPORT]  */
///
//!  [IMPORT] -> [EXT] */
///
///  Library: Dart - Async
///  Purpose: Help with the performance and threading of the application.
import 'dart:async';

///
///
///  Library: Dart - Converter
///  Purpose: Converting JSON <---> Map Objects.
import 'dart:convert';

///  Library: Flutter -> Foundation
///  Eviction: We are currently not using foundation, this is a library that we need to spend more time to understand.
///  import 'package:flutter/foundation.dart';
///  Library: Flutter -> Material
///  Purpose: Providing the inner core of the UI/UX for the application, as well as, the main aesthetics for the application front end design.
import 'package:flutter/material.dart';

///   Library: Provider
///   Purpose: A wrapper for the widgets that will be handle the state / action management.
import 'package:provider/provider.dart';

///  Library: Dart HTTP
///  Purpose: Pulling information from static and server APIs.
import 'package:http/http.dart' as http;

///
//!  [IMPORT] -> [APP]
///
///  Library: (Self) -> Constants
///  Purpose: Storing constant variables throughout the application.
import 'package:admin/constants.dart';

//*  Library <Prospect> : Dart - localStorage
///  Purpose: Storing abstract map objects/data for the application.
//?  Event: v2 Migration - During the 2nd version phase of the app, we will being utilizing localStorage.

//*  Library: (Self) -> Controllers -> Menu Controller
///  Purpose: Handling the menu / drawer for the application.
import 'package:admin/controllers/MenuController.dart';

//  Library: (Util) -> Networking
//  Purpose: Pulling and handling information from static and server APIs.
//  Eviction: Networking Library will most likely removed during the migration to v2
//  Event: v3 Migration - During the 3rd version phase of the app, we will be restructuring the networking, removing this library.
import 'package:admin/networking.dart';

//  Library: (Self) -> Responsive
//  Purpose: Dynamically shift the UX/UI based upon the screen width / height and/or the device that the app is operating on.
//  Event: vX <TO:DO> - Restructure / refactor the library.
import 'package:admin/responsive.dart';

//  Library: (Comp) -> Header
//  Purpose: Providing the <Head> level information within the application; the contents of the <Head> will be in reference to the <User Data> | UI/UX.
//  Event: v2 Migration - The current plan would be to pull the user information from localStorage and/or the server API.
import 'package:admin/screens/dashboard/components/header.dart';

//  Library: (Comp) -> Side Menu
//  Purpose: Rendering the side menu with quick links to important router locations within the application.
import 'package:admin/screens/main/components/side_menu.dart';

//  Constant: API Location
//  Event: v1 Migration <Current Instance> : This variable will be moved over to the constants.
const apiLoc = 'https://a.kbve.com/stocks/';

// Default Asset Structures and Classes

// AssetDB - Will be removed or replaced in v2.
// There is an issue with NetService and how the "Future" aspect is being handled.
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

// <Asset> Class/Object that will have to be rebuilt in v2.
// Title - Asset's Entity Name ? Legal D/B/A
// Exchange - Asset's Exchange - Where the asset is traded / liquidated.
// Ticker - TBD.
// ISO - TBD.
class Asset {
  final String? title;
  final String? exchange;
  final String? ticker;
  final Map<String, dynamic>? assetData;

  const Asset({
    this.title,
    this.exchange,
    this.ticker,
    this.assetData,
  });

// Factory Asset.fromJSON

  factory Asset.fromJson(Map<String, dynamic> json) {
    return Asset(
      exchange: json['exchange'] as String,
      ticker: json['ticker'] as String,
      title: json['title'] as String,
    );
  }
}

Future<Asset> fetchAsset(String kbve) async {
  final res = await http.get(Uri.parse('$apiLoc$kbve.json'));
  return Asset.fromJson(jsonDecode(res.body));
}

class AssetRender extends StatefulWidget {
  final String? asset;
  AssetRender({Key? key, required this.asset}) : super(key: key);

  @override
  _AssetRender createState() => _AssetRender();
}

class _AssetRender extends State<AssetRender> {
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
              child: AssetChart(asset: widget.asset),
            ),
          ],
        ),
      ),
    );
  }
}

// Asset Chart - Stateful Widget
// The Widget will render a chart for the asset.

class AssetChart extends StatefulWidget {
  //final Asset? asset;
  final String? asset;
  AssetChart({Key? key, required this.asset}) : super(key: key);

  @override
  _AssetChart createState() => _AssetChart();
}

// Extension of AssetChart
class _AssetChart extends State<AssetChart> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                      Text({widget.asset}.toString()),
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

// Asset Screen
// This is the default screen that is rendered without params being passed through.

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
