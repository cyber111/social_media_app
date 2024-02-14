import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/helper/helper_functions.dart';

import '../components/my_button.dart';
import '../components/my_text_button.dart';
import '../components/my_text_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  Future<void> registerUser() async {
    //dialog loading
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    //match passwords
    if (passwordController.text != confirmPasswordController.text) {
      Navigator.pop(context);
      //call a error showing method
      displayErrorMessage('Passwords don\'t match', context);
    } else {
      //try creating user
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: emailController.text, password: passwordController.text);
        Navigator.pop(context);
      } on FirebaseException catch (e) {
        //pop
        Navigator.pop(context);
        //error msg
        displayErrorMessage(e.code, context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
              'Let\'s create a account for you,',
              style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.inversePrimary),
            ),
            const SizedBox(height: 30),
            //userName
            MyTextField(hintText: 'username', textEditingController: userNameController, obscureText: false),
            //email
            MyTextField(hintText: 'Email', textEditingController: emailController, obscureText: false),
            //password
            MyTextField(hintText: 'Password', textEditingController: passwordController, obscureText: true),
            //password
            MyTextField(
                hintText: 'Confirm Password', textEditingController: confirmPasswordController, obscureText: true),
            //Buttons
            MyButton(
              onTap: registerUser,
              child: Text(
                'Sign Up',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary, fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already a Member? ',
                  style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
                ),
                MyTextButton(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    text: 'Login')
              ],
            )
          ],
        ),
      ),
    );
  }
}
