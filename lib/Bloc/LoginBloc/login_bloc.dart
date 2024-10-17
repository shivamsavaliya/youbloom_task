import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<ValidationEvent>(validationEvent);
    on<CheckOtpEvent>(checkOtpEvent);
    on<SendOtpEvent>(sendOtpEvent);
  }

  late int otp;

  FutureOr<void> validationEvent(
      ValidationEvent event, Emitter<LoginState> emit) {
    if (event.formKey.currentState!.validate()) {
      // Navigator.of(context).
    }
  }

  FutureOr<void> checkOtpEvent(CheckOtpEvent event, Emitter<LoginState> emit) {
    if (event.otp == otp.toString()) {
      emit(CheckOtpState());
    } else {
      emit(OtpErrorState());
    }
  }

  FutureOr<void> sendOtpEvent(SendOtpEvent event, Emitter<LoginState> emit) {
    otp = Random().nextInt(9999);
    emit(SendOtpState());
  }
}
