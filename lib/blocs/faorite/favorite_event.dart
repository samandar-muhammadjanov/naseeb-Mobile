part of 'favorite_bloc.dart';

abstract class FavoriteEvent {
  const FavoriteEvent();
}

class StartFavorites extends FavoriteEvent {}

class AddFavoritePost extends FavoriteEvent {
  final Datum product;
  const AddFavoritePost(this.product);
}

class RemoveFavoritePost extends FavoriteEvent {
  final Datum product;
  const RemoveFavoritePost(this.product);
}
