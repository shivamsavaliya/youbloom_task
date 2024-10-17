part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

class LoginInitialEvent extends LoginEvent {}

class ValidationEvent extends LoginEvent {
  final GlobalKey<FormState> formKey;
  ValidationEvent({required this.formKey});
}

class CheckOtpEvent extends LoginEvent {
  final String otp;

  CheckOtpEvent({required this.otp});
}

class SendOtpEvent extends LoginEvent {}
