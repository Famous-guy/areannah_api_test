import 'package:flutter/material.dart';

import 'provider/login_provider.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final login = context.watch<LoginChangeNotifierProvider>();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'login test',
              ),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Email',
                ),
                controller: email,
              ),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Passord',
                ),
                controller: password,
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<LoginChangeNotifierProvider>().loginFunction(
                        phone_or_email: email.text,
                        context: context,
                        password: password.text,
                      );
                },
                child: login.isLoading
                    ? CircularProgressIndicator()
                    : Text(
                        'Login',
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
