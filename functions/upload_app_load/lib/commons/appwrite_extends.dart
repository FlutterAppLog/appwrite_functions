import 'package:darty_json_safe/darty_json_safe.dart';
import 'package:upload_app_log/commons/appwrite_exception.dart';

extension AppwriteExtends on dynamic {
  JSON get bodyJson {
    return JSON(this.req.bodyJson);
  }

  throwError(String message) {
    throw Exception(message);
  }
}

extension AppwriteJSON on JSON {
  DateTime getDateTime(String key) {
    final date = this[key].string;
    if (date == null) throw AppwriteFunctionExpection.keyNotFound(key);
    return DateTime.parse(date);
  }

  String getString(String key) {
    final value = this[key].string;
    if (value == null) throw AppwriteFunctionExpection.keyNotFound(key);
    return value;
  }

  bool getBool(String key) {
    final value = this[key].bool;
    if (value == null) throw AppwriteFunctionExpection.keyNotFound(key);
    return value;
  }
}
