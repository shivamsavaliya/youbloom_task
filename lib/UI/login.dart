import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otp_pin_field/otp_pin_field.dart';
import 'package:youbloom_task/Bloc/LoginBloc/login_bloc.dart';
import 'package:youbloom_task/Constants/constants.dart';
import 'package:youbloom_task/UI/home.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final LoginBloc _bloc = LoginBloc();
  final TextEditingController _controller = TextEditingController();
  late String otpText;

  @override
  void initState() {
    super.initState();
    _bloc.add(LoginInitialEvent());
  }

  @override
  void dispose() {
    _controller.text;
    otpText = "";
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: BlocConsumer<LoginBloc, LoginState>(
        bloc: _bloc,
        listener: (context, state) {
          if (state is OtpSuccessState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(snackbarWidget("Login Successfull"));
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const Home(),
              ),
            );
          } else if (state is SendOtpState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(snackbarWidget(state.otp.toString()));
          } else if (state is EmptyMobileState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(snackbarWidget("Enter Correct Mobile Number"));
          } else if (state is EmptyOtpState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(snackbarWidget("Enter OTP"));
          } else if (state is OtpErrorState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(snackbarWidget("Enter Correct OTP"));
          }
        },
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                  child: TextFormField(
                    controller: _controller,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Number is required';
                      } else if (value.length < 10) {
                        return 'Mobile number must be 10 digits';
                      }
                      return null;
                    },
                    style: const TextStyle(
                      height: 1,
                      fontSize: 20,
                    ),
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: InputDecoration(
                      filled: true,
                      hintText: "Enter Mobile Number",
                      fillColor: Colors.white,
                      focusColor: Colors.white,
                      contentPadding: EdgeInsets.zero,
                      constraints: BoxConstraints(
                        maxHeight: 70,
                        maxWidth: MediaQuery.of(context).size.width * 0.80,
                      ),
                      prefixIcon: const Icon(Icons.phone),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ),
                if (state is SendOtpState ||
                    state is EmptyOtpState ||
                    state is OtpErrorState)
                  OtpPinField(
                    onSubmit: (text) {
                      otpText = text;
                    },
                    onChange: (text) {
                      otpText = text;
                    },
                    otpPinFieldDecoration: OtpPinFieldDecoration.custom,
                    otpPinFieldStyle: const OtpPinFieldStyle(
                      activeFieldBackgroundColor: Colors.white,
                      defaultFieldBackgroundColor: Colors.white,
                      fieldBorderRadius: 10,
                    ),
                  ),
                ElevatedButton(
                  onPressed: () {
                    if (_controller.text.isEmpty ||
                        _controller.text == '' ||
                        _controller.text.length < 10) {
                      _bloc.add(ValidationEvent(formKey: _formKey));
                    } else {
                      if (!_bloc.otpGenereted) {
                        _bloc.add(SendOtpEvent());
                      } else {
                        _bloc.add(CheckOtpEvent(otp: otpText));
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: mainColor,
                    fixedSize: const Size(140, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    _bloc.otpGenereted ? "Login" : "Get OTP",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  SnackBar snackbarWidget(String text) {
    return SnackBar(
      content: Text(
        text,
        style: const TextStyle(fontSize: 18),
      ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
