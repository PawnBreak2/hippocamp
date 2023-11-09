class ErrorCallModel {
  final int statusCode;
  final String? type;
  final String? message;

  const ErrorCallModel({
    required this.statusCode,
    required this.type,
    required this.message,
  });
}
