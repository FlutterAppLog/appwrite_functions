import 'dart:async';
import 'package:starter_template/app_load_run.dart';
import 'package:starter_template/commons/appwrite_functions.dart';

// This Appwrite function will be executed every time your function is triggered
Future<dynamic> main(final context) async {
  final data = appwriteMain(AppLoadRun(context: context));
  return data;
}
