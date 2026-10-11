import 'package:dio/dio.dart';
import 'package:flutter_application_hungray/Core/Network/api_erorr.dart';
import 'package:flutter_application_hungray/Core/Network/api_execptions.dart';
import 'package:flutter_application_hungray/Core/Network/api_service.dart';
import 'package:flutter_application_hungray/Core/utils/pref_helper.dart';
import 'package:flutter_application_hungray/Features/auth/data/user_model.dart';

class AuthRepo {
  ApiService apiService = ApiService();
  bool isGuest = false;
  UserModel? currentUser;

  // Login method

  Future<UserModel?> login(String email, String password) async {
    try {
      final response = await apiService.post('/login', {
        "email": email,
        "password": password,
      });

      if (response is ApiErorr) {
        throw response;
      }

      if (response is Map<String, dynamic>) {
        final msg = response['message'];
        final status = response['status'];
        final data = response['data'];
        if (status != true || data == null) {
          throw ApiErorr(message: msg);
        }

        final user = UserModel.fromJson(response['data']);
        if (user.token != null) {
          await prefHelper.saveToken(user.token!);
        }

        isGuest = false;
        currentUser = user;
        return user;
      } else {
        throw ApiErorr(message: "Unexpected Erorr form server");
      }
    } on DioException catch (e) {
      throw ApiExecptions.handleErorr(e);
    } catch (e) {
      throw ApiErorr(message: e.toString());
    }
  }

  // Signup method

  Future<UserModel?> signup(String name, String email, String password) async {
    try {
      final response = await apiService.post('/register', {
        "name": name,
        "email": email,
        "password": password,
      });

      if (response is ApiErorr) {
        throw response;
      }

      if (response is Map<String, dynamic>) {
        final msg = response['message'];
        final status = response['status'];
        final data = response['data'];

        if (status != true || data == null) {
          throw ApiErorr(message: msg);
        }

        final user = UserModel.fromJson(response['data']);
        if (user.token != null) {
          await prefHelper.saveToken(user.token!);
        }
        return user;
      } else {
        throw ApiErorr(message: "Unexpected Erorr form server");
      }
    } on DioException catch (e) {
      throw ApiExecptions.handleErorr(e);
    } catch (e) {
      throw ApiErorr(message: e.toString());
    }
  }

  //Get profile data method

  Future<UserModel?> getProfileData() async {
    try {
      final token = await prefHelper.getToken();
      if (token == null || token == 'guest') {
        return null;
      }

      final response = await apiService.get('/profile');

      final user = UserModel.fromJson(response['data']);
      currentUser = user;
      return user;
    } on DioException catch (e) {
      throw ApiExecptions.handleErorr(e);
    } catch (e) {
      throw ApiErorr(message: e.toString());
    }
  }

  //update profile data method

  Future<UserModel?> updatePofileData({
    required String name,
    required String email,
    required String address,
    String? visa,
    String? imagePath,
    bool removeImage = false,
  }) async {
    try {
      final fromdata = FormData.fromMap({
        "name": name,
        "email": email,
        "address": address,
        if (visa != null && visa.isNotEmpty) 'visa': visa,
        if (removeImage) 'remove_image': '1',

        if (imagePath != null && imagePath.isNotEmpty)
          "image": await MultipartFile.fromFile(
            imagePath,
            filename: 'profile.jpg',
          ),
      });

      final response = await apiService.post('/update-profile', fromdata);

      if (response is ApiErorr) {
        throw response;
      }

      if (response is Map<String, dynamic>) {
        final msg = response['message'];
        final status = response['status'];
        final data = response['data'];

        if (status != true || data == null) {
          throw ApiErorr(message: msg);
        }

        final upadtedUser = UserModel.fromJson(data);
        currentUser = upadtedUser;
        return upadtedUser;
      }
    } on DioException catch (e) {
      throw ApiExecptions.handleErorr(e);
    } catch (e) {
      throw ApiErorr(message: e.toString());
    }
    return null;
  }

  //logout method

  Future<void> logout() async {
    try {
      await apiService.post('/logout', {}).timeout(const Duration(seconds: 3));
    } catch (_) {
      // Ignore server/network errors here: still clear the local session below.
    } finally {
      await prefHelper.clearToken();
      currentUser = null;
      isGuest = true;
    }
  }

  //auto login

  Future<UserModel?> autoLogin() async {
    final token = await prefHelper.getToken();

    if (token == null || token == 'guest') {
      isGuest = true;
      currentUser = null;
      return null;
    }

    isGuest = false;

    try {
      final user = await getProfileData();
      currentUser = user;
      return user;
    } catch (e) {
      await prefHelper.clearToken();
      isGuest = true;
      currentUser = null;
      return null;
    }
  }

  //continue as guest

  Future<void> continueASGeuest() async {
    isGuest = true;
    currentUser = null;
    await prefHelper.saveToken('guest');
  }

  UserModel? get _currentUser => currentUser;

  bool get isLoading => !isGuest && currentUser != null;
}
