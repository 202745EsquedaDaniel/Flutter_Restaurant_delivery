import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:myapp/features/auth/domain/entities/app_user.dart';
import 'package:myapp/features/auth/domain/repos/auth_repo.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';

class FirebaseAuthRepo implements AuthRepo {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  // solo puse loginWithEmailPassword o otra de las otras y todo se genera solo
  @override
  Future<AppUser?> loginWithEmailPassword(String email, String password) async {
    try {
      //  attempt sign in
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      // fetch user document from firestore
      DocumentSnapshot userDoc =
          await firebaseFirestore
              .collection("users")
              .doc(userCredential.user!.uid)
              .get();

      //  create user
      AppUser user = AppUser(
        uid: userCredential.user!.uid,
        email: email,
        name: userDoc["name"],
        orgId: userDoc["orgId"],
      );

      //  return user
      return user;
    }
    // catch any errors...
    catch (e) {
      throw Exception('Error logging in: $e');
    }
  }

  @override
  Future<AppUser?> registerWithEmailPassword(
    String name,
    String email,
    String password,
  ) async {
    try {
      //  attempt sign up
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      //  create user
      AppUser user = AppUser(
        uid: userCredential.user!.uid,
        email: email,
        name: name,
        orgId: "3",
      );

      //  save user to firestore
      await firebaseFirestore
          .collection('users')
          .doc(user.uid)
          .set(user.toJson());

      //  return user
      return user;
    }
    // catch any errors...
    catch (e) {
      throw Exception('Register failed: $e');
    }
  }

  @override
  Future<AppUser?> signInWithGoogle() async {
    try {
      GoogleSignIn googleSignIn;

      if (kIsWeb) {
        googleSignIn = GoogleSignIn(
          clientId:
              '185358176919-d54dudhtj7jiuid57blqboogvksdcmo6.apps.googleusercontent.com',
          scopes: ['email'],
        );
      } else {
        googleSignIn = GoogleSignIn(scopes: ['email']);
      }

      final GoogleSignInAccount? gUser = await googleSignIn.signIn();
      if (gUser == null) throw Exception('Google Sign-In cancelled');

      final GoogleSignInAuthentication gAuth = await gUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      final userCredential = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );

      final uid = userCredential.user!.uid;
      final email = userCredential.user?.email ?? '';

      // Verifica si el usuario ya está en Firestore
      final userDoc =
          await FirebaseFirestore.instance.collection("users").doc(uid).get();

      if (!userDoc.exists) {
        final newUser = AppUser(
          uid: uid,
          email: email,
          name: 'user-${DateTime.now().millisecondsSinceEpoch}',
          orgId: '3',
        );

        await FirebaseFirestore.instance
            .collection("users")
            .doc(uid)
            .set(newUser.toJson());

        return newUser;
      } else {
        final data = userDoc.data() as Map<String, dynamic>;
        return AppUser(
          uid: uid,
          email: email,
          name: data['name'],
          orgId: data['orgId'],
        );
      }
    } catch (e) {
      throw Exception('Error with Google sign-in: $e');
    }
  }

  @override
  Future<void> logout() async {
    await firebaseAuth.signOut();
  }

  @override
  Future<AppUser?> getCurrentUser() async {
    //  get current logged in user from firebase
    final firebaseUser = firebaseAuth.currentUser;

    //  no user logged in..
    if (firebaseUser == null) {
      return null;
    }

    // fetch user document from firebase
    DocumentSnapshot userDoc =
        await firebaseFirestore.collection("users").doc(firebaseUser.uid).get();

    // check if user doc exists
    if (!userDoc.exists) {
      return null;
    }

    //  return user
    return AppUser(
      uid: firebaseUser.uid,
      email: firebaseUser.email!,
      name: userDoc["name"],
      orgId: userDoc["orgId"],
    );
  }
}
