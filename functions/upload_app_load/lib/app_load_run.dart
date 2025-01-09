import 'package:dart_appwrite/dart_appwrite.dart';
import 'package:darty_json_safe/darty_json_safe.dart';
import 'package:starter_template/commons/appwrite_exception.dart';
import 'package:starter_template/commons/appwrite_extends.dart';
import 'package:starter_template/commons/appwrite_functions.dart';
import 'package:starter_template/commons/appwrite_run.dart';

class AppLoadRun extends AppwriteRun {
  AppLoadRun({required super.context});

  @override
  Future<Map<String, dynamic>> run(JSON req) async {
    await verifyRequest(context);
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
    final client = appwriteClient(context);
    final database = Databases(client);
    await database.createDocument(
      databaseId: 'app_log_db',
      collectionId: '676bcaf7000894834686',
      documentId: id,
      data: {
        'time': time.toUtc().toIso8601String(),
        'device_id': deviceId,
        'environment': environment,
        'is_store_version': isStoreVersion
      },
    );
    return {};
  }

  /// 验证ID
  bool verifyId(String id) {
    final contents = id.split('-');
    context.log('contents: $contents');
    if (contents.length != 5) return false;
    if (contents[0].length != 8) return false;
    if (contents[1].length != 4) return false;
    if (contents[2].length != 4) return false;
    if (contents[3].length != 4) return false;
    if (contents[4].length != 12) return false;
    return true;
  }
}
