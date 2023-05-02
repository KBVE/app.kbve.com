import 'package:isar/isar.dart';

part 'tag.g.dart';

@Collection()
class Tag {
  Id? id;

  @Index(unique: true)
  late String slug;

  late String title;
  late String description;
  late String icon;
  late List<String>? tags;
}
