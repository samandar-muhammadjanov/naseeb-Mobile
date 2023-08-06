// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:naseeb/domain/models/get_employee_model.dart';
import 'package:naseeb/domain/models/post_for_employee.dart';
import 'package:naseeb/storage/local_storage_repository.dart';
import 'package:naseeb/domain/models/favorite_model.dart';
part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoritesBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final LocalstorageRepository _localstorageRepository;
  final EmployeeLocalstorageRepository _employeeLocalstorageRepository;
  FavoritesBloc(
      {required LocalstorageRepository localstorageRepository,
      required EmployeeLocalstorageRepository employeeLocalstorageRepository})
      : _localstorageRepository = localstorageRepository,
        _employeeLocalstorageRepository = employeeLocalstorageRepository,
        super(FavoritesLoading()) {
    on<StartFavorites>((event, emit) => _startFavorites());
    on<AddFavoritePost>((event, emit) => _addFavorites(event, state));
    on<RemoveFavoritePost>((event, emit) => _removeFavorites(event, state));
    on<AddFavoriteEmployee>(
        (event, emit) => _addFavoritesEmployee(event, state));
    on<RemoveFavoriteEmployee>(
        (event, emit) => _removeFavoritesEmployee(event, state));
  }
  void _startFavorites() async {
    emit(FavoritesLoading());
    try {
      Box box = await _localstorageRepository.openBox();
      List<Datum> posts = _localstorageRepository.getFavorites(box);
      await Future.delayed(const Duration(seconds: 1));
      emit(FavoritesLoaded(Favorites(posts: posts)));
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
        _localstorageRepository.addNewstoFavorites(box, event.post);
        emit(
          FavoritesLoaded(
            Favorites(
              posts: List.from(state.favorites.posts)..add(event.post),
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
        _localstorageRepository.removeNewsFromFavorites(box, event.post);
        emit(
          FavoritesLoaded(
            Favorites(
              posts: List.from(state.favorites.posts)..remove(event.post),
            ),
          ),
        );
      } catch (e) {
        emit(FavoritesError(e.toString()));
      }
    }
  }

  void _addFavoritesEmployee(
    AddFavoriteEmployee event,
    FavoriteState state,
  ) async {
    if (state is FavoritesLoaded) {
      try {
        Box box = await _employeeLocalstorageRepository.openBoxEmployee();
        _employeeLocalstorageRepository.addNewstoFavoritesEmployee(
            box, event.employee);
        emit(
          FavoritesLoaded(
            Favorites(
              employee: List.from(state.favorites.employee)
                ..add(event.employee),
            ),
          ),
        );
      } catch (e) {
        emit(FavoritesError(e.toString()));
      }
    }
  }

  void _removeFavoritesEmployee(
      RemoveFavoriteEmployee event, FavoriteState state) async {
    if (state is FavoritesLoaded) {
      try {
        Box box = await _employeeLocalstorageRepository.openBoxEmployee();
        _employeeLocalstorageRepository.removeNewsFromFavoritesEmployee(
            box, event.employee);
        emit(
          FavoritesLoaded(
            Favorites(
              employee: List.from(state.favorites.employee)
                ..remove(event.employee),
            ),
          ),
        );
      } catch (e) {
        emit(FavoritesError(e.toString()));
      }
    }
  }
}
