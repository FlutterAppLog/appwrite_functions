import 'package:dart_appwrite/dart_appwrite.dart';
import 'package:darty_json_safe/darty_json_safe.dart';
import 'package:upload_app_log/commons/appwrite_exception.dart';
import 'package:upload_app_log/commons/appwrite_extends.dart';
import 'package:upload_app_log/commons/appwrite_functions.dart';
import 'package:upload_app_log/commons/appwrite_main.dart';
import 'package:upload_app_log/commons/appwrite_run.dart';

class AppLoadRun extends AppwriteRun {
  @override
  Future<Map<String, dynamic>> run(JSON req, AppwriteMain main) async {
    final time = req.getDateTime('time');
    final deviceId = req.getString('deviceId');
    final environment = req.getString('environment');
    if (!['sit', 'release'].contains(environment)) {
      throw AppwriteFunctionExpection(code: -1, message: 'invalid environment');
    }
    final isStoreVersion = req.getBool('isStoreVersion');
    final id = req.getString('id');
    if (!verifyId(id)) {
      throw AppwriteFunctionExpection(code: -1, message: 'invalid id');
    }
    final database = Databases(main.client);
    await database.createDocument(
      databaseId: main.environment.databaseId,
      collectionId: main.environment.appLoadTableId,
      documentId: id,
      data: {
        'time': time.toUtc().toIso8601String(),
        'deviceId': deviceId,
        'environment': environment,
        'isStoreVersion': isStoreVersion
      },
    );
    return {};
  }

  @override
  String get path => '/appLoad';
}
