///
//*   [INFO]
///
//!   Disregard this file - Base refactor / restructured asset.dart
///
///   Library: Asset Dart
///   Purpose: Handling the asset data and screens for the application.
///
///
///
//?   ?CONCEPT: Refactor by reducing and reusing the main widget.
//?   ?SUGGESTION: Restructure the asset class.
///
//*   [START]
///
///
//*   [IMPORT]
///
//?   [IMPORT] -> [EXT]
///
//*   Library: Dart - Async
///   Purpose: Help with the performance and threading of the application.
import 'dart:async';

///
//*   Library: Dart - Converter
///   Purpose: Converting JSON <---> Map Objects.
import 'dart:convert';
import 'dart:developer';
import 'package:json_helpers/json_helpers.dart';

///
//*   Library: Flutter -> Foundation
//!   Eviction: We are currently not using foundation, this is a library that we need to spend more time to understand.
///   Purpose: Offset the computation and lag to the device's background.
import 'package:flutter/foundation.dart';

///
//*   Library:  Flutter -> Material
///   Purpose:  Providing the inner core of the UI/UX for the application, as well as, the main aesthetics for the application front end design.
import 'package:flutter/material.dart';

///
//*   Library:  Provider
///   Purpose:  A wrapper for the widgets that will be handle the state / action management.
///
import 'package:provider/provider.dart';

///
//*   Library:  Dart HTTP
///   Purpose:  Pulling information from static and server APIs.
///
import 'package:http/http.dart' as http;

///
//*   Library:  Dart WebViexX
///   Purpose:  Providing iframes for the applications.
///
import 'package:webviewx/webviewx.dart';

///
//!   [IMPORT] -> [APP]
///

///
//*   Library: (Self) -> Constants
///   Purpose: Storing constant variables throughout the application.
import 'package:admin/constants.dart';

///
//*   Library <Prospect> : Dart - localStorage
///   Purpose: Storing abstract map objects/data for the application.
//?   ?CONCERN: Plugin needs to be cross-platform.
///   Event: v2 Migration - During the 2nd version phase of the app, we will being utilizing localStorage.

///
//*   Library: (Self) -> Controllers -> Menu Controller
///   Purpose: Handling the menu / drawer for the application.
///   Note:
///
import 'package:admin/controllers/MenuController.dart';

///
//*  Library: (Util) -> Networking
///  Purpose: Pulling and handling information from static and server APIs.
//!  Eviction: Networking Library will most likely removed during the migration to v2
//?  Event: v3 Migration - During the 3rd version phase of the app, we will be restructuring the networking, removing this library.
///
import 'package:admin/networking.dart';

///
//*   Library: (Self) -> Responsive
///   Purpose: Dynamically shift the UX/UI based upon the screen width / height and/or the device that the app is operating on.
//?   Event: vX <TO:DO> - Restructure / refactor the library.
///
import 'package:admin/responsive.dart';

///
//*   Library: (Comp) -> Header
///   Purpose: Providing the <Head> level information within the application; the contents of the <Head> will be in reference to the <User Data> | UI/UX.
//?   Event: v2 Migration - The current plan would be to pull the user information from localStorage and/or the server API.
///
import 'package:admin/screens/dashboard/components/header.dart';

///
//*   Library: (Comp) -> Side Menu
///   Purpose: Rendering the side menu with quick links to important router locations within the application.
///
import 'package:admin/screens/main/components/side_menu.dart';

///
//!   [IMPORT] -> [END]
///

///
//!   [FUNDAMENTAL] -> [CORE] -> [START]
///

///
//*   Class & Functions
///

///
//*   <Asset> Class/Object that will have to be rebuilt in v2.
///   Title - Asset's Entity Name ? Legal D/B/A
///   Exchange - Asset's Exchange - Where the asset is traded / liquidated.
///   Ticker - TBD.
///   ISO - TBD.
///
List<Asset> assetFromJson(String str) =>
    List<Asset>.from(json.decode(str).map((x) => Asset.fromJson(x)));

String assetToJson(List<Asset> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Asset {
  Asset({
    required this.title,
    required this.description,
    required this.exchange,
    required this.ticker,
    required this.slug,
    required this.tag,
  });

  String title;
  String description;
  String exchange;
  String ticker;
  String slug;
  List<String>? tag;

  factory Asset.fromJson(Map<String, dynamic> json) => Asset(
        title: json["title"],
        description: json["description"],
        exchange: json["exchange"],
        ticker: json["ticker"],
        slug: json["slug"],
        tag: List<String>.from(json["tag"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "exchange": exchange,
        "ticker": ticker,
        "slug": slug,
        "tag": List<dynamic>.from(tag!.map((x) => x)),
      };
}

Future<Asset> fetchAssetData(http.Client client, String assetLoc) async {
  //final url = '$staticAPI' + 'asset/' + '$assetLoc' + '/data.json/';
  final url = 'https://kbve.com/asset/aapl/data.json';
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

Future<List<Asset>> fetchAsset(http.Client client, String assetLoc) async {
  final url = '$staticAPI' + 'asset/' + '$assetLoc' + '/data.json';
  final response = await client.get(Uri.parse(url));
  return assetFromJson(response.body);
  //return compute(parseAsset, response.body);
}

List<Asset> parseAsset(String responseBody) {
  debugPrint('Starting...' + '$responseBody');
  final parsed = jsonDecode(responseBody);
  debugPrint("Parsing" + parsed.toString());
  return parsed.map<Asset>((json) => Asset.fromJson(json)).toList();
}

///
//!   [FUNDAMENTAL] ->  [CORE]  ->  [END]
///

///
//*   Library:  AssetData <Class> that extends a widget.
///   Purpose:  Fetch the asset's data and then render the information in the application
//?   ?CONCERN: Too much data / CPU usage upon load* - Will need to offset the widgets.
///
class AssetData extends StatefulWidget {
  final String? asset;
  // Children {Widget} -> Widgets that we would pass.
  // Asset {String} -> The Asset Entity name.
  AssetData({Key? key, this.asset}) : super(key: key);

  @override
  _AssetData createState() => _AssetData();
}

/// Further Extension of the State
///
class _AssetData extends State<AssetData> {
  @override
  Widget build(BuildContext context) {
    // Construct the <Scaffold> for the AssetScreen
    return Scaffold(
      key: context.read<MenuController>().scaffoldKey,
      drawer: SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display SideMenu for Desktop / Large Screens.
            if (Responsive.isDesktop(context))
              Expanded(
                // The Default Flex for the Menu is 1 , thus 1/6 of the screen.
                child: SideMenu(),
              ),
            Expanded(
              // Remaining 5/6 of the screen for the containers.
              flex: 5,
              child: AssetContainer(asset: widget.asset),
            ),
          ],
        ),
      ),
    );
  }
}

///
///
//*   Library:  AssetContainer <Class> extends widgets for the asset's data.
///   Purpose:  Display all the asset information for the app.
///
class AssetContainer extends StatefulWidget {
  //final Asset? asset;
  final String? asset;
  AssetContainer({Key? key, required this.asset}) : super(key: key);

  @override
  _AssetContainer createState() => _AssetContainer();
}

// Extension of AssetContainer
class _AssetContainer extends State<AssetContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            // Display Header.
            Header(),
            SizedBox(height: defaultPadding),
            // Flex Box 5 - For the remaining information.
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      // This is where we start to use the future builder.
                      Text({widget.asset}.toString()),
                      FutureAssetBuilder(
                        asset: widget.asset.toString(),
                      ),
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

///
///

///
///
//*   Library:  AssetBuilder <Class> extends widgets for the asset's data.
///   Purpose:  Display all the asset information for the app.
///
class FutureAssetBuilder extends StatefulWidget {
  //final Asset? asset;
  final String asset;
  FutureAssetBuilder({Key? key, required this.asset}) : super(key: key);

  @override
  _FutureAssetBuilder createState() => _FutureAssetBuilder();
}

// Extension of AssetContainer
class _FutureAssetBuilder extends State<FutureAssetBuilder> {
  late WebViewXController webviewController;
  Future? _future;
  Future<List<Asset>> loadList() async => await fetchAsset(
        http.Client(),
        widget.asset,
      );
  Size get screenSize => MediaQuery.of(context).size;

  @override
  void dispose() {
    webviewController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _future = loadList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: _future,
        builder: (ctx, AsyncSnapshot snapshot) {
          // Checking if future is resolved or not
          // If we got an error
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Errors: ' + '${snapshot.error} occurred',
                style: TextStyle(fontSize: 18),
              ),
            );

            // if we got our data
          } else if (snapshot.hasData) {
            // Extracting data from snapshot object
            final data = snapshot.data as List<Asset>;

            //return AssetLists(assets: snapshot.data!);
            return Center(
              child: Column(children: [
                new Row(
                  children:
                      data.map((item) => new Text(item.exchange)).toList(),
                ),
                new Row(
                  children: <Widget>[
                    for (var item in data) Text(item.toJson().toString()),
                  ],
                )
              ]),
            );
          } else {
            // Displaying LoadingSpinner to indicate waiting state
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

///
///
///
///
class AssetLists extends StatelessWidget {
  final Asset assets;
  const AssetLists({Key? key, required this.assets});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemBuilder: (context, index) {
        return Text(assets.title);
      },
    );
  }
}