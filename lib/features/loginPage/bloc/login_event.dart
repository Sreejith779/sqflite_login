part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}
class LoginInitialEvent extends LoginEvent{}

class LoginUserEvent extends LoginEvent{
  final String email;
  final String password;

  LoginUserEvent({required this.email, required this.password});
}