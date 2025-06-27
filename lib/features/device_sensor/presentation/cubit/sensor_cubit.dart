import 'package:backbase_assessment/features/device_sensor/presentation/cubit/sensor_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/platform_channel_service.dart';

class SensorBloc extends Cubit<SensorState> {
  final PlatformChannelService service;
  SensorBloc(this.service) : super(SensorInitial());

  void toggleFlashlight() async {
    try {
      await service.toggleFlashlight();
      emit(FlashlightToggled());
    } catch (e) {
      emit(SensorError(e.toString()));
    }
  }

  void readGyroscope() async {
    try {
      final data = await service.getGyroscopeData();
      emit(GyroscopeData(data));
    } catch (e) {
      emit(SensorError(e.toString()));
    }
  }
}
