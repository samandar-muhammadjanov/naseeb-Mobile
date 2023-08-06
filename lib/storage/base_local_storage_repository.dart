import 'package:hive_flutter/hive_flutter.dart';
import 'package:naseeb/domain/models/get_employee_model.dart';
import 'package:naseeb/domain/models/post_for_employee.dart';

abstract class BaseLocalstorageRepository {
  Future<Box> openBox();
  List<Datum> getFavorites(Box box);
  Future<void> addNewstoFavorites(Box box, Datum product);
  Future<void> removeNewsFromFavorites(Box box, Datum product);
  Future<void> clearFavorites(Box box);
}

abstract class EmployeeBaseLocalstorageRepository {
  Future<Box> openBoxEmployee();
  List<EmployeeDatum> getFavoritesEmployee(Box box);
  Future<void> addNewstoFavoritesEmployee(Box box, EmployeeDatum product);
  Future<void> removeNewsFromFavoritesEmployee(Box box, EmployeeDatum product);
  Future<void> clearFavoritesEmployee(Box box);
}
