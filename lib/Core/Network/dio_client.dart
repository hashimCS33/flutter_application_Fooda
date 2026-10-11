import 'package:dio/dio.dart';
import 'package:flutter_application_hungray/Core/utils/pref_helper.dart';

class DioClient {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'http://10.0.2.2:8000/api', // Replace with your API base URL
      headers: {'Content-Type': 'application/json'},
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
    ),
  );

  DioClient() {
    // _dio.interceptors.add(LogInterceptor(
    //  requestBody: true,
    //  responseBody: true,

    // ));

    // You can add interceptors or other configurations here if needed
    //فاىد هذه توكن ه و ان اعرف هي id شخص الي يشتري او  من مشتريات انه هو شخص نفسه اشتري هاي دالة تتحق
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token =
              await prefHelper.getToken(); // Replace with your actual token
          if (token != null && token.isNotEmpty && token != 'guest') {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options); // Continue with the request
        },
      ),
    );
  }

  Dio get dio => _dio;
}
