import 'package:hive_flutter/hive_flutter.dart';
import 'package:naseeb/domain/models/post_for_employee.dart';

abstract class BaseLocalstorageRepository {
  Future<Box> openBox();
  List<Datum> getFavorites(Box box);
  Future<void> addNewstoFavorites(Box box, Datum product);
  Future<void> removeNewsFromFavorites(Box box, Datum product);
  Future<void> clearFavorites(Box box);
}
