import 'dart:convert';
import 'dart:io';

import 'package:dart_appwrite/dart_appwrite.dart';
import 'package:darty_json_safe/darty_json_safe.dart';
import 'package:starter_template/commons/appwrite_data.dart';
import 'package:starter_template/commons/appwrite_exception.dart';
import 'package:starter_template/commons/appwrite_run.dart';
import 'package:crypto/crypto.dart';

Future<dynamic> appwriteMain<T extends AppwriteRun>(T run) async {
  try {
    final data = await run.run(JSON(run.context.req.bodyJson));
    return run.response(AppwriteData.success(data));
  } on AppwriteFunctionExpection catch (e) {
    return run.response(AppwriteData.error(e.message, e.code));
  } catch (e) {
    return run.response(AppwriteData.error(e.toString(), -1));
  }
}

Client appwriteClient(final context) {
  final client = Client()
      .setEndpoint(Platform.environment['APPWRITE_FUNCTION_API_ENDPOINT'] ?? '')
      .setProject(Platform.environment['APPWRITE_FUNCTION_PROJECT_ID'] ?? '')
      .setKey(context.req.headers['x-appwrite-key'] ?? '');
  return client;
}

/// 验证请求
Future<void> verifyRequest(final context) async {
  final headerJson = JSON(context.req.headers);
  int? timeInterval = headerJson['x-appwrite-timestamp'].int;
  int? timeDuration = headerJson['x-appwrite-timestamp-duration'].int;
  String? requestId = headerJson['x-appwrite-request-id'].string;
  if (timeInterval == null || timeDuration == null || requestId == null) {
    throw AppwriteFunctionExpection(
        code: -1,
        message:
            'miss header x-appwrite-timestamp or x-appwrite-timestamp-duration or x-appwrite-request-id');
  }
  int isAllowRequestTime = DateTime.now().millisecondsSinceEpoch - timeInterval;
  context.log('isAllowRequestTime: $isAllowRequestTime');
  if (isAllowRequestTime > timeDuration) {
    throw AppwriteFunctionExpection(code: -1, message: 'invalid request');
  }
  final key = "${timeInterval}_$timeDuration";
  final md5String = md5.convert(utf8.encode(key)).toString();
  context.log("md5String: $md5String");
  if (md5String != requestId) {
    throw AppwriteFunctionExpection(code: -1, message: 'invalid request');
  }
}
