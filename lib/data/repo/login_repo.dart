import 'package:arennah_api_test/domain/models/login_models.dart';

import '../../domain/entities/login_entity.dart';
import '../provider/login_provider.dart';

class LoginRepo {
  final LoginProvider loginProvider;

  // LoginRepo({required this.loginProvider});

  LoginRepo({required this.loginProvider});

  Future<LoginEntity> login(
      {required String phone_or_email, required String password}) async {
    try {
      final response = await loginProvider.login(
        phone_or_email: phone_or_email,
        password: password,
      );

      // print(
      //   'the response is $response',
      // );
      final model = LoginModels.fromMap(response);
      print('email is ${model.email}');
      print('this is $model');
      return model;
    } catch (e, s) {
      print('the error is $e');
      print('the place that caused the error is $s');
      throw e.toString();
    }
  }
}
