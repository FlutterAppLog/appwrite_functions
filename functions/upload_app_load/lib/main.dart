import 'dart:async';
import 'package:upload_app_log/app_load_run.dart';
import 'package:upload_app_log/app_user_run.dart';
import 'package:upload_app_log/commons/appwrite_main.dart';

// This Appwrite function will be executed every time your function is triggered
Future<dynamic> main(final context) => AppwriteMain(context: context).run([
      AppLoadRun(),
      AppUserRun(),
    ]);
