import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/di/service_locator.dart';
import 'features/book_finder/presentation/bloc/book_bloc.dart';
import 'core/di/service_locator.dart' as di;
import 'features/device_sensor/presentation/cubit/dashboard_cubit.dart';
import 'features/device_sensor/presentation/cubit/sensor_cubit.dart';
import 'home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MultiBlocProvider(providers: [
    BlocProvider<BookBloc>(create: (_) => di.sl<BookBloc>()),
    BlocProvider<DashboardBloc>(create: (_) => sl<DashboardBloc>(),),
    BlocProvider<SensorBloc>(create: (_) => sl<SensorBloc>(),),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Book Finder',
      home: HomeScreen(),
    );
  }
}
