part of 'favorite_bloc.dart';

abstract class FavoriteState {
  const FavoriteState();
}

class FavoritesLoading extends FavoriteState {}

class FavoritesLoaded extends FavoriteState {
  final Favorites favorites;

  const FavoritesLoaded(this.favorites);
}

class FavoritesError extends FavoriteState {
  final String error;
  FavoritesError(this.error);
}
