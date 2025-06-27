import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/platform_channel_service.dart';
import 'dashboard_state.dart';

class DashboardBloc extends Cubit<DashboardState> {
  final PlatformChannelService service;
  DashboardBloc(this.service) : super(DashboardInitial());

  Future<void> loadDeviceInfo() async {
    emit(DashboardLoading());
    try {
      final battery = await service.getBatteryLevel();
      final device = await service.getDeviceName();
      final os = await service.getOSVersion();
      emit(DashboardLoaded(battery, device, os));
    } catch (e) {
      emit(DashboardError(e.toString()));
    }
  }
}
