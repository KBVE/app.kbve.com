import 'package:isar/isar.dart';

part 'stock.g.dart';

@Collection()
class Stock {
  Id? id;

  @Index(unique: true)
  late String slug;

  late String title;
  late String description;
  late String exchange;
  late String ticker;
  late String img;
  late List<String>? tags;
}
