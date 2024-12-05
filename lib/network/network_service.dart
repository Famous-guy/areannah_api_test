import 'dart:io';

import 'package:http/http.dart' as http;

enum RequestType { get, put, post, patch, delete }

class NetworkService {
  const NetworkService._();

  static Map<String, String> _getHeaders(var token, var contentType) =>
      {'Content-Type': contentType, 'Authorization': 'Bearer $token'};

  static Future<http.Response>? _createRequest({
    required RequestType requestType,
    required Uri uri,
    Map<String, String>? headers,
    String? body,
  }) {
    switch (requestType) {
      case RequestType.get:
        return http.get(uri, headers: headers).timeout(
          const Duration(seconds: 30),
          onTimeout: () {
            return http.Response(
              'Network error, timeout',
              408,
            )..contentLength;
          },
        );
      case RequestType.post:
        return http.post(uri, headers: headers, body: body).timeout(
          const Duration(seconds: 120),
          onTimeout: () {
            return http.Response('Network error, timeout', 408);
          },
        );
      case RequestType.put:
        return http.put(uri, headers: headers, body: body).timeout(
          const Duration(seconds: 120),
          onTimeout: () {
            return http.Response('Network error, timeout', 408);
          },
        );
      case RequestType.patch:
        return http.patch(uri, headers: headers, body: body).timeout(
          const Duration(seconds: 120),
          onTimeout: () {
            return http.Response('Network error, timeout', 408);
          },
        );
      case RequestType.delete:
        return http.delete(uri, headers: headers, body: body).timeout(
          const Duration(seconds: 120),
          onTimeout: () {
            return http.Response('Network error, timeout', 408);
          },
        );
    }
  }

  static Future<http.Response?>? sendRequest({
    required RequestType requestType,
    required String url,
    String token = '',
    String contentType = 'application/json',
    String? body,
    Map<String, String>? head,
  }) async {
    try {
      final header = head ?? _getHeaders(token, contentType);

      final response = await _createRequest(
          requestType: requestType,
          uri: Uri.parse(url),
          headers: header,
          body: body);

      return response;
    } on SocketException catch (_) {
      throw "No network";
    } catch (e) {
      throw e.toString();
    }
  }

  static Future<http.StreamedResponse?> sendMultipartRequest({
    required RequestType requestType,
    required String url,
    String token = '',
    Map<String, String>?
        fields, // Optional text fields to send with the request
    Map<String, String>? head,
    List<File>? files, // List of files to upload
    String fileFieldName =
        'files', // Field name for file upload, e.g., 'file' or 'photo'
  }) async {
    try {
      // Create the multipart request with the specified request type (POST, PUT, etc.)
      var uri = Uri.parse(url);
      var request = http.MultipartRequest(
        requestType == RequestType.post ? 'POST' : 'PUT',
        uri,
      );

      // Use _getHeaders for headers, if 'head' is null
      final header = head ??
          _getHeaders(token,
              'multipart/form-data'); // Set 'multipart/form-data' as the content type
      request.headers.addAll(header);

      // Add text fields to the request if any
      if (fields != null) {
        fields.forEach((key, value) {
          request.fields[key] = value;
        });
      }

      // Add each file from the list to the request
      if (files != null) {
        for (var file in files) {
          request.files.add(
            await http.MultipartFile.fromPath(fileFieldName, file.path),
          );
        }
      }

      // Send the request and await the streamed response
      final streamedResponse = await request.send();
      return streamedResponse; // Return the streamed response for further processing
    } on SocketException catch (_) {
      throw "No internet connection.";
    } catch (e) {
      throw e.toString();
    }
  }
}
