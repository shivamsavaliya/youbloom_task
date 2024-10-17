part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

class EmptyMobileState extends LoginState {}

class SendOtpState extends LoginState {}

class CheckOtpState extends LoginState {}

class OtpSuccessState extends LoginState {}

class OtpErrorState extends LoginState {}
