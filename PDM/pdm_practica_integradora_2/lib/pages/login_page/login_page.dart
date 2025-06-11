import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/login_bloc.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(
              Icons.music_note,
              size: 250,
            ),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  BlocProvider.of<LoginBloc>(context).add(LogInPressed());
                },
                icon: Icon(Icons.login),
                label: Text("Login with Google"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
