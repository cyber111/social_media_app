import 'package:flutter/material.dart';

class MyTextField2 extends StatelessWidget {
  final String hintText;
  final TextEditingController textEditingController;
  final bool obscureText;

  const MyTextField2({
    super.key,
    required this.hintText,
    required this.textEditingController,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      child: TextField(
        style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
        controller: textEditingController,
        obscureText: obscureText,
        decoration: InputDecoration(
          focusColor: Theme.of(context).colorScheme.onBackground,
          fillColor: Theme.of(context).colorScheme.secondary,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide:  BorderSide(color: Theme.of(context).colorScheme.secondary),
          ),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(color: Theme.of(context).colorScheme.onBackground),
        ),
      ),
    );
  }
}
