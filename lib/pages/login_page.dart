import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/helper/helper_functions.dart';
import 'package:social_media_app/pages/sign_up_page.dart';

import '../components/my_button.dart';
import '../components/my_text_button.dart';
import '../components/my_text_field2.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void login() async {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    //try sign in
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);
      Navigator.pop(context);
    } on FirebaseException catch (e) {
      if (context.mounted) Navigator.pop(context);
      if (context.mounted) displayErrorMessage(e.code, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //logo
            Icon(
              Icons.lock_open_rounded,
              size: 125,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            const SizedBox(height: 30),
            //texts
            Text(
              'Welcome back you have been Missed',
              style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.inversePrimary),
            ),
            const SizedBox(height: 30),
            //email
            MyTextField2(hintText: 'Email', textEditingController: emailController, obscureText: false),
            //password
            MyTextField2(hintText: 'Password', textEditingController: passwordController, obscureText: true),
            //Forgot password
            Padding(
              padding: const EdgeInsets.only(right: 25.0, top: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Forgot Password',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                ],
              ),
            ),
            //Buttons
            MyButton(
              onTap: login,
              child: Text(
                'Login',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary, fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 30),
            //google and login options
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'New Here? ',
                  style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
                ),
                MyTextButton(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpPage()));
                    },
                    text: 'Register')
              ],
            )
          ],
        ),
      ),
    );
  }
}
