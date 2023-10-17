import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demonstration_app/core/app_navigation.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static const batteryChannel = MethodChannel('flutter_demonstration_app/batteryChannel');
  String batteryLevel = 'Loading batery level ...';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                AppNavigation.navigateToCustomers(context);
              },
              child: const Text('Go to customers'),
            ),
            ElevatedButton(
              onPressed: () async {
                await getBaterryLevel();
              },
              child: const Text('Get Batterry Level'),
            ),
            Text(batteryLevel)
          ],
        ),
      ),
    );
  }

  Future getBaterryLevel() async {
    final int level = await batteryChannel.invokeMethod('getBatteryLevel');

    setState(() => batteryLevel = 'Batery level is $level');
  }
}
