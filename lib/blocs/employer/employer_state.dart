part of 'employer_bloc.dart';

abstract class EmployerState {}

class EmployerInitial extends EmployerState {}

class EmployerLoading extends EmployerState {}

class EmployerLoaded extends EmployerState {
  final GetEmployee employees;
  EmployerLoaded(
    this.employees,
  );
}

class EmployeeDetailLoaded extends EmployerState {
  final GetEmployeeDetail? employee;
  EmployeeDetailLoaded(this.employee);
}

class AllPostsLoaded extends EmployerState {
  final Posts posts;
  AllPostsLoaded(this.posts);
}

class PostDetailLoaded extends EmployerState {
  final PostById post;
  PostDetailLoaded(this.post);
}

class PostsForEmployeeLoaded extends EmployerState {
  final PostsForEmplyeeModel posts;
  PostsForEmployeeLoaded(this.posts);
}

class EmployerError extends EmployerState {
  final String error;
  EmployerError(
    this.error,
  );
}
