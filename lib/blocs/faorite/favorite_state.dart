part of 'favorite_bloc.dart';

abstract class FavoriteState extends Equatable {
  const FavoriteState();
}

class FavoritesLoading extends FavoriteState {
  @override
  List<Object?> get props => [];
}

class FavoritesLoaded extends FavoriteState {
  final Favorites favorites;

  const FavoritesLoaded(this.favorites);
  @override
  List<Object?> get props => [favorites];
}

class FavoritesError extends FavoriteState {
  final String error;
  const FavoritesError(this.error);
  @override
  List<Object?> get props => [error];
}
