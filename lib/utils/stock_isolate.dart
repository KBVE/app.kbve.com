//*       [STOCK] - Isolate
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:admin/utils/isolate.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class StockIsolate extends StatelessWidget {
  final String stock;
  final String asset;
  const StockIsolate({Key? key, required this.asset, required this.stock})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FutureBuilder<String?>(
            future: fetchHive(asset, stock),
            builder: (context, snapshot) {
              if (snapshot.hasError) return Text(snapshot.error.toString());
              if (snapshot.hasData) {
                return Container(
                  child: MarkdownBody(
                      data: (snapshot.data as String)
                          .substring((snapshot.data as String).indexOf('#'))),
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ],
      ),
    );
  }
}
