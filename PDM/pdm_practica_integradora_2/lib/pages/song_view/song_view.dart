import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../favorites_page/bloc/favorites_bloc.dart';

class SongView extends StatefulWidget {
  final Map<dynamic, dynamic> song;
  SongView({Key? key, required this.song}) : super(key: key);

  @override
  State<SongView> createState() => _SongViewState();
}

class _SongViewState extends State<SongView> {
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
        actions: [
          BlocConsumer<FavoritesBloc, FavoritesState>(
            listener: (context, state) {
              if (state is DuplicateFavorites) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Song already on favorites"),
                  ),
                );
              } else if (state is SuccessfulAddedToFavorites) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Song added to favorites"),
                  ),
                );
              } else if (state is SuccessfulRemovedFromFavorites) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Deleted from favorites"),
                  ),
                );
              } else if (state is UnSuccessfulAddedToFavorites ||
                  state is UnSuccessfulRemovedFromFavorites) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Error processing your request"),
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is DuplicateFavorites ||
                  state is SuccessfulAddedToFavorites) {
                return IconButton(
                  onPressed: () {
                    BlocProvider.of<FavoritesBloc>(context)
                        .add(RemoveFromFavorites(favoriteToRemove: {
                      'song_name': widget.song["title"].toString(),
                      'song_artist': widget.song["artist"].toString(),
                    }));
                  },
                  icon: Icon(Icons.favorite),
                );
              } else {
                return IconButton(
                  onPressed: () {
                    BlocProvider.of<FavoritesBloc>(context).add(AddToFavorites(
                      newFavortie: {
                        'image': widget.song['spotify'] == null
                            ? "no_song"
                            : widget.song["spotify"]["album"]["images"][1]
                                ["url"],
                        'more_links': widget.song["song_link"],
                        'song_name': widget.song["title"],
                        'song_artist': widget.song["artist"],
                      },
                    ));
                  },
                  icon: Icon(Icons.favorite_outline),
                );
              }
            },
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            widget.song["spotify"] != null
                ? Image.network(
                    widget.song["spotify"]["album"]["images"][1]["url"])
                : Container(
                    width: 300,
                    height: 300,
                    color: Colors.indigo,
                  ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Column(
                children: [
                  Text(
                    widget.song["title"],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    widget.song["album"],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(widget.song["artist"]),
                  Text(widget.song["release_date"].substring(0, 4)),
                ],
              ),
            ),
            Column(
              children: [
                Text("Abrir con:"),
                ButtonBar(
                  alignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      onPressed: () async {
                        if (widget.song["spotify"] == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Apple music link unavailable"),
                            ),
                          );
                        } else {
                          var _url = Uri.parse(widget.song["spotify"]
                              ["external_urls"]["spotify"]);
                          if (!await launchUrl(_url)) {
                            throw 'Could not launch $_url';
                          }
                        }
                      },
                      icon: Icon(BootstrapIcons.spotify),
                    ),
                    IconButton(
                      onPressed: () async {
                        if (widget.song["apple_music"] == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Apple music link unavailab"),
                            ),
                          );
                        } else {
                          var _url =
                              Uri.parse(widget.song["apple_music"]["url"]);
                          if (!await launchUrl(_url)) {
                            throw 'Could not launch $_url';
                          }
                        }
                      },
                      icon: Icon(BootstrapIcons.apple),
                    ),
                    IconButton(
                      onPressed: () async {
                        var _url = Uri.parse(widget.song["song_link"]);
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
          ],
        ),
      ),
    );
  }
}
