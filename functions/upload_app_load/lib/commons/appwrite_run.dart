import 'package:darty_json_safe/darty_json_safe.dart';
import 'package:starter_template/commons/appwrite_data.dart';

abstract class AppwriteRun {
  final dynamic context;
  const AppwriteRun({required this.context});

  JSON get req => context.req;

  Future<Map<String, dynamic>> run(JSON req);

  dynamic response(AppwriteData data) {
    return context.res.json(data.toMap());
  }
}
