import 'dart:math';
import 'dart:ui';
import 'dart:isolate';

import 'package:submiss_f3/data/model/base.dart';
import 'package:submiss_f3/data/source/api/rest_client.dart';
import 'package:submiss_f3/main.dart';
import 'package:submiss_f3/utils/notification/notification_helper.dart';
import 'package:dio/dio.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService? _instance;
  static String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  BackgroundService._internal() {
    _instance = this;
  }

  factory BackgroundService() => _instance ?? BackgroundService._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }

  static Future<void> callback() async {
    print('Alarm fired!');
    final NotificationHelper _notificationHelper = NotificationHelper();
    BaseRestaurants result = await RestClient(Dio()).getList();
    if (result.error == false && result.restaurants != null) {
      await _notificationHelper.showNotification(
        flutterLocalNotificationsPlugin,
        result.restaurants![Random().nextInt(result.restaurants!.length - 1)],
      );
    }

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }
}
