import 'package:flutter/material.dart';
import 'package:myapp/components/my_button.dart';
import 'package:myapp/components/my_text_field.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  const RegisterPage({
    super.key,
    this.onTap,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
//  text Editing Controller
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // logo
            Icon(
              Icons.lock_open_rounded,
              size: 100,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),

            SizedBox(height: 25),

            // message, app slogan
            Text("Let´s get started"),

            // email input
            MyTextField(
                controller: emailController,
                hintText: "Email",
                obscureText: false),

            SizedBox(height: 10),
            // password input
            MyTextField(
                controller: passwordController,
                hintText: "Contraseña",
                obscureText: true),

            SizedBox(height: 10),

            // Confirm password input
            MyTextField(
                controller: confirmPasswordController,
                hintText: "Confirm Password",
                obscureText: true),

            SizedBox(height: 10),

            // login button
            MyButton(
              text: "Sign Up",
              onTap: () {},
            ),

            SizedBox(height: 25),

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
                SizedBox(width: 4),
                GestureDetector(
                  onTap: widget.onTap,
                  child: Text(
                    "Login Now",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
