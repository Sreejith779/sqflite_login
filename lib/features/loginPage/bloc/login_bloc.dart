import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sqflite_login/database/sqlHelper.dart';
import 'package:sqflite_login/model/dbModel.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
  on<LoginInitialEvent>(loginInitialEvent);
  on<LoginUserEvent>(loginUserEvent);
  }

  FutureOr<void> loginInitialEvent(LoginInitialEvent event, Emitter<LoginState> emit) {
    emit(LoginLoadedState());
  }

  FutureOr<void> loginUserEvent(LoginUserEvent event, Emitter<LoginState> emit) async{

    final result = await SqlHelper.userLogin(email: event.email, password: event.password);
    if (result != null) {
      emit(LoginSuccessActionState(userData:result ));
    } else {
      emit(LoginFailedActionState());
     print("login failed");

    }
  }
}
