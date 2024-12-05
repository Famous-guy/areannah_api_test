// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:arennah_api_test/data/repo/login_repo.dart';
import 'package:arennah_api_test/domain/entities/login_entity.dart';

class LoginChangeNotifierProvider extends ChangeNotifier {
  LoginEntity? _login;
  LoginRepo loginRepo;

  String? _error;

  bool _isLoading = false;
  LoginChangeNotifierProvider({
    required this.loginRepo,
  });

  LoginEntity? get login => _login;
  String? get error => _error;
  bool get isLoading => _isLoading;
  Future<void> loginFunction({
    required String phone_or_email,
    required String password,
    required BuildContext context,
  }) async {
    print(_isLoading);

    _isLoading = true;
    _error = null;
    notifyListeners();

    print(_isLoading);
    try {
      print(_isLoading);
      final loginData = await loginRepo.login(
        phone_or_email: phone_or_email,
        password: password,
      );

      _login = loginData;

      _error = null;
      print(_isLoading);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            _login!.message,
          ),
        ),
      );
      print(_isLoading);
      notifyListeners();
      print(_isLoading);
    } catch (e) {
      print(_isLoading);
      _error = e.toString();
      _login = null;
      print(_isLoading);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            e.toString(),
          ),
        ),
      );
      print(_isLoading);
      notifyListeners();
      print(_isLoading);
    } finally {
      print(_isLoading);
      // Ensure the state change happens after the widget build phase
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _isLoading = false;
        notifyListeners();
        print(_isLoading);
      });
      print(_isLoading);
    }
    print(_isLoading);
  }
}
