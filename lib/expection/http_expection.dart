class HttpExpection implements Exception {
  final message;
  HttpExpection(this.message);

  @override
  String toString() {
    return message;
  }
}
