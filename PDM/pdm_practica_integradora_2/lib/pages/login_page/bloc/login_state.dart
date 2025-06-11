part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoggedInState extends LoginState {}

class LoggedOutState extends LoginState {}

class ErrorState extends LoginState {}
