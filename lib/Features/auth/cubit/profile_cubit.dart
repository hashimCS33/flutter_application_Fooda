import 'package:flutter_application_hungray/Core/Network/api_erorr.dart';
import 'package:flutter_application_hungray/Features/auth/cubit/profile_states.dart';
import 'package:flutter_application_hungray/Features/auth/data/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(const ProfileState());

  final AuthRepo authRepo = AuthRepo();

  /// Restores the session and loads the profile (used by the profile page).
  Future<void> load() async {
    final user = await authRepo.autoLogin();
    if (isClosed) return;
    emit(
      state.copyWith(
        status: ProfileStatus.loaded,
        user: user,
        isGuest: authRepo.isGuest,
      ),
    );
  }

  /// Fetches the latest profile data (guests get no user).
  Future<void> refresh({bool silent = false}) async {
    try {
      final user = await authRepo.getProfileData();
      if (isClosed) return;
      emit(state.copyWith(status: ProfileStatus.loaded, user: user));
    } catch (e) {
      if (isClosed || silent) return;
      emit(
        state.copyWith(
          status: ProfileStatus.loaded,
          message: _messageOf(e, 'Unexpected Erorr form server'),
        ),
      );
    }
  }

  Future<void> updateProfile({
    required String name,
    required String email,
    required String address,
    required String visa,
  }) async {
    emit(state.copyWith(status: ProfileStatus.updating));
    try {
      final user = await authRepo.updatePofileData(
        name: name,
        email: email,
        address: address,
        imagePath: state.selectedImage,
        visa: visa,
      );
      if (isClosed) return;
      emit(
        state.copyWith(
          status: ProfileStatus.loaded,
          user: user,
          message: 'profile update successfully',
        ),
      );
      await refresh(silent: true);
    } catch (e) {
      if (isClosed) return;
      emit(
        state.copyWith(
          status: ProfileStatus.loaded,
          message: _messageOf(e, 'Failed to update profile'),
        ),
      );
    }
  }

  Future<void> pickImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (isClosed || pickedImage == null) return;
    emit(
      state.copyWith(
        selectedImage: pickedImage.path,
        status: ProfileStatus.loaded,
      ),
    );
  }

  Future<void> removeImage({
    required String name,
    required String email,
    required String address,
    required String visa,
  }) async {
    if (state.selectedImage != null) {
      emit(state.copyWith(clearSelectedImage: true));
      return;
    }

    final imageUrl = state.user?.imageUrl;
    if (imageUrl == null || imageUrl.isEmpty) return;

    emit(state.copyWith(status: ProfileStatus.updating));
    try {
      final user = await authRepo.updatePofileData(
        name: name,
        email: email,
        address: address,
        visa: visa,
        removeImage: true,
      );
      if (isClosed) return;
      emit(state.copyWith(status: ProfileStatus.loaded, user: user));
    } catch (e) {
      if (isClosed) return;
      emit(
        state.copyWith(
          status: ProfileStatus.loaded,
          message: _messageOf(e, 'Failed to remove image'),
        ),
      );
    }
  }

  Future<void> logout() async {
    await authRepo.logout();
    if (isClosed) return;
    emit(state.copyWith(status: ProfileStatus.loggedOut, isGuest: true));
  }

  String _messageOf(Object e, String fallback) =>
      e is ApiErorr ? e.message : fallback;
}
