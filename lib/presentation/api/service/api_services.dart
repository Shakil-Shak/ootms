



import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ootms/presentation/api/sharePrefarences/local_storage_save.dart';
import 'package:ootms/presentation/api/sharePrefarences/login_tokan.dart';
import 'package:ootms/presentation/api/sharepreference_service.dart';

class ApiService {
  final Dio _dio = Dio();

  // SharedPreferencesService service = SharedPreferencesService();
  List<String>? userDetails;
  static const int timeOut = 30;

  // Generic GET Request
  Future<dynamic> getRequest(String url) async {
    userDetails = await getUserAcessDetails();
    String token = userDetails![0];
    // String token = service.getString(ootmsUserAccessToken)!;
    try {
      final response = await _dio.get(
        url,
        options: Options(headers: {
          "Authorization": "Bearer $token",
        }),
      ).timeout(const Duration(seconds: timeOut));
      return response.data;
    } on DioException catch (e) {
      _handleDioError(e);
    }
  }

  // Generic POST Request
  Future<dynamic> postRequest(String url, Map<String, dynamic> data,
      {Options? token}) async {
    // userDetails = await getUserAcessDetails();
    //  String accesstoken = userDetails![0]?? "";
    try {
      final response = await _dio.post(
        url, data: data,
        options: token,
      ).timeout(const Duration(seconds: timeOut));
      return response.data;
    } on DioException catch (e) {
      _handleDioError(e);
    }
  }
  //=======================================other post request
Future<dynamic> otherPostRequest(String url,data, {Options? token}) async {
  userDetails = await getUserAcessDetails();
  String accesstoken = userDetails![0] ?? "";

  try {
    final response = await _dio.post(
      url,
      data: data,
      options: Options(
        headers: {
          "Authorization": "Bearer $accesstoken",
          'Content-Type': 'application/json',
        },
      ),
    ).timeout(const Duration(seconds: timeOut));
    return response.data;
  } on DioException catch (e) {
    _handleDioError(e);
  }
}

  //==========================patch service
  Future<dynamic> patchRequest(
    String url,
    Map<String, String> data,
  ) async {
    userDetails = await getUserAcessDetails();
    String token = userDetails![0];
    try {
      final response = await _dio.patch(
        url,
        data: data,
        options: Options(headers: {
          "Authorization": "Bearer $token",
        }),
      ).timeout(const Duration(seconds: timeOut));
      return response.data;
    } on DioException catch (e) {
      _handleDioError(e);
    }
  }

  // Generic PUT Request
  Future<dynamic> putRequest(String url, Map<String, dynamic> data) async {
    try {
      final response = await _dio.put(url, data: data).timeout(const Duration(seconds: timeOut));
      return response.data;
    } on DioException catch (e) {
      _handleDioError(e);
    }
  }

//==========================put service for multipart data
  Future<dynamic> putMultipartRequest(
    String url,
    Map<String, dynamic> data,
    Map<String, String> fileFields,
  ) async {
    userDetails = await getUserAcessDetails();
    String token = userDetails![0];

    try {
      FormData formData = FormData();

      // Add fields to FormData
      data.forEach((key, value) {
        formData.fields.add(MapEntry(key, value.toString()));
      });

      // Add files to FormData
      for (var entry in fileFields.entries) {
        formData.files.add(MapEntry(
          entry.key,
          await MultipartFile.fromFile(entry.value),
        ));
      }

      // Perform the PUT request
      final response = await _dio.put(
        url,
        data: formData,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            // "Content-Type": "multipart/form-data",
          },
        ),
      ).timeout(const Duration(seconds: timeOut));

      return response.data;
    } on DioException catch (e) {
      print("dio exception ============================$e");
      _handleDioError(e);
    }
  }

  // Generic DELETE Request
  Future<dynamic> deleteRequest(String url) async {
    try {
      final response = await _dio.delete(url).timeout(const Duration(seconds: timeOut));
      return response.data;
    } on DioException catch (e) {
      log("Error: $e");
      _handleDioError(e);
    }
  }

  void _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        throw ('Connection Timeout: Unable to connect to the server. Please check your internet connection.');

      case DioExceptionType.sendTimeout:
        throw ('Send Timeout: The request took too long to send. Please try again.');

      case DioExceptionType.receiveTimeout:
        throw ('Receive Timeout: The server took too long to respond. Please try again later.');

      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        final responseMessage =
            e.response?.data?.toString() ?? 'Unknown error occurred.';

        // Handle specific status codes
        if (statusCode != null) {
          switch (statusCode) {
            
            case 208:
              throw ('already axist');
            case 400:
              throw ('Bad Request: The server could not understand the request.');
            case 401:
              throw ('Unauthorized: Invalid credentials or token. Please login again.');
            case 403:
              throw ('Forbidden: You do not have permission to access this resource.');
            case 404:
              throw ('Not Found: The requested resource could not be found.');
            case 500:
              throw ('Internal Server Error: Something went wrong on the server.');
            case 503:
              throw ('Service Unavailable: The server is currently unavailable. Please try again later.');
            default:
              throw ('Error [$statusCode]: $responseMessage');
          }
        }
        break;

      case DioExceptionType.cancel:
        throw ('Request Cancelled: The request was cancelled before completion.');
      default:
        throw ('Unknown Error: Something went wrong. Please try again.');
    }
  }
}
