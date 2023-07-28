// ignore_for_file: prefer_typing_uninitialized_variables

part of 'employer_bloc.dart';

abstract class EmployerEvent {}

class GetEmployees extends EmployerEvent {
  final id;
  final radius;
  GetEmployees(this.id, this.radius);
}

class GetEmployeeById extends EmployerEvent {
  final id;
  GetEmployeeById(this.id);
}

class GetAllPosts extends EmployerEvent {}
