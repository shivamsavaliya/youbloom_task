part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

class EmptyMobileState extends LoginState {}

class EmptyOtpState extends LoginState {}

class SendOtpState extends LoginState {
  final int otp;
  final bool otpGenereted;

  SendOtpState({required this.otp, required this.otpGenereted});
}

class CheckOtpState extends LoginState {}

class OtpSuccessState extends LoginState {}

class OtpErrorState extends LoginState {}
