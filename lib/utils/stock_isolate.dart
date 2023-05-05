//*       [STOCK] - Isolate
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

Future<String> fetchStockBox(String box) =>
    // Imagine that this function is more complex and slow.
    Future.delayed(
      const Duration(seconds: 2),
      () => 'Large Latte',
    );

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
            future: fetchStockBox(stock),
            builder: (context, snapshot) {
              if (snapshot.hasError) return Text(snapshot.error.toString());
              if (snapshot.hasData) {
                return Row(children: [
                  const Text("Stock: "),
                  Text(snapshot.hasData ? snapshot.data! : "No Stock Found!")
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
