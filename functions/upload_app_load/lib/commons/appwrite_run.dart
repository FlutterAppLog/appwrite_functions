import 'package:darty_json_safe/darty_json_safe.dart';
import 'package:upload_app_log/commons/appwrite_main.dart';

abstract class AppwriteRun {
  Future<Map<String, dynamic>> run(JSON req, AppwriteMain main);

  String get path;
}
