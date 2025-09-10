import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class ApiClent extends GetConnect implements GetxService {
  final int defaultRetries;
  final Duration defaultTimeout;

  ApiClent({
    this.defaultRetries = 3,
    this.defaultTimeout = const Duration(seconds: 40),
  });

  /// Common retry handler
  Future<Response<T>> _withRetry<T>(
    Future<Response<T>> Function() requestFn, {
    int? retries,
    Duration? timeout,
  }) async {
    final maxRetries = retries ?? defaultRetries;
    final maxTimeout = timeout ?? defaultTimeout;

    int attempt = 0;
    Response<T>? lastResponse;

    while (attempt < maxRetries) {
      debugPrint('Attempt ${attempt + 1} of $maxRetries');
      try {
        final response = await requestFn().timeout(maxTimeout);
        if (response.isOk) {
          return response;
        } else {
          lastResponse = response;
        }
      } catch (e) {
        if (attempt == maxRetries - 1) {
          return Response<T>(
            statusCode: 500,
            statusText: "Failed after $maxRetries attempts: $e",
          );
        }
      }
      attempt++;
      await Future.delayed(Duration(milliseconds: 500 * attempt)); // backoff
    }

    return lastResponse ??
        Response<T>(statusCode: 500, statusText: "Unknown error");
  }

  Future<Response<T>> getData<T>({
    required String uri,
    Map<String, String>? headers,
    int? retries,
    Duration? timeout,
  }) {
    return _withRetry(
      () => get<T>(uri, headers: headers),
      retries: retries,
      timeout: timeout,
    );
  }

  Future<Response<T>> postData<T>({
    required String uri,
    required dynamic body,
    Map<String, String>? headers,
    int? retries,
    Duration? timeout,
  }) {
    return _withRetry(
      () => post<T>(uri, body, headers: headers),
      retries: retries,
      timeout: timeout,
    );
  }

  Future<Response<T>> updateData<T>({
    required String uri,
    required dynamic body,
    Map<String, String>? headers,
    int? retries,
    Duration? timeout,
  }) {
    return _withRetry(
      () => patch<T>(uri, body, headers: headers),
      retries: retries,
      timeout: timeout,
    );
  }

  Future<Response<T>> putData<T>({
    required String uri,
    required dynamic body,
    Map<String, String>? headers,
    int? retries,
    Duration? timeout,
  }) {
    return _withRetry(
      () => put<T>(uri, body, headers: headers),
      retries: retries,
      timeout: timeout,
    );
  }

  Future<Response<T>> deleteData<T>({
    required String uri,
    Map<String, String>? headers,
    int? retries,
    Duration? timeout,
  }) {
    return _withRetry(
      () => delete<T>(uri, headers: headers),
      retries: retries,
      timeout: timeout,
    );
  }
}
