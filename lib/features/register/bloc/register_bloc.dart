import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sqflite_login/database/sqlHelper.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
on<RegisterInitialEvent>(registerInitialEvent);
on<RegisterUserEvent>(registerUserEvent);
  }

  FutureOr<void> registerInitialEvent(RegisterInitialEvent event, Emitter<RegisterState> emit) {
    emit(RegisterLoadedState());
  }

  FutureOr<void> registerUserEvent(RegisterUserEvent event, Emitter<RegisterState> emit) async{
    final id = await SqlHelper.addUser(name: event.name, email: event.email,password: event.password);
    print(id.toString());
emit(RegisterSuccessActionState(id: id));
  }
}
