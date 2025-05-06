import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/features/kiosk/presentation/pages/home_page.dart';
import 'package:myapp/services/auth/login_or_register.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // if user is logged in
          if (snapshot.hasData) {
            return HomeKioskPage();
          }
          // if user NOT logged in
          else {
            return LoginOrRegister();
          }
        },
      ),
    );
  }
}
