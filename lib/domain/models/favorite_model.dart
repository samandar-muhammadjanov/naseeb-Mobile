import 'package:naseeb/domain/models/get_employee_model.dart';
import 'package:naseeb/domain/models/post_for_employee.dart';
import 'package:equatable/equatable.dart';

class Favorites extends Equatable {
  final List<Datum> posts;
  final List<EmployeeDatum> employee;
  const Favorites(
      {this.posts = const <Datum>[], this.employee = const <EmployeeDatum>[]});

  @override
  List<Object?> get props => [posts, employee];
}
