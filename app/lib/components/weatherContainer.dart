import 'package:flutter/material.dart';

class Weathercontainer extends StatefulWidget {
  const Weathercontainer({super.key});

  @override
  State<Weathercontainer> createState() => _WeathercontainerState();
}

class _WeathercontainerState extends State<Weathercontainer> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
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
    );
  }
}