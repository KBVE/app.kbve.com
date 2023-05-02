import 'package:isar/isar.dart';

part 'asset.g.dart';

@Collection()
class Asset {
  Id? id;

  @Index(unique: true)
  late String slug;

  late String title;
  late String description;
  late String img;
  late List<String>? tags;
}
