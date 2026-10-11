import 'package:dio/dio.dart';
import 'package:flutter_application_hungray/Core/Network/api_execptions.dart';
import 'package:flutter_application_hungray/Core/Network/dio_client.dart';

class ApiService {
  final DioClient _dioClient = DioClient();

  /// CRUD METHODS

  //GET METHOD

  Future<dynamic> get(
    String endPoint, [
    Map<String, dynamic>? queryParams,
  ]) async {
    try {
      final response = await _dioClient.dio.get(
        endPoint,
        queryParameters: queryParams,
      );
      return response.data;
    } on DioException catch (e) {
      return ApiExecptions.handleErorr(
        e,
      ); // You can handle the error as needed  //بعد ما نخلص نغيرها ونحولها return response.data;
    }
  }

  //POST METHOD

  Future<dynamic> post(String endPoint, dynamic body) async {
    try {
      final response = await _dioClient.dio.post(endPoint, data: body);
      return response.data;
    } on DioException catch (e) {
      return ApiExecptions.handleErorr(
        e,
      ); // You can handle the error as needed  //بعد ما نخلص نغيرها ونحولها return response.data;
    }
  }

  //PUT METHOD

  Future<dynamic> put(String endPoint, Map<String, dynamic> body) async {
    try {
      final response = await _dioClient.dio.put(endPoint, data: body);
      return response.data;
    } on DioException catch (e) {
      return ApiExecptions.handleErorr(
        e,
      ); // You can handle the error as needed  //بعد ما نخلص نغيرها ونحولها return response.data;
    }
  }

  //DELETE METHOD

  Future<dynamic> delete(
    String endPoint,
    Map<String, dynamic> body,
    Map<String, dynamic>? queryParams,
  ) async {
    try {
      final response = await _dioClient.dio.delete(
        endPoint,
        data: body,
        queryParameters: queryParams,
      );
      return response.data;
    } on DioException catch (e) {
      return ApiExecptions.handleErorr(
        e,
      ); // You can handle the error as needed  //بعد ما نخلص نغيرها ونحولها return response.data;
    }
  }
}
