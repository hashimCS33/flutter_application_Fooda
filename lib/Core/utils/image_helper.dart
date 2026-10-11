class ImageHelper {
  static String getImageUrl(String? imagePath) {
    if (imagePath == null || imagePath.isEmpty) {
      return 'http://10.0.2.2:8000/storage/defaults/default-avatar.png'; // Default image URL
    }
    return imagePath.replaceFirst(
      '127.0.0.1',
      '10.0.2.2',
    ); // Replace with your actual base URL
  }
}
