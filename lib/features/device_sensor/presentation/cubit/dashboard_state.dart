abstract class DashboardState {}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final int battery;
  final String device;
  final String os;
  DashboardLoaded(this.battery, this.device, this.os);
}

class DashboardError extends DashboardState {
  final String errMsg;
  DashboardError(this.errMsg);
}
