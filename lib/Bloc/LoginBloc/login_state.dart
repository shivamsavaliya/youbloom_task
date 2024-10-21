part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

class EmptyMobileState extends LoginState {}

class EmptyOtpState extends LoginState {}

class SendOtpState extends LoginState {
  final int otp;

  SendOtpState({required this.otp});
}

class OtpSuccessState extends LoginState {}

class OtpErrorState extends LoginState {}
