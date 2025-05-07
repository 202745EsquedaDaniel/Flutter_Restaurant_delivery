/*

Auth Repository - Outlines the possible auth operations for this App.

*/

import 'package:myapp/features/auth/domain/entities/app_user.dart';

abstract class AuthRepo {
  Future<AppUser?> loginWithEmailPassword(String email, String password);
  Future<AppUser?> registerWithEmailPassword(
    String name,
    String email,
    String password,
  );
  Future<void> logout();
  Future<AppUser?> signInWithGoogle();

  Future<AppUser?> getCurrentUser();
}
