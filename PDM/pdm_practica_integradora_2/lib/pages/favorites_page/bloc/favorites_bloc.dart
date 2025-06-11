import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import 'package:collection/collection.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc() : super(FavoritesInitial()) {
    on<LoadFavorites>(_loadFavorites);
    on<AddToFavorites>(_addToFavorites);
    on<RemoveFromFavorites>(_removeFromFavorites);
  }

  Future<FutureOr<void>> _loadFavorites(event, emit) async {
    emit(LoadingFavorites());
    try {
      String? uId = await FirebaseAuth.instance.currentUser?.uid;
      CollectionReference favorites =
          await FirebaseFirestore.instance.collection("favorites");

      var document = await favorites.doc(uId).get();
      if (document["favorites"].length == 0) {
        emit(NoFavorites());
      } else {
        emit(LoadedFavorites(favorites: document["favorites"]));
      }
    } catch (e) {
      emit(ErrorLoadingFavorites());
    }
  }

  FutureOr<void> _addToFavorites(event, emit) async {
    String? uId = await FirebaseAuth.instance.currentUser?.uid;
    CollectionReference collection =
        FirebaseFirestore.instance.collection('favorites');
    var document = await collection.doc(uId).get();
    if (await document.data() == null) {
      try {
        collection.doc(uId).set({
          "favorites": [
            {
              'image': event.newFavortie['image'],
              'song_name': event.newFavortie['song_name'],
              'song_artist': event.newFavortie['song_artist'],
              'more_links': event.newFavortie['more_links'],
            }
          ],
        });
        emit(SuccessfulAddedToFavorites());
      } catch (e) {
        emit(UnSuccessfulAddedToFavorites());
      }
    } else {
      var list = document.get('favorites');
      if (list.any((element) => DeepCollectionEquality().equals(element, {
            'image': event.newFavortie['image'],
            'song_name': event.newFavortie['song_name'],
            'song_artist': event.newFavortie['song_artist'],
            'more_links': event.newFavortie['more_links'],
          }))) {
        emit(DuplicateFavorites());
      } else {
        list.add({
          'image': event.newFavortie['image'],
          'song_name': event.newFavortie['song_name'],
          'song_artist': event.newFavortie['song_artist'],
          'more_links': event.newFavortie['more_links'],
        });
        collection.doc(uId).set({
          "favorites": list,
        });
        emit(SuccessfulAddedToFavorites());
      }
    }
  }

  FutureOr<void> _removeFromFavorites(event, emit) async {
    String? uId = await FirebaseAuth.instance.currentUser?.uid;
    CollectionReference collection =
        FirebaseFirestore.instance.collection('favorites');
    var document = await collection.doc(uId).get();
    var list = await document.get('favorites');
    final index = list.indexWhere((element) =>
        element["song_name"] == event.favoriteToRemove["song_name"] &&
        element["song_artist"] == event.favoriteToRemove["song_artist"]);
    print(index);
    list.removeAt(index);

    collection.doc(uId).set({
      "favorites": list,
    });
    emit(SuccessfulRemovedFromFavorites());
  }
}
