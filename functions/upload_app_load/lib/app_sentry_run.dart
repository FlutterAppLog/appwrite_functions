import 'package:dart_appwrite/dart_appwrite.dart';
import 'package:darty_json_safe/darty_json_safe.dart';
import 'package:upload_app_log/commons/appwrite_extends.dart';
import 'package:upload_app_log/commons/appwrite_main.dart';
import 'package:upload_app_log/commons/appwrite_run.dart';

class AppSentryRun extends AppwriteRun {
  @override
  String get path => '/appSentry';

  @override
  Future<Map<String, dynamic>> run(JSON req, AppwriteMain main) async {
    final title = req.getString('title');
    final id = req.getId('id');
    final sentryId = req.getString('sentryId');
    final time = req.getDateTime('time');
    final appLoadId = req.getId('appLoadId');
    final database = Databases(main.client);
    await database.createDocument(
      databaseId: main.environment.databaseId,
      collectionId: main.environment.appSentryTableId,
      documentId: id,
      data: {
        'title': title,
        'sentryId': sentryId,
        'time': time.toUtc().toIso8601String(),
        'appLoad': appLoadId
      },
    );
    return {};
  }
}
