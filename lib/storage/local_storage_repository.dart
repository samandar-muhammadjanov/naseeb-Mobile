import 'package:hive_flutter/hive_flutter.dart';
import 'package:naseeb/domain/models/post_for_employee.dart';
import 'package:naseeb/storage/base_local_storage_repository.dart';

class LocalstorageRepository extends BaseLocalstorageRepository {
  String boxName = "favorite_posts";
  @override
  Future<Box> openBox() async {
    Box box = await Hive.openBox<Datum>(boxName);
    return box;
  }

  @override
  List<Datum> getFavorites(Box box) {
    return box.values.toList() as List<Datum>;
  }

  @override
  Future<void> addNewstoFavorites(Box box, Datum product) {
    return box.put(product.id, product);
  }

  @override
  Future<void> removeNewsFromFavorites(Box box, Datum product) {
    return box.delete(product.id);
  }

  @override
  Future<void> clearFavorites(Box box) {
    return box.clear();
  }
}
