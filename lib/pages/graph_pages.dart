import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sensors_plus/sensors_plus.dart';


class SensorHomePage extends StatefulWidget {
  @override
  _SensorHomePageState createState() => _SensorHomePageState();
}

class _SensorHomePageState extends State<SensorHomePage> {
  List<double> _accelerometerValues = [0, 0, 0];
  List<double> _gyroscopeValues = [0, 0, 0];
  final List<FlSpot> accelerometerXSpots = [];
  final List<FlSpot> gyroscopeXSpots = [];

  late StreamSubscription<AccelerometerEvent> _accelerometerSubscription;
  late StreamSubscription<GyroscopeEvent> _gyroscopeSubscription;

  double _currentTime = 0;

  @override
  void initState() {
    super.initState();

    _accelerometerSubscription = accelerometerEvents.listen((event) {
      setState(() {
        _accelerometerValues = [event.x, event.y, event.z];
        _currentTime += 0.1; // Increment time for plotting the graph
        accelerometerXSpots.add(FlSpot(_currentTime, event.x));
        if (accelerometerXSpots.length > 100) {
          accelerometerXSpots.removeAt(0); // Keep only last 100 values
        }
      });
    });

    _gyroscopeSubscription = gyroscopeEvents.listen((event) {
      setState(() {
        _gyroscopeValues = [event.x, event.y, event.z];
        _currentTime += 0.1;
        gyroscopeXSpots.add(FlSpot(_currentTime, event.x));
        if (gyroscopeXSpots.length > 100) {
          gyroscopeXSpots.removeAt(0);
        }
      });
    });
  }

  @override
  void dispose() {
    _accelerometerSubscription.cancel();
    _gyroscopeSubscription.cancel();
    super.dispose();
  }

  Widget buildGraph(List<FlSpot> spots, String label) {
    return LineChart(
      LineChartData(
        titlesData: FlTitlesData(show: false),
        borderData: FlBorderData(show: true),
        lineBarsData: [
          LineChartBarData(
            isCurved: true,
            color: Colors.blue,
            spots: spots,
            dotData: FlDotData(show: false),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final accelerometer = _accelerometerValues.map((v) => v.toStringAsFixed(2)).toList();
    final gyroscope = _gyroscopeValues.map((v) => v.toStringAsFixed(2)).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Sensor Data Visualizer'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Accelerometer: X: ${accelerometer[0]}, Y: ${accelerometer[1]}, Z: ${accelerometer[2]}'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Gyroscope: X: ${gyroscope[0]}, Y: ${gyroscope[1]}, Z: ${gyroscope[2]}'),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text('Accelerometer X-axis'),
                  Expanded(child: buildGraph(accelerometerXSpots, 'Accelerometer X')),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text('Gyroscope X-axis'),
                  Expanded(child: buildGraph(gyroscopeXSpots, 'Gyroscope X')),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
