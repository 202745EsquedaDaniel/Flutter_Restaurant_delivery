import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/features/auth/presentation/components/my_button.dart';
import 'package:myapp/features/auth/presentation/components/my_text_field.dart';
import 'package:myapp/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:myapp/features/kiosk/presentation/components/constrained_scaffold.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  const RegisterPage({super.key, this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //  text Editing Controller
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void register() {
    //  prepare info
    final String name = nameController.text;
    final String email = emailController.text;
    final String password = passwordController.text;
    final String confirmPassword = confirmPasswordController.text;

    //  auth cubit
    final authCubit = context.read<AuthCubit>();

    //  ensure the fields aren't empty
    if (email.isNotEmpty &&
        name.isNotEmpty &&
        password.isNotEmpty &&
        confirmPassword.isNotEmpty) {
      //  ensure passwords match
      if (password == confirmPassword) {
        authCubit.register(name, email, password);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Passwords do not match!")),
        );
      }
    }
    // fields are empty -> display error
    else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please enter all fields")));
    }
  }

  // Suggested code may be subject to a license. Learn more: ~LicenseLog:3764799691.
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedScaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // logo
                Icon(
                  Icons.lock_open_rounded,
                  size: 100,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),

                const SizedBox(height: 25),

                // message, app slogan
                const Text("Let´s get started"),

                const SizedBox(height: 25),

                // name input
                MyTextField(
                  controller: nameController,
                  hintText: "Name",
                  obscureText: false,
                  label: "Nombre Completo",
                ),

                const SizedBox(height: 10),

                // email input
                MyTextField(
                  controller: emailController,
                  hintText: "Email",
                  obscureText: false,
                  label: "Email",
                ),

                const SizedBox(height: 10),
                // password input
                MyTextField(
                  controller: passwordController,
                  hintText: "Contraseña",
                  obscureText: true,
                  label: "Contraseña",
                ),

                const SizedBox(height: 10),

                // Confirm password input
                MyTextField(
                  controller: confirmPasswordController,
                  hintText: "Confirm Password",
                  obscureText: true,
                  label: "Confirmar Contraseña",
                ),

                const SizedBox(height: 10),

                // login button
                MyButton(text: "Sign Up", onTap: register),

                const SizedBox(height: 25),

                //Already have an account? login Here
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        "Login Now",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
