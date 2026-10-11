import 'package:flutter_application_hungray/Features/auth/data/user_model.dart';

enum ProfileStatus { loading, loaded, updating, loggedOut }

class ProfileState {
  final ProfileStatus status;
  final UserModel? user;
  final bool isGuest;
  final String? selectedImage;

  /// One-off message (error or info) to be shown by the UI.
  final String? message;

  const ProfileState({
    this.status = ProfileStatus.loading,
    this.user,
    this.isGuest = false,
    this.selectedImage,
    this.message,
  });

  ProfileState copyWith({
    ProfileStatus? status,
    UserModel? user,
    bool? isGuest,
    String? selectedImage,
    bool clearSelectedImage = false,
    String? message,
  }) {
    return ProfileState(
      status: status ?? this.status,
      user: user ?? this.user,
      isGuest: isGuest ?? this.isGuest,
      selectedImage:
          clearSelectedImage ? null : (selectedImage ?? this.selectedImage),
      message: message,
    );
  }
}
