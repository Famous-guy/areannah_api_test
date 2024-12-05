import 'dart:convert';

import 'package:arennah_api_test/api/arennah_url.dart';
import 'package:arennah_api_test/network/network.dart';

class LoginProvider {
  Future<dynamic> login({
    required String phone_or_email,
    required String password,
  }) async {
    final request = await NetworkService.sendRequest(
      requestType: RequestType.patch,
      url: ArennahUrl.loginUrl,
      body: jsonEncode(
        {
          'phone_or_email': phone_or_email,
          'password': password,
         
        },
      ),
    );

    return NetworkHelper.filterResponse(
      callBack: (json) {
        print('login json => $json');
        return (json);
      },
      response: request,
      onFailureCallBackWithMessage: (stack, e) {
        print('this is the $e');
        print('this is th $stack');
        throw e.toString();
      },
    );
  }
}
