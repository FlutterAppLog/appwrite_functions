import 'dart:convert';
import 'dart:io';

import 'package:dart_appwrite/dart_appwrite.dart';
import 'package:darty_json_safe/darty_json_safe.dart';
import 'package:upload_app_log/commons/appwrite_data.dart';
import 'package:upload_app_log/commons/appwrite_exception.dart';
import 'package:upload_app_log/commons/appwrite_functions.dart';
import 'package:upload_app_log/commons/appwrite_run.dart';
import 'package:upload_app_log/commons/environment.dart';

class AppwriteMain {
  final dynamic context;
  final Environment environment;
  AppwriteMain({required this.context}) : environment = Environment() {
    context.log(json.encode(Platform.environment));
    context
        .log(context.req.bodyText); // Raw request body, contains request data
    context.log(json.encode(context.req
        .bodyJson)); // Object from parsed JSON request body, otherwise string
    context.log(json.encode(context.req
        .headers)); // String key-value pairs of all request headers, keys are lowercase
    context.log(context.req
        .scheme); // Value of the x-forwarded-proto header, usually http or https
    context.log(context.req
        .method); // Request method, such as GET, POST, PUT, DELETE, PATCH, etc.
    context.log(context.req
        .url); // Full URL, for example: http://awesome.appwrite.io:8000/v1/hooks?limit=12&offset=50
    context.log(context.req
        .host); // Hostname from the host header, such as awesome.appwrite.io
    context
        .log(context.req.port); // Port from the host header, for example 8000
    context.log(context.req.path); // Path part of URL, for example /v1/hooks
    context.log(context.req
        .queryString); // Raw query params string. For example "limit=12&offset=50"
    context.log(json.encode(context.req.query));
  }

  Client get client => Client()
      .setEndpoint(environment.endPoint)
      .setProject(environment.projectId)
      .setKey(context.req.headers['x-appwrite-key'] ?? '');

  Future<dynamic> run<T extends AppwriteRun>(List<T> runs) async {
    try {
      environment.setup();
      await verifyRequest(context);
      final run = runs.where((e) => e.path == requestPath).firstOrNull;
      if (run == null) {
        throw AppwriteFunctionExpection(
          code: -1,
          message: 'not support method ${context.req.method}',
        );
      }
      final data = await run.run(JSON(context.req.bodyJson), this);
      return response(AppwriteData.success(data));
    } on AppwriteFunctionExpection catch (e) {
      return response(AppwriteData.error(e.message, e.code));
    } catch (e) {
      return response(AppwriteData.error(e.toString(), -1));
    }
  }

  String get requestPath => context.req.path;

  dynamic response(AppwriteData data) {
    final dataMap = data.toMap();
    context.log(dataMap);
    return context.res.json(data.toMap());
  }
}
