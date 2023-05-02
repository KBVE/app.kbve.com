//*         Credit to Max and Mahtab from FlutterExp
//*         [IMPORT]
import 'package:isar/isar.dart';
import 'package:admin/entities/asset.dart';
import 'package:admin/entities/stock.dart';
import 'package:admin/entities/tag.dart';
import 'package:path_provider/path_provider.dart';

class IsarService {
  late Future<Isar> db;

  IsarService() {
    db = openDB();
  }

//*       [SAVE]

  Future<void> saveAsset(Asset newAsset) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.assets.putSync(newAsset));
  }

  Future<void> saveStock(Stock newStock) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.stocks.putSync(newStock));
  }

  Future<void> saveTag(Tag newTag) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.tags.putSync(newTag));
  }

//*       [GET]

  Future<List<Asset>> getAllAssets() async {
    final isar = await db;
    return await isar.assets.where().findAll();
  }

  Future<List<Stock>> getAllStocks() async {
    final isar = await db;
    return await isar.stocks.where().findAll();
  }

  Future<List<Tag>> getAllTags() async {
    final isar = await db;
    return await isar.tags.where().findAll();
  }

  Future<Stock?> getStockFor(String slug) async {
    final isar = await db;

    final stock = await isar.stocks.filter().slugEqualTo(slug).findFirst();

    return stock;
  }

//*       [UTIL]

  Future<void> cleanDb() async {
    final isar = await db;
    await isar.writeTxn(() => isar.clear());
  }

  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      final appStorage = await getApplicationDocumentsDirectory();
      return await Isar.open([AssetSchema, StockSchema, TagSchema],
          inspector: true, directory: appStorage.path);
    }

    return Future.value(Isar.getInstance());
  }
}
