part of 'favorites_bloc.dart';

@immutable
abstract class FavoritesState {}

class FavoritesInitial extends FavoritesState {}

class LoadingFavorites extends FavoritesState {}

class LoadedFavorites extends FavoritesState {
  final List<dynamic> favorites;

  LoadedFavorites({required this.favorites});
  List<Object> get props => [favorites];
}

class ErrorLoadingFavorites extends FavoritesState {}

class NoFavorites extends FavoritesState {}

class SuccessfulAddedToFavorites extends FavoritesState {}

class DuplicateFavorites extends FavoritesState {}

class UnSuccessfulAddedToFavorites extends FavoritesState {}

class SuccessfulRemovedFromFavorites extends FavoritesState {}

class UnSuccessfulRemovedFromFavorites extends FavoritesState {}
