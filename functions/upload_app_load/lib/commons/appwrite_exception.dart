class AppwriteFunctionExpection implements Exception {
  final int code;
  final String message;
  const AppwriteFunctionExpection({required this.code, required this.message});

  factory AppwriteFunctionExpection.keyNotFound(String key) =>
      AppwriteFunctionExpection(code: 10000, message: 'key not found: $key');

  factory AppwriteFunctionExpection.idAleadyExists(String id) =>
      AppwriteFunctionExpection(code: 10001, message: 'id already exists: $id');
}
