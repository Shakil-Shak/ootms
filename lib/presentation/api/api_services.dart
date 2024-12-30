import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ootms/presentation/api/login_tokan.dart';
import 'package:ootms/presentation/api/sharepreference_service.dart';

class ApiService {
  final Dio _dio = Dio();

  SharedPreferencesService service = SharedPreferencesService();

  // Generic GET Request
  Future<dynamic> getRequest(String url) async {
   ;
      String token = service.getString(ootmsAccessToken)!;
    try {
      final response = await _dio.get(url,options: Options(headers: {
              "Authorization": "Bearer $token",
            }),);
      return response.data;
    } on DioException catch (e) {
      _handleDioError(e);
    }
  }

  // Generic POST Request
  Future<dynamic> postRequest(String url, Map<String, dynamic> data) async {
    try {
      final response = await _dio.post(url, data: data);
      return response.data;
    } on DioException catch (e) {
      _handleDioError(e);
    }
  }

  // Generic PUT Request
  Future<dynamic> putRequest(String url, Map<String, dynamic> data) async {
    try {
      final response = await _dio.put(url, data: data);
      return response.data;
    } on DioException catch (e) {
      _handleDioError(e);
    }
  }

  // Generic DELETE Request
  Future<dynamic> deleteRequest(String url) async {
    try {
      final response = await _dio.delete(url);
      return response.data;
    } on DioException catch (e) {
      _handleDioError(e);
    }
  }

  void _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        throw Exception(
            'Connection Timeout: Unable to connect to the server. Please check your internet connection.');

      case DioExceptionType.sendTimeout:
        throw Exception(
            'Send Timeout: The request took too long to send. Please try again.');

      case DioExceptionType.receiveTimeout:
        throw Exception(
            'Receive Timeout: The server took too long to respond. Please try again later.');

      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        final responseMessage =
            e.response?.data?.toString() ?? 'Unknown error occurred.';

        // Handle specific status codes
        if (statusCode != null) {
          switch (statusCode) {
            case 400:
              throw Exception(
                  'Bad Request: The server could not understand the request.');
            case 401:
              throw Exception(
                  'Unauthorized: Invalid credentials or token. Please login again.');
            case 403:
              throw Exception(
                  'Forbidden: You do not have permission to access this resource.');
            case 404:
              throw Exception(
                  'Not Found: The requested resource could not be found.');
            case 500:
              throw Exception(
                  'Internal Server Error: Something went wrong on the server.');
            case 503:
              throw Exception(
                  'Service Unavailable: The server is currently unavailable. Please try again later.');
            default:
              throw Exception('Error [$statusCode]: $responseMessage');
          }
        }
        break;

      case DioExceptionType.cancel:
        throw Exception(
            'Request Cancelled: The request was cancelled before completion.');
      default:
        throw Exception(
            'Unknown Error: Something went wrong. Please try again.');
    }
  }
}
