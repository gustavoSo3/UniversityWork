import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';

import './bloc/favorites_bloc.dart';
import '../../widgets/song_widget.dart';

class FavoritesPage extends StatefulWidget {
  FavoritesPage({Key? key}) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text("Favorites"),
      ),
      body: BlocConsumer<FavoritesBloc, FavoritesState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is LoadingFavorites) {
            return ListView.separated(
              itemCount: 3,
              separatorBuilder: (BuildContext context, int index) {
                return Spacer();
              },
              itemBuilder: (BuildContext context, int index) {
                return ProfilePageShimmer(
                  margin: EdgeInsets.fromLTRB(40, 5, 40, 5),
                  isRectBox: true,
                  isDarkMode: true,
                );
              },
            );
          } else if (state is LoadedFavorites) {
            return ListView.builder(
              itemCount: state.favorites.length,
              itemBuilder: (BuildContext context, int index) {
                return SongWidget(favorite: state.favorites[index]);
              },
            );
          } else if (state is NoFavorites) {
            return Center(
              child: Text("You dont have favorites, try adding some songs"),
            );
          }
          return Container();
        },
      ),
    );
  }
}
