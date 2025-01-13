import 'package:dart_appwrite/dart_appwrite.dart';
import 'package:darty_json_safe/darty_json_safe.dart';
import 'package:upload_app_log/commons/appwrite_extends.dart';
import 'package:upload_app_log/commons/appwrite_main.dart';
import 'package:upload_app_log/commons/appwrite_run.dart';

class AppUserRun extends AppwriteRun {
  @override
  String get path => '/appUser';

  @override
  Future<Map<String, dynamic>> run(JSON req, AppwriteMain main) async {
    final time = req.getDateTime('time');
    final userId = req.getString('userId');
    final appLoadId = req.getString('appLoadId');
    final id = req.getId('id');
    final database = Databases(main.client);
    await database.createDocument(
      databaseId: main.environment.databaseId,
      collectionId: main.environment.appUserTableId,
      documentId: id,
      data: {
        'time': time.toUtc().toIso8601String(),
        'userId': userId,
        'appLoad': appLoadId,
      },
    );
    return {};
  }
}
