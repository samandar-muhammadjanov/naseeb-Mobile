import 'package:hive_flutter/hive_flutter.dart';
import 'package:naseeb/domain/models/get_employee_model.dart';
import 'package:naseeb/domain/models/post_for_employee.dart';
import 'package:naseeb/storage/base_local_storage_repository.dart';

class LocalstorageRepository extends BaseLocalstorageRepository {
  String postBox = "favorite_posts";
  String employeeBox = "favorite_employees";
  @override
  Future<Box> openBox() async {
    Box box = await Hive.openBox<Datum>(postBox);
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

class EmployeeLocalstorageRepository
    extends EmployeeBaseLocalstorageRepository {
  String employeeBox = "favorite_employees";
  @override
  Future<Box> openBoxEmployee() async {
    Box box = await Hive.openBox<EmployeeDatum>(employeeBox);
    return box;
  }

  @override
  List<EmployeeDatum> getFavoritesEmployee(Box box) {
    return box.values.toList() as List<EmployeeDatum>;
  }

  @override
  Future<void> addNewstoFavoritesEmployee(Box box, EmployeeDatum product) {
    return box.put(product.id, product);
  }

  @override
  Future<void> removeNewsFromFavoritesEmployee(Box box, EmployeeDatum product) {
    return box.delete(product.id);
  }

  @override
  Future<void> clearFavoritesEmployee(Box box) {
    return box.clear();
  }
}
