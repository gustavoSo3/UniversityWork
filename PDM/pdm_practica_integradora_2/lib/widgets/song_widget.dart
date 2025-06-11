import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../pages/favorites_page/bloc/favorites_bloc.dart';

class SongWidget extends StatelessWidget {
  final dynamic favorite;

  const SongWidget({Key? key, required this.favorite}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(40, 5, 40, 5),
      child: Column(
        children: [
          this.favorite["image"] != "no_song"
              ? Image.network(
                  this.favorite["image"],
                  width: 250,
                  height: 250,
                )
              : Container(
                  width: 250,
                  height: 250,
                  color: Colors.indigo,
                ),
          Text(
            this.favorite["song_name"],
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            this.favorite["song_artist"],
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () => showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: Text("Remove from Favorites"),
                    content: Text(
                        "You want to remove this song from your favorites?"),
                    actions: [
                      MaterialButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text("Cancel"),
                      ),
                      MaterialButton(
                        onPressed: () async {
                          Navigator.pop(context);
                          BlocProvider.of<FavoritesBloc>(context).add(
                            RemoveFromFavorites(favoriteToRemove: {
                              'song_name':
                                  this.favorite["song_name"].toString(),
                              'song_artist':
                                  this.favorite["song_artist"].toString(),
                            }),
                          );
                          BlocProvider.of<FavoritesBloc>(context)
                              .add(LoadFavorites());
                        },
                        child: Text("Yes, remove"),
                        color: Colors.red,
                      ),
                    ],
                  ),
                ),
                icon: Icon(Icons.favorite),
              ),
              IconButton(
                onPressed: () async {
                  var _url = Uri.parse(this.favorite["more_links"]);
                  if (!await launchUrl(_url)) {
                    throw 'Could not launch $_url';
                  }
                },
                icon: Icon(Icons.link),
              ),
            ],
          )
        ],
      ),
    );
  }
}
