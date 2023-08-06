// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:bloc/bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:naseeb/domain/models/post_for_employee.dart';
import 'package:naseeb/storage/local_storage_repository.dart';
import 'package:naseeb/domain/models/favorite_model.dart';
part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoritesBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final LocalstorageRepository _localstorageRepository;

  FavoritesBloc({required LocalstorageRepository localstorageRepository})
      : _localstorageRepository = localstorageRepository,
        super(FavoritesLoading()) {
    on<StartFavorites>((event, emit) => _startFavorites());
    on<AddFavoritePost>((event, emit) => _addFavorites(event, state));
    on<RemoveFavoritePost>((event, emit) => _removeFavorites(event, state));
  }
  void _startFavorites() async {
    emit(FavoritesLoading());
    try {
      Box box = await _localstorageRepository.openBox();
      List<Datum> news = _localstorageRepository.getFavorites(box);
      await Future.delayed(const Duration(seconds: 1));
      emit(FavoritesLoaded(Favorites(posts: news)));
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }

  void _addFavorites(
    AddFavoritePost event,
    FavoriteState state,
  ) async {
    if (state is FavoritesLoaded) {
      try {
        Box box = await _localstorageRepository.openBox();
        _localstorageRepository.addNewstoFavorites(box, event.product);
        emit(
          FavoritesLoaded(
            Favorites(
              posts: List.from(state.favorites.posts)..insert(0, event.product),
            ),
          ),
        );
      } catch (e) {
        emit(FavoritesError(e.toString()));
      }
    }
  }

  void _removeFavorites(RemoveFavoritePost event, FavoriteState state) async {
    if (state is FavoritesLoaded) {
      try {
        Box box = await _localstorageRepository.openBox();
        _localstorageRepository.removeNewsFromFavorites(box, event.product);
        emit(
          FavoritesLoaded(
            Favorites(
              posts: List.from(state.favorites.posts)..remove(event.product),
            ),
          ),
        );
      } catch (e) {
        emit(FavoritesError(e.toString()));
      }
    }
  }
}
