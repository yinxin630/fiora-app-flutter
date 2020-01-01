class SocketException implements Exception {
  final String message;

  SocketException(this.message);

  @override
  String toString() {
    return message;
    // return super.toString(); // Instance of HttpException
  }
}
