import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/dashboard_cubit.dart';
import '../cubit/dashboard_state.dart';
import '../cubit/sensor_cubit.dart';
import '../cubit/sensor_state.dart';

class DeviceSensorScreen extends StatelessWidget {
  const DeviceSensorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Devie Sensor App')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                children: [
                  ElevatedButton(
                      onPressed: () {
                        context.read<DashboardBloc>().loadDeviceInfo();
                      },
                      child: const Text("Device Info")),
                  BlocBuilder<DashboardBloc, DashboardState>(
                    builder: (context, state) {
                      if (state is DashboardLoading) {
                        return const Center(
                          // child: Lottie.asset('assets/loading.json', width: 150),
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is DashboardLoaded) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Battery: ${state.battery}%'),
                              Text('Device: ${state.device}'),
                              Text('OS: ${state.os}'),
                            ],
                          ),
                        );
                      } else if (state is DashboardError) {
                        return Center(
                          child: Text(state.errMsg),
                        );
                      }
                      return Container();
                    },
                  ),
                ],
              ),
              Column(
                children: [
                  ElevatedButton(
                      onPressed: () {
                        context.read<SensorBloc>().readGyroscope();
                      },
                      child: const Text("Sensor Info")),
                  BlocBuilder<SensorBloc, SensorState>(
                    builder: (context, state) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (state is GyroscopeData)
                              Text('Gyroscope: ${state.data}')
                          ],
                        ),
                      );
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
