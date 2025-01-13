import 'package:upload_app_log/commons/appwrite_functions.dart';

class Environment {
  late String endPoint;
  late String projectId;
  late String databaseId;
  late String appLoadTableId;
  late String appUserTableId;
  late String appSentryTableId;
  late String appLogTableId;
  setup() {
    endPoint = getEnvironment('APPWRITE_FUNCTION_API_ENDPOINT');
    projectId = getEnvironment('APPWRITE_FUNCTION_PROJECT_ID');
    databaseId = getEnvironment('APPWRITE_FUNCTION_DATABASE_ID');
    appLoadTableId = getEnvironment('APPWRITE_FUNCTION_APP_LOAD_TABLE_ID');
    appUserTableId = getEnvironment('APPWRITE_FUNCTION_APP_USER_TABLE_ID');
    appSentryTableId = getEnvironment('APPWRITE_FUNCTION_APP_SENTRY_TABLE_ID');
    appLogTableId = getEnvironment('APPWRITE_FUNCTION_APP_LOG_TABLE_ID');
  }
}
