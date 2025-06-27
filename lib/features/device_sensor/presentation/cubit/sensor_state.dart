abstract class SensorState {}

class SensorInitial extends SensorState {}

class FlashlightToggled extends SensorState {}

class GyroscopeData extends SensorState {
  final Map<String, dynamic> data;
  GyroscopeData(this.data);
}

class SensorError extends SensorState {
  final String errMsg;
  SensorError(this.errMsg);
}
