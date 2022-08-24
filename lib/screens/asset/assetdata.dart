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

///
//*   Library: Flutter -> Foundation
//!   Eviction: We are currently not using foundation, this is a library that we need to spend more time to understand.
///   Purpose: Offset the computation and lag to the device's background.
import 'package:flutter/foundation.dart';

///
//*   Library: Flutter -> Material
///   Purpose: Providing the inner core of the UI/UX for the application, as well as, the main aesthetics for the application front end design.
import 'package:flutter/material.dart';

///
//*   Library: Provider
///   Purpose: A wrapper for the widgets that will be handle the state / action management.
///
import 'package:provider/provider.dart';

///
//*   Library: Dart HTTP
///   Purpose: Pulling information from static and server APIs.
///
import 'package:http/http.dart' as http;

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
class Asset {
  final String? title;
  final String? exchange;
  final String? ticker;
  final String? location;

  const Asset({
    this.title,
    this.exchange,
    this.ticker,
    this.location,
  });

  factory Asset.fromJson(Map<String, dynamic> json) {
    return Asset(
      exchange: json['exchange'] as String,
      ticker: json['ticker'] as String,
      title: json['title'] as String,
      location: json['location'] as String,
    );
  }
}

Future<List<Asset>> fetchAsset(String assetLoc) async {
  final url = '$staticAPI' + '$assetLoc' + '.json';
  final response = await http.get(Uri.parse(url));
  debugPrint('Grabbed Data: ' + response.body);

  return compute(parseAsset, response.body);
}

List<Asset> parseAsset(String responseBody) {
  debugPrint('Starting...');
  final parsed = jsonDecode(responseBody);
  debugPrint("Parsing" + parsed);
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
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        builder: (ctx, snapshot) {
          // Checking if future is resolved or not
          if (snapshot.connectionState == ConnectionState.done) {
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
              final data = snapshot.data as Asset;
              return Center(
                child: Text(
                  'Data: ' + (data.title as String),
                  style: TextStyle(fontSize: 18),
                ),
              );
            }
          }

          // Displaying LoadingSpinner to indicate waiting state
          return Center(
            child: CircularProgressIndicator(),
          );
        },
        future: fetchAsset(
          widget.asset,
        ),
      ),
    );
  }
}

///
///
///