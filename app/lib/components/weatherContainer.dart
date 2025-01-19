import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:fl_chart/fl_chart.dart';

class Weathercontainer extends StatefulWidget {
  const Weathercontainer({super.key});

  @override
  State<Weathercontainer> createState() => _WeathercontainerState();
}

class _WeathercontainerState extends State<Weathercontainer> {
  var weatherData = Hive.box('appBox').get('Weather Data');
  
  Widget _buildGraph() {
    List<FlSpot> spots = [];
    if (weatherData != null) {
      for (var i = 2; i < 9; i++) {
        spots.add(FlSpot(i.toDouble(), double.parse(weatherData[i].toString())));
      }
    }

    return SizedBox(
      child: LineChart(
        LineChartData(
          gridData: FlGridData(
            show: true,
            drawHorizontalLine: false,
            drawVerticalLine: true,
            verticalInterval: 1,
            getDrawingVerticalLine: (value) {
              return FlLine(
                color: Colors.white.withOpacity(0.2),
                strokeWidth: 1,
                dashArray: [5, 5], // Optional: makes dotted lines
              );
            },
          ),
          titlesData: FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              color: Colors.white.withOpacity(0.8),
              barWidth: 2,
              dotData: FlDotData(
                checkToShowDot: (spot, barData) => true,
                getDotPainter: (spot, percent, barData, index) {
                  return FlDotCirclePainter(
                    radius: 3,
                    color: Colors.white,
                    strokeWidth: 1,
                  );
                },
              ),
              belowBarData: BarAreaData(
                show: true,
                color: Colors.white.withOpacity(0.2),
              ),
            ),
          ],
          minY: spots.isEmpty ? 0 : spots.map((e) => e.y).reduce(min) - 5,
          maxY: spots.isEmpty ? 0 : spots.map((e) => e.y).reduce(max) + 5,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: screenWidth*0.8,
        height: screenWidth * 0.4,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF62CFF4), Color(0xFF2C67F2)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(screenWidth * 0.02),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: screenWidth*0.02),
                        child: Text('Weather Watch', style: TextStyle(color: Colors.white, fontSize: screenWidth*0.07)),
                      ),
                      Image.network('https:${weatherData[0]}'),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: screenWidth*0.05, top: screenWidth*0.1),
                    child: Column(
                      children: [
                        Text('${weatherData[1]}°C', style: TextStyle(color: Colors.white, fontSize: screenWidth*0.07)),
                        Padding(
                          padding: EdgeInsets.only(top: screenWidth*0.02),
                          child: Text('Today', style: TextStyle(color: Colors.white, fontSize: screenWidth*0.05)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(child: _buildGraph()),
            ],
          ),
        ),
      ),
    );
  }
}
