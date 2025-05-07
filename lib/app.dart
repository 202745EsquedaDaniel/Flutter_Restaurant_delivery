import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/features/auth/data/firebase_auth_repo.dart';
import 'package:myapp/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:myapp/features/auth/presentation/cubits/auth_states.dart';
import 'package:myapp/features/auth/presentation/pages/auth_page.dart';
import 'package:myapp/features/catalog/data/firebase_catalog_repo.dart';
import 'package:myapp/features/catalog/presentation/cubits/catalog_cubit.dart';
import 'package:myapp/features/catalog/presentation/cubits/restaurant_cubit.dart';
import 'package:myapp/features/kiosk/presentation/pages/home_page.dart';
import 'package:myapp/features/pos/presentation/pages/POS_page.dart';
import 'package:myapp/themes/light_mode.dart';

/*
APP - Root Level

--------------------------------

Repositories fo the database
- firebase

Bloc Providers: for state management
  - auth
  - profile
  - post
  - search
  - theme

Check Auth State
  - unautgenticated -> auth page (login/register)
  - authenticated -> home page 
*/

class MyApp extends StatelessWidget {
  // auth repo
  final firebaseAuthRepo = FirebaseAuthRepo();

  // catalog repo

  // profile repo

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //  provide cubits to app
    return MultiBlocProvider(
      providers: [
        // auth cubit
        BlocProvider<AuthCubit>(
          create:
              (context) => AuthCubit(authRepo: firebaseAuthRepo)..checkAuth(),
        ),
        // restaurant cubit
        BlocProvider(create: (_) => RestaurantCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightMode,
        home: BlocConsumer<AuthCubit, AuthState>(
          builder: (context, authState) {
            print(authState);

            //  unauthenticated -> auth page (login/register)
            if (authState is Unauthenticated) {
              return const AuthPage();
            }

            //  aunthenticated -> home page
            if (authState is Authenticated) {
              return const HomeKioskPage();
            }
            //  loading...
            else {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }
          },
          //  listen for errors
          listener: (context, state) {
            if (state is AuthError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
        ),
      ),
    );
  }
}
