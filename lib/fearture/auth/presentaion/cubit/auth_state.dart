import 'package:firebase_auth/firebase_auth.dart';

class AuthState {}

class AuthAlitilaState extends AuthState {}

class AuthLogSccsesState extends AuthState {}

class AuthLogLoadingState extends AuthState {}

class AuthLogErorrState extends AuthState {
  String erorr;

  AuthLogErorrState({required this.erorr});
}

class AuthRegSccsesState extends AuthState {}

class AuthRegLoadingState extends AuthState {}

class AuthRegErorrState extends AuthState {
  String erorr;

  AuthRegErorrState({required this.erorr});
}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final User user;
  AuthSuccess(this.user);
}

class AuthFailure extends AuthState {
  final String error;
  AuthFailure(this.error);
}
