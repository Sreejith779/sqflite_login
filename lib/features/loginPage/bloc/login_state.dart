part of 'login_bloc.dart';

@immutable
abstract class LoginState {}
abstract class LoginActionState extends LoginState{}

  class LoginInitial extends LoginState {}
class LoginLoadedState extends LoginState{}
class LoginSuccessActionState extends LoginActionState{
final Map<String,dynamic>userData;

  LoginSuccessActionState({required this.userData});
}
class LoginFailedActionState extends LoginActionState{}