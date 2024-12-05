import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'network_enums.dart';
import 'network_typedef.dart';

class NetworkHelper {
  const NetworkHelper._();

  static bool _isValidResponse(json) {
    return json != null;
  }

  static Future<R> filterResponse<R>({
    required NetworkCallBack callBack,
    required http.Response? response,
    required NetworkOnFailureCallBackWithMessage onFailureCallBackWithMessage,
    CallBackParameterName parameterName = CallBackParameterName.all,
  }) async {
    if (response == null) {
      return onFailureCallBackWithMessage(
        NetworkResponseErrorType.responseEmpty,
        'No response. Try again.',
      );
    }

    if (response.body.isEmpty || response.statusCode == 204) {
      return callBack('');
    }
    if (response.statusCode == 500) {
      return onFailureCallBackWithMessage(
          NetworkResponseErrorType.serverError, 'Server error. Try later.');
    }
    if (response.statusCode == 502) {
      return onFailureCallBackWithMessage(
          NetworkResponseErrorType.badGateway, 'Server unreachable.');
    }

    if (response.statusCode == 503) {
      return onFailureCallBackWithMessage(
          NetworkResponseErrorType.serviceUnavailable, 'Service Unavailable');
    }

    var json = jsonDecode(response.body);

    switch (response.statusCode) {
      case 200: // OK
      case 201: // Created
      case 202: // Accepted
        return callBack(parameterName.getJson(json));

      case 400: // Bad Request
        return onFailureCallBackWithMessage(
          NetworkResponseErrorType.badRequest,
          json['message'] ?? 'Invalid request.',
        );

      case 401: // Unauthorized
        return onFailureCallBackWithMessage(
          NetworkResponseErrorType.unauthorized,
          json['message'] ?? 'Unauthorized. Login required.',
        );

      case 403: // Forbidden
        return onFailureCallBackWithMessage(
          NetworkResponseErrorType.forbidden,
          json['message'] ?? 'Access denied.',
        );

      case 404: // Not Found
        return onFailureCallBackWithMessage(
          NetworkResponseErrorType.notFound,
          json['message'] ?? 'Resource not found.',
        );

      case 408: // Not Found
        return onFailureCallBackWithMessage(
          NetworkResponseErrorType.timeout,
          json['message'] ?? 'Network timout',
        );

      case 409: // Conflict
        return onFailureCallBackWithMessage(
          NetworkResponseErrorType.conflict,
          json['message'] ?? 'Conflict occurred.',
        );

      case 422: // Unprocessable Entity
        return onFailureCallBackWithMessage(
          NetworkResponseErrorType.unprocessableEntity,
          json['message'] ?? 'Invalid data.',
        );

      case 500: // Internal Server Error
        return onFailureCallBackWithMessage(
          NetworkResponseErrorType.serverError,
          'Server error. Try later.',
        );

      case 502: // Bad Gateway
        return onFailureCallBackWithMessage(
          NetworkResponseErrorType.badGateway,
          'Server unreachable.',
        );

      case 503: // Bad Gateway
        return onFailureCallBackWithMessage(
          NetworkResponseErrorType.badGateway,
          'Service Unavailable',
        );

      default:
        return onFailureCallBackWithMessage(
          NetworkResponseErrorType.didNotSucceed,
          'Something went wrong.',
        );
    }
  }

  static Future<R> filterMultipartResponse<R>({
    required NetworkCallBack callBack,
    required http.StreamedResponse? response,
    required NetworkOnFailureCallBackWithMessage onFailureCallBackWithMessage,
    CallBackParameterName parameterName = CallBackParameterName.all,
  }) async {
    if (response == null) {
      return onFailureCallBackWithMessage(
        NetworkResponseErrorType.responseEmpty,
        'No response. Try again.',
      );
    }

    var responseBody = await http.Response.fromStream(response);

    if (responseBody.body.isEmpty) {
      return onFailureCallBackWithMessage(
        NetworkResponseErrorType.responseEmpty,
        'Response empty.',
      );
    }

    var json = jsonDecode(responseBody.body);

    switch (responseBody.statusCode) {
      case 200: // OK
      case 201: // Created
        return callBack(parameterName.getJson(json));

      case 400: // Bad Request
        return onFailureCallBackWithMessage(
          NetworkResponseErrorType.badRequest,
          json['message'] ?? 'Invalid request.',
        );

      case 401: // Unauthorized
        return onFailureCallBackWithMessage(
          NetworkResponseErrorType.unauthorized,
          json['message'] ?? 'Unauthorized. Login required.',
        );

      case 403: // Forbidden
        return onFailureCallBackWithMessage(
          NetworkResponseErrorType.forbidden,
          json['message'] ?? 'Access denied.',
        );

      case 404: // Not Found
        return onFailureCallBackWithMessage(
          NetworkResponseErrorType.notFound,
          json['message'] ?? 'Resource not found.',
        );

      case 409: // Conflict
        return onFailureCallBackWithMessage(
          NetworkResponseErrorType.conflict,
          json['message'] ?? 'Conflict occurred.',
        );

      case 422: // Unprocessable Entity
        return onFailureCallBackWithMessage(
          NetworkResponseErrorType.unprocessableEntity,
          json['message'] ?? 'Invalid data.',
        );

      case 500: // Internal Server Error
        return onFailureCallBackWithMessage(
          NetworkResponseErrorType.serverError,
          'Server error. Try later.',
        );

      case 502: // Bad Gateway
        return onFailureCallBackWithMessage(
          NetworkResponseErrorType.badGateway,
          'Server unreachable.',
        );

      default:
        return onFailureCallBackWithMessage(
          NetworkResponseErrorType.didNotSucceed,
          'Unexpected error. Try again.',
        );
    }
  }
}
