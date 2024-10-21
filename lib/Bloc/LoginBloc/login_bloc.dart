import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginInitialEvent>(loginInitialEvent);
    on<ValidationEvent>(validationEvent);
    on<CheckOtpEvent>(checkOtpEvent);
    on<SendOtpEvent>(sendOtpEvent);
  }

  late int otp;
  bool otpGenereted = false;

  FutureOr<void> loginInitialEvent(
      LoginInitialEvent event, Emitter<LoginState> emit) {}

  FutureOr<void> validationEvent(
      ValidationEvent event, Emitter<LoginState> emit) {
    if (!event.formKey.currentState!.validate()) {
      emit(EmptyMobileState());
    }
  }

  FutureOr<void> checkOtpEvent(CheckOtpEvent event, Emitter<LoginState> emit) {
    otpGenereted = false;
    if (event.otp.isEmpty && event.otp == '' && event.otp.length < 4) {
      emit(EmptyOtpState());
    } else {
      if (event.otp == otp.toString()) {
        emit(OtpSuccessState());
      } else {
        emit(OtpErrorState());
      }
    }
  }

  FutureOr<void> sendOtpEvent(SendOtpEvent event, Emitter<LoginState> emit) {
    otp = Random().nextInt(9999);
    otpGenereted = true;
    emit(SendOtpState(otp: otp));
  }
}
