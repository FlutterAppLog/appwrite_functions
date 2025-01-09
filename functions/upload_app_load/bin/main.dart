import 'dart:convert';

import 'package:dart_appwrite/dart_appwrite.dart';
import 'package:dart_appwrite/enums.dart';

Future<void> main(List<String> args) async {
  final client = Client(endPoint: 'https://appwrite.winnermedical.com/v1');
  client.setProject('677f626b0012252b422e');
  final function = Functions(client);
  final execution = await function.createExecution(
    functionId: '677d06690031ec13586c',
    method: ExecutionMethod.pOST,
    headers: {
      "timestamp": "1736384518000",
      "timestamp-duration": "36000000",
      "request-id": "3040bde4a20e1ca5494a6b8b16da5c64"
    },
    body: json.encode({
      "time": "2025-01-03T05:33:11.222Z",
      "deviceId": "32109D1B-41CA-47EA-9A99-23074B8779AD",
      "environment": "sit",
      "isStoreVersion": false,
      "id": "c813d012-32fc-4811-8cc7-c3bbe316e0cb"
    }),
  );

  print(execution.responseBody);
}
