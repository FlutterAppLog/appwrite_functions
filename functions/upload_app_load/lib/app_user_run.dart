import 'package:darty_json_safe/darty_json_safe.dart';
import 'package:upload_app_log/commons/appwrite_main.dart';
import 'package:upload_app_log/commons/appwrite_run.dart';

class AppUserRun extends AppwriteRun {
  @override
  String get path => 'appUser';

  @override
  Future<Map<String, dynamic>> run(JSON req, AppwriteMain main) async {
    throw UnimplementedError();
  }
}
