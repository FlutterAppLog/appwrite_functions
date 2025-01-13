import 'dart:convert';
import 'dart:io';
import 'package:darty_json_safe/darty_json_safe.dart';
import 'package:crypto/crypto.dart';
import 'package:upload_app_log/commons/appwrite_exception.dart';

/// 验证请求
Future<void> verifyRequest(final context) async {
  final headerJson = JSON(context.req.headers);
  int? timeInterval = headerJson['timestamp'].int;
  int? timeDuration = headerJson['timestamp-duration'].int;
  String? requestId = headerJson['request-id'].string;
  if (timeInterval == null || timeDuration == null || requestId == null) {
    throw AppwriteFunctionExpection(
        code: -1,
        message: 'miss header timestamp or timestamp-duration or request-id');
  }
  int isAllowRequestTime = DateTime.now().millisecondsSinceEpoch - timeInterval;
  context.log('isAllowRequestTime: $isAllowRequestTime');
  if (isAllowRequestTime > timeDuration) {
    throw AppwriteFunctionExpection(code: -1, message: 'invalid request');
  }
  final md5String = getMd5(timeInterval, timeDuration);
  context.log("md5String: $md5String");
  if (md5String != requestId) {
    throw AppwriteFunctionExpection(code: -1, message: 'invalid request');
  }
}

/// 获取环境变量
String getEnvironment(String key) {
  final value = Platform.environment[key];
  if (value == null) throw AppwriteFunctionExpection.keyNotFound(key);
  return value;
}

/// 验证ID
bool verifyId(String id) {
  final contents = id.split('-');
  if (contents.length != 5) return false;
  if (contents[0].length != 8) return false;
  if (contents[1].length != 4) return false;
  if (contents[2].length != 4) return false;
  if (contents[3].length != 4) return false;
  if (contents[4].length != 12) return false;
  return true;
}

String getMd5(int timeInterval, int duration) {
  final key = "${timeInterval}_$duration";
  return md5.convert(utf8.encode(key)).toString();
}
