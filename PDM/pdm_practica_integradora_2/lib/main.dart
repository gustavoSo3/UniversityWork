import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practica_2/pages/home_page/bloc/music_recognition_bloc.dart';

import './pages/login_page/login_page.dart';
import './pages/home_page/home_page.dart';
import 'firebase_options.dart';

import './pages/favorites_page/bloc/favorites_bloc.dart';
import './pages/login_page/bloc/login_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
    ],
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => LoginBloc()..add(CheckAuthStatus()),
      ),
      BlocProvider(
        create: (context) => FavoritesBloc(),
      ),
      BlocProvider(
        create: (context) => MusicRecognitionBloc(),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      theme: ThemeData(
        /// Ligth theme config
        brightness: Brightness.light,
        primarySwatch: Colors.indigo,
      ),
      darkTheme: ThemeData(
        /// Dark theme config
        brightness: Brightness.dark,
        primarySwatch: Colors.indigo,
      ),
      themeMode: ThemeMode.dark,
      home: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is ErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Error try again."),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is LoggedInState) {
            return HomePage();
          } else if (state is LoggedOutState) {
            return LoginPage();
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
