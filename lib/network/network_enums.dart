enum NetworkResponseErrorType {
  socket, // Network error (e.g., no internet connection)
  exception, // General exception (e.g., unexpected error)
  badRequest, // 400: Bad Request
  timeout, // Request timed out
  responseEmpty, // Empty or null response
  didNotSucceed, // General failure case
  conflict, // 409: Conflict
  unauthorized, // 401: Unauthorized
  forbidden, // 403: Forbidden
  notFound, // 404: Not Found
  unprocessableEntity, // 422: Unprocessable Entity
  serverError, // 500: Internal Server Error
  badGateway, // 502: Bad Gateway
  serviceUnavailable, // 503: Service Unavailable
  gatewayTimeout, // 504: Gateway Timeout
  networkError // General network error (e.g., issues with connectivity)
}

enum CallBackParameterName { all, token }

extension CallbackParameterNameExtention on CallBackParameterName {
  dynamic getJson(json) {
    if (json == null) return null;
    switch (this) {
      case CallBackParameterName.all:
        return json;
      case CallBackParameterName.token:
        return json['token'];
    }
  }
}
