import 'dart:async';
import 'package:admin/constants.dart';
import 'package:admin/controllers/MenuController.dart';
import 'package:admin/networking.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/components/header.dart';
import 'package:admin/screens/main/components/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const assetLoc = 'https://kbve.com/assets/';

class AssetDB {
  late Map<String, dynamic> data;

  FutureOr<void> fetchFor(String asset) async {
    data = (await NetService.getJson<Map<String, dynamic>>('$assetLoc$asset'))!;
  }

  List<String> getAssetExchange() {
    return (data['asset'] as List)
        .map<String>((m) => (m as Map)['exchange'])
        .toList();
  }
}

class Asset {
  final String title;
  final String exchange;
  final int id;

  const Asset({
    required this.title,
    required this.exchange,
    required this.id,
  });

  factory Asset.fromJson(Map<String, dynamic> json) {
    return Asset(
      exchange: json['exchange'],
      id: json['id'],
      title: json['title'],
    );
  }
}

class AssetScreen extends StatelessWidget {
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
