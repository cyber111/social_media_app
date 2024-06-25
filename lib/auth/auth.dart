  import 'package:firebase_auth/firebase_auth.dart';
  import 'package:flutter/material.dart';
  import 'package:social_media_app/pages/home_page.dart';
  import 'package:social_media_app/pages/login_page.dart';

  class AuthPage extends StatelessWidget {
    const AuthPage({super.key});

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            //loggedIn
            if(snapshot.hasData) {
              return const HomePage();
            } else {
              return const LoginPage();
            }
            //NotLoggedIn
          },
        ),
      );
    }
  }
