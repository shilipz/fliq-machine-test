import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:japx/japx.dart';

class ApiService {
  static final Dio _dio = Dio();

  static Future<Response> postRawJson(
      String url, Map<String, dynamic> rawBody) async {
    try {
      final response = await _dio.post(
        url,
        data: jsonEncode(rawBody),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            // Add auth token here if needed
          },
        ),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  static Future<Response> post(
    String url, {
    required String type,
    required Map<String, dynamic> attributes,
  }) async {
    final body = {
      'data': {
        'type': type,
        'attributes': attributes,
      },
    };
    return await _dio.post(url, data: body);
  }

  static Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParams,
  }) async {
    return await _dio.get(url, queryParameters: queryParams);
  }

  static Future<Response> put(
    String url, {
    required String type,
    required Map<String, dynamic> attributes,
  }) async {
    final body = {
      'data': {
        'type': type,
        'attributes': attributes,
      },
    };
    return await _dio.put(url, data: body);
  }

  static Future<Response> delete(String url) async {
    return await _dio.delete(url);
  }

  static Future<Map<String, dynamic>> postWithJapx(
    String url, {
    required String type,
    required Map<String, dynamic> attributes,
  }) async {
    final response = await post(url, type: type, attributes: attributes);
    return Japx.decode(response.data);
  }

  static Future<Map<String, dynamic>> getWithJapx(
    String url, {
    Map<String, dynamic>? queryParams,
  }) async {
    final response = await get(url, queryParams: queryParams);
    return Japx.decode(response.data);
  }
}
