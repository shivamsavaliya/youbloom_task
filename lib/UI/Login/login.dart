import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otp_pin_field/otp_pin_field.dart';
import 'package:youbloom_task/Bloc/LoginBloc/login_bloc.dart';
import 'package:youbloom_task/Constants/colors.dart';

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
  bool isVisible = false;

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
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
              child: TextFormField(
                controller: _controller,
                validator: (value) {
                  if (value!.isEmpty && value == '') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text(
                          "Enter Mobile Number",
                          style: TextStyle(fontSize: 18),
                        ),
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    );
                  } else if (value.length < 10) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text(
                          "Enter valid Mobile Number",
                          style: TextStyle(fontSize: 18),
                        ),
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    );
                  }
                  return null;
                },
                style: const TextStyle(
                  height: 1,
                  fontSize: 20,
                ),
                keyboardType: TextInputType.phone,
                inputFormatters: [LengthLimitingTextInputFormatter(10)],
                decoration: InputDecoration(
                  filled: true,
                  hintText: "Enter Mobile Number",
                  fillColor: Colors.white,
                  focusColor: Colors.white,
                  contentPadding: EdgeInsets.zero,
                  constraints: BoxConstraints(
                    maxHeight: 50,
                    maxWidth: MediaQuery.of(context).size.width * 0.80,
                  ),
                  prefixIcon: const Icon(Icons.phone),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ),
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
            BlocConsumer<LoginBloc, LoginState>(
              bloc: _bloc,
              listener: (context, state) {
                if (state is CheckOtpState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text(
                        "Login Successfull",
                        style: TextStyle(fontSize: 18),
                      ),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                } else if (state is OtpErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text(
                        "Try again!!!",
                        style: TextStyle(fontSize: 18),
                      ),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                }
                // else if(state is SendOtpState){
                //   var otp = state.runtimeType as SendOtpState;
                //   ScaffoldMessenger.of(context).showSnackBar(
                //       SnackBar(
                //         content:  Text(
                //           otp.,
                //           style: TextStyle(fontSize: 18),
                //         ),
                //         behavior: SnackBarBehavior.floating,
                //         shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(10),
                //         ),
                //       ),
                //     );
                // }
              },
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: () {
                    print("otpp---" + otpText);
                    if (otpText.isEmpty && otpText == '') {}
                    // _bloc.add(CheckOtpEvent(otp: otpText));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: btnColor,
                    fixedSize: const Size(140, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Get OTP",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
