//*       [STOCK] - Isolate

import 'package:admin/entities/stock.dart';
import 'package:admin/isar_service.dart';
import 'package:flutter/material.dart';

class StockIsolate extends StatelessWidget {
  final String stock;
  final IsarService service;
  const StockIsolate({Key? key, required this.stock, required this.service})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FutureBuilder<Stock?>(
            future: service.getStockFor(stock),
            builder: (context, snapshot) {
              if (snapshot.hasError) return Text(snapshot.error.toString());
              if (snapshot.hasData) {
                return Row(children: [
                  const Text("Stock: "),
                  Text(snapshot.hasData
                      ? snapshot.data!.title
                      : "No Stock Found!")
                ]);
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ],
      ),
    );
  }
}
