import 'package:dio/dio.dart';
import 'package:flutter_application_hungray/Core/Network/api_erorr.dart';

class ApiExecptions {
  static ApiErorr handleErorr(DioException error) {
    final statusCode = error.response?.statusCode;
    final data = error.response?.data;

    if (data is Map<String, dynamic> && data['message'] != null) {
      return ApiErorr(message: data['message'], statusCode: statusCode);
    } // Handle other error formats if needed ياخذ رسالة من باك اند ويعرضها على الشاشة

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return ApiErorr(message: 'Connection timeout', statusCode: 408);
      case DioExceptionType.sendTimeout:
        return ApiErorr(message: 'Send timeout', statusCode: 407);
      case DioExceptionType.receiveTimeout:
        return ApiErorr(message: 'Receive timeout', statusCode: 408);
      case DioExceptionType.cancel:
        return ApiErorr(message: 'Request cancelled', statusCode: 499);
      case DioExceptionType.connectionError: // ✅
        return ApiErorr(
          message: 'Connection error: ${error.message}',
          statusCode: 503,
        );
      case DioExceptionType.badCertificate: // ✅
        return ApiErorr(message: 'Bad certificate', statusCode: 495);
      case DioExceptionType.unknown: // ✅
        return ApiErorr(
          message: 'Unknown error: ${error.message}',
          statusCode: 500,
        );
      default:
        return ApiErorr(
          message: 'Unexpected error occurred please try again ',
          statusCode: 500,
        );
    }
  }
}
