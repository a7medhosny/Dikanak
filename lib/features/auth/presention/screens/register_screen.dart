import 'package:dikanak/features/auth/logic/cubits/cubit/auth_cubit.dart';
import 'package:dikanak/features/auth/presention/widgets/form_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/alert_diolag.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        debugPrint("State is $state");
        if (state is AuthLoading) {
          showAlertDialog(
            context: context,
            backgroundColor: Colors.white,
            content: AnimatedContainer(
              duration: const Duration(seconds: 1),
              curve: Curves.easeIn,
              child: Row(
                children: [
                  const CupertinoActivityIndicator(color: Colors.green),
                  SizedBox(width: 12.5),
                  const Text("wait",
                      style: TextStyle(fontWeight: FontWeight.w500)),
                ],
              ),
            ),
          );
        } else if (state is AuthFailure) {
          debugPrint("ERROR is ${state.errorMessage}");

          showAlertDialog(
            context: context,
            backgroundColor: Colors.red,
            content: Text(
              state.errorMessage,
              textDirection: TextDirection.rtl,
            ),
          );
        } else if (state is RegisterSuccess) {
          Navigator.pop(context); // Close the alertDialog
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginScreen()));
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: const Text(""),
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Sign Up",
                        style: TextStyle(
                            fontSize: 22.5, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 30),
                      CustomTextField(
                        hintTitle: "User Name",
                        controller: nameController,
                      ),
                      SizedBox(height: 20),
                      CustomTextField(
                        hintTitle: "Email",
                        controller: emailController,
                      ),
                      SizedBox(height: 20),
                      CustomTextField(
                        hintTitle: "Phone",
                        controller: phoneController,
                      ),
                      SizedBox(height: 20),
                      CustomTextField(
                        hintTitle: "Password",
                        controller: passwordController,
                      ),
                      SizedBox(height: 20),
                      MaterialButton(
                        minWidth: double.infinity,
                        elevation: 0,
                        height: 40,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        color: const Color.fromARGB(255, 133, 132, 132),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                                      debugPrint("Email is ${emailController.text}");

                            // Using BlocProvider to access the AuthCubit
                            BlocProvider.of<AuthCubit>(context).register(
                              email: emailController.text,
                              name: nameController.text,
                              phone: phoneController.text,
                              password: passwordController.text,
                            );
                          }
                        },
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            state is AuthLoading ? "Loading..." : "Register",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.5,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Already have an account? ',
                              style: TextStyle(color: Colors.black)),
                          SizedBox(width: 4),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ),
                              );
                            },
                            child: const Text('Login',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 131, 129, 129),
                                    fontWeight: FontWeight.bold)),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}