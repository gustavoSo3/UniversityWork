part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class CheckAuthStatus extends LoginEvent {}

class LogInPressed extends LoginEvent {}

class LogOutPressed extends LoginEvent {}
