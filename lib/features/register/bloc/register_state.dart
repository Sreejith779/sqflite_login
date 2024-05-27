part of 'register_bloc.dart';

@immutable
abstract class RegisterState {}

abstract class RegisterActionState extends RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoadedState extends RegisterState {}

class RegisterSuccessActionState extends RegisterState {
  final int id;

  RegisterSuccessActionState({required this.id});
}
