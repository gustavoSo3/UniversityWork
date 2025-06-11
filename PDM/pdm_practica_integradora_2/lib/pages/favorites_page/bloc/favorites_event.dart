part of 'favorites_bloc.dart';

@immutable
abstract class FavoritesEvent {}

class LoadFavorites extends FavoritesEvent {}

class AddToFavorites extends FavoritesEvent {
  final Map<String, String> newFavortie;

  AddToFavorites({required this.newFavortie});
}

class RemoveFromFavorites extends FavoritesEvent {
  final Map<String, String> favoriteToRemove;

  RemoveFromFavorites({required this.favoriteToRemove});
}
