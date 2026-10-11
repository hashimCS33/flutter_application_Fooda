class ApiErorr {
  final String message;
  final int? statusCode;

  ApiErorr({required this.message, this.statusCode});

  @override
  String toString() {
    return 'Erorr is : $message';
  }
}
