import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<CheckAuthStatus>(_chekAuthStatus);
    on<LogInPressed>(_logInGoogle);
    on<LogOutPressed>(_logOutGoogle);
  }

  FutureOr<void> _chekAuthStatus(event, emit) async {
    if (await FirebaseAuth.instance.currentUser != null) {
      emit(LoggedInState());
    } else {
      emit(LoggedOutState());
    }
  }

  FutureOr<void> _logInGoogle(event, emit) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      emit(LoggedInState());
    } catch (error) {
      emit(ErrorState());
    }
  }

  FutureOr<void> _logOutGoogle(event, emit) async {
    try {
      await FirebaseAuth.instance.signOut();
      emit(LoggedOutState());
    } catch (error) {
      emit(ErrorState());
    }
  }
}
