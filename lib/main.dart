import 'package:arennah_api_test/data/provider/login_provider.dart';
import 'package:arennah_api_test/data/repo/login_repo.dart';
import 'package:arennah_api_test/login.dart';
import 'package:arennah_api_test/provider/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  runApp(const MyApp());
  // await LoginRepo(
  //   loginProvider: LoginProvider(),
  // ).login(
  //   phone_or_email: 'johndharey@gmail.com',
  //   password: 'Dare@007',
  // );
}

final loginRepo = LoginRepo(
  loginProvider: LoginProvider(),
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LoginChangeNotifierProvider(
            loginRepo: loginRepo,
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Login(),
      ),
    );
  }
}
