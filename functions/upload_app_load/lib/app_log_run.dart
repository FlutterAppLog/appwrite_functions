import 'package:dart_appwrite/dart_appwrite.dart';
import 'package:darty_json_safe/darty_json_safe.dart';
import 'package:upload_app_log/commons/appwrite_extends.dart';
import 'package:upload_app_log/commons/appwrite_main.dart';
import 'package:upload_app_log/commons/appwrite_run.dart';

class AppLogRun extends AppwriteRun {
  @override
  String get path => '/appLog';

  @override
  Future<Map<String, dynamic>> run(JSON req, AppwriteMain main) async {
    final realmId = req.getString('realmId');
    final appLoadId = req.getId('appLoadId');
    final database = Databases(main.client);
    await database.createDocument(
      databaseId: main.environment.databaseId,
      collectionId: main.environment.appLogTableId,
      documentId: ID.unique(),
      data: {
        'realmId': realmId,
        'appLoad': appLoadId,
      },
    );
    return {};
  }
}
