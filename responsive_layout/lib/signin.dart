import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    final double currentWidth = MediaQuery.of(context).size.width;
    return Center(
        child: Column(
      children: [
        const Text(
          'Sign in to continue',
          style: TextStyle(fontSize: 20, color: Colors.red),
        ),
        Text(currentWidth.toString(), style: const TextStyle(fontSize: 15)),
        const SizedBox(
          height: 20,
        ),
        TextField(
          decoration: InputDecoration(
              prefixIcon: const Icon(Icons.person),
              labelText: 'Email',
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 3, color: Colors.blue),
                borderRadius: BorderRadius.circular(15),
              )),
        ),
        const SizedBox(
          height: 20,
        ),
        TextField(
          obscureText: true,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.lock),
            labelText: 'Password',
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 3, color: Colors.blue),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 3, color: Colors.red),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
      ],
    ));
  }
}
