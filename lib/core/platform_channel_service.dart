import 'package:flutter/services.dart';

class PlatformChannelService {
  static const MethodChannel _channel = MethodChannel('com.example.deviceinfo');

  Future<int> getBatteryLevel() async => await _channel.invokeMethod('getBatteryLevel');
  Future<String> getDeviceName() async => await _channel.invokeMethod('getDeviceName');
  Future<String> getOSVersion() async => await _channel.invokeMethod('getOSVersion');
  Future<void> toggleFlashlight() async => await _channel.invokeMethod('toggleFlashlight');
  Future<Map<String, dynamic>> getGyroscopeData() async =>
      Map<String, dynamic>.from(await _channel.invokeMethod('getGyroscope'));
}