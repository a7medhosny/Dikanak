import 'package:dikanak/core/helpers/local_storage/shared_preferences.dart';
import 'package:dikanak/core/networking/consts.dart';
import 'package:dikanak/core/routing/routes.dart';
import 'package:dikanak/features/auth/presention/widgets/alert_diolag.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/cubits/cubit/auth_cubit.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
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
          Navigator.pop(context); // Close the alertDialog

          showAlertDialog(
            context: context,
            backgroundColor: Colors.red,
            content: Text(
              state.errorMessage,
              textDirection: TextDirection.rtl,
            ),
          );
        } else if (state is LoginSuccess) {
          Navigator.pop(context);
          CacheNetwork.insertToCache(
              key: token, value: state.userModel.token);
          Navigator.pushReplacementNamed(context, Routes.layoutScreen);
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
                      Center(
                        child: Text(
                          'Dikanak',
                          style: TextStyle(
                              fontSize: 50, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 60),
                      Text(
                        "Login",
                        style: TextStyle(
                            fontSize: 22.5, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 30),
                      customFormItem(
                        hintTitle: "Email",
                        controller: emailController,
                      ),
                      SizedBox(height: 20),
                      customFormItem(
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
                            // Using BlocProvider to access the AuthCubit
                            BlocProvider.of<AuthCubit>(context).login(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                          }
                        },
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            state is AuthLoading ? "Loading..." : "Login",
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
                          const Text('does not have an account? ',
                              style: TextStyle(color: Colors.black)),
                          SizedBox(width: 4),
                          InkWell(
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                  context, Routes.registerScreen);
                            },
                            child: const Text('Sign up',
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

  Widget customFormItem({
    required TextEditingController controller,
    required String hintTitle,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintTitle,
        border: const OutlineInputBorder(),
      ),
      obscureText:
          hintTitle.toLowerCase().contains("password"), // For password fields
      validator: (input) {
        if (input == null || input.isEmpty) {
          return "$hintTitle must not be empty!";
        }

        return null;
      },
    );
  }
}
