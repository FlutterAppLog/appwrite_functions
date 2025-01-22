import 'dart:async';
import 'dart:io';
import 'package:dart_appwrite/dart_appwrite.dart';
import 'package:dart_appwrite/models.dart';
import 'package:darty_json_safe/darty_json_safe.dart';

// This Appwrite function will be executed every time your function is triggered
Future<dynamic> main(final context) async {
  // You can use the Appwrite SDK to interact with other services
  // For this example, we're using the Users service
  final client = Client()
      .setEndpoint(Platform.environment['APPWRITE_FUNCTION_API_ENDPOINT'] ?? '')
      .setProject(Platform.environment['APPWRITE_FUNCTION_PROJECT_ID'] ?? '')
      .setKey(context.req.headers['x-appwrite-key'] ?? '');
  final bucketId = Platform.environment['BUCKET_ID']!;
  final databaseId = Platform.environment['DATABASE_ID']!;
  final logTableId = Platform.environment['LOG_TABLE_ID']!;
  final userTableId = Platform.environment['USER_TABLE_ID']!;
  final appLoadTableId = Platform.environment['APP_LOAD_TABLE_ID']!;
  final sentryTableId = Platform.environment['SENTRY_TABLE_ID']!;
  final day = int.parse(Platform.environment['DAY']!);
  final date =
      DateTime.now().subtract(Duration(days: day)).toUtc().toIso8601String();
  final databases = Databases(client);

  Future deleteLogData(
    String collectionId,
    String name,
    List<String> queries, {
    Future Function(Document document)? onDeleted,
  }) async {
    /// 查询超过对应设置天的数据进行删除
    final documents = await databases
        .listDocuments(
          databaseId: databaseId,
          collectionId: collectionId,
          queries: queries,
        )
        .then((e) => e.documents);
    context.log('需要删除$name: ${documents.length}');
    for (var e in documents) {
      await databases.deleteDocument(
        databaseId: databaseId,
        collectionId: collectionId,
        documentId: e.$id,
      );
      await onDeleted?.call(e);
    }
  }

  Future removeAppLoadData(String loadId) async {
    final queries = [Query.equal('appLoadId', loadId)];
    await deleteLogData(logTableId, '日志事件', queries,
        onDeleted: (document) async {
      /// 删除对应的日志文件
      final realmId = document.data['realmId'];
      context.log('删除日志文件: $realmId');
      await Storage(client).deleteFile(bucketId: bucketId, fileId: realmId);
    });
    await deleteLogData(sentryTableId, 'Sentry事件', queries);
    await deleteLogData(userTableId, '用户事件', queries);
  }

  await deleteLogData(
    appLoadTableId,
    'App启动事件',
    [
      Query.lessThanEqual('time', date),
    ],
    onDeleted: (document) async {
      return removeAppLoadData(document.$id);
    },
  );

  final loadId = JSON(context.req.query)['loadId'].string;
  if (loadId != null) {
    await removeAppLoadData(loadId);
  }

  return context.res.text('Is done!');
}
