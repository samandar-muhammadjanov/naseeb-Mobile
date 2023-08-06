part of 'favorite_bloc.dart';

abstract class FavoriteEvent extends Equatable {
  const FavoriteEvent();
}

class StartFavorites extends FavoriteEvent {
  @override
  List<Object?> get props => [];
}

class AddFavoritePost extends FavoriteEvent {
  final Datum post;
  const AddFavoritePost(this.post);
  @override
  List<Object?> get props => [post];
}

class RemoveFavoritePost extends FavoriteEvent {
  final Datum post;
  const RemoveFavoritePost(this.post);
  @override
  List<Object?> get props => [post];
}

class AddFavoriteEmployee extends FavoriteEvent {
  final EmployeeDatum employee;
  const AddFavoriteEmployee(this.employee);
  @override
  List<Object?> get props => [employee];
}

class RemoveFavoriteEmployee extends FavoriteEvent {
  final EmployeeDatum employee;
  const RemoveFavoriteEmployee(this.employee);
  @override
  List<Object?> get props => [employee];
}
