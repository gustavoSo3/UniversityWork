import 'package:avatar_glow/avatar_glow.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../favorites_page/bloc/favorites_bloc.dart';
import '../favorites_page/favorites_page.dart';
import '../song_view/song_view.dart';

import '../login_page/bloc/login_bloc.dart';
import './bloc/music_recognition_bloc.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BlocBuilder<MusicRecognitionBloc, MusicRecognitionState>(
              builder: (context, state) {
                if (state is Recording) {
                  return Text(
                    "Recording...",
                    style: TextStyle(fontSize: 30),
                  );
                } else if (state is LoadingSong) {
                  return Text(
                    "Loading Song...",
                    style: TextStyle(fontSize: 30),
                  );
                }
                return Text(
                  "Tap to listen",
                  style: TextStyle(fontSize: 30),
                );
              },
            ),
            BlocConsumer<MusicRecognitionBloc, MusicRecognitionState>(
              listener: (context, state) {
                if (state is Error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          "There was an error trying to recognize, try again"),
                    ),
                  );
                } else if (state is SongLoaded) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          SongView(song: state.song_info["result"]),
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is MusicRecognitionInitial) {
                  return MaterialButton(
                    onPressed: () {
                      BlocProvider.of<MusicRecognitionBloc>(context)
                          .add(RecordSong());
                    },
                    child: Icon(
                      Icons.mic,
                      size: 250,
                    ),
                    color: Colors.white,
                    textColor: Colors.black,
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(16),
                  );
                } else if (state is Recording) {
                  return AvatarGlow(
                    repeatPauseDuration: Duration(milliseconds: 10),
                    endRadius: 260,
                    child: Icon(
                      Icons.mic,
                      size: 250,
                    ),
                    shape: BoxShape.circle,
                  );
                } else if (state is LoadingSong) {
                  return CircularProgressIndicator();
                } else
                  return Container();
              },
            ),
            ButtonBar(
              alignment: MainAxisAlignment.spaceAround,
              children: [
                MaterialButton(
                  onPressed: () {
                    BlocProvider.of<FavoritesBloc>(context)
                        .add(LoadFavorites());
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FavoritesPage()),
                    );
                  },
                  child: Icon(
                    Icons.favorite,
                    size: 30,
                  ),
                  color: Colors.white,
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(16),
                ),
                MaterialButton(
                  onPressed: () => showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: Text("Loging out"),
                      content: Text("You are about to log out, are you sure"),
                      actions: [
                        MaterialButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text("Cancel"),
                        ),
                        MaterialButton(
                          onPressed: () {
                            Navigator.pop(context);
                            BlocProvider.of<LoginBloc>(context)
                                .add(LogOutPressed());
                          },
                          child: Text("Yes, log out"),
                          color: Colors.red,
                        ),
                      ],
                    ),
                  ),
                  child: Icon(
                    Icons.logout,
                    size: 30,
                  ),
                  color: Colors.white,
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(16),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
