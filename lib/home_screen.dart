import 'package:flutter/material.dart';

import 'features/device_sensor/presentation/pages/device_sensor_screen.dart';
import 'features/book_finder/presentation/pages/search_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Backbase Assessment')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const SearchScreen()));
                  },
                  child: const Text("Book Finder App")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const DeviceSensorScreen()));
                  },
                  child: const Text("Device Info & Sensor App")),
            ],
          ),
        ),
      ),
    );
  }
}
