class AppwriteData {
  final dynamic data;
  final String message;
  final int code;

  AppwriteData(this.data, this.message, this.code);

  factory AppwriteData.success(dynamic data) {
    return AppwriteData(data, 'success', 200);
  }

  factory AppwriteData.error(String message, int code) {
    return AppwriteData(null, message, code);
  }

  Map<String, dynamic> toMap() {
    return {
      'data': data,
      'message': message,
      'code': code,
    };
  }
}
