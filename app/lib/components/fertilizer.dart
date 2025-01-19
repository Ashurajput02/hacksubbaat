import 'package:flutter/material.dart';
import 'package:piwot2/components/primaryButton.dart';

class FertilizerScreen extends StatelessWidget {
  final String responseData;

  FertilizerScreen({required this.responseData});

  void _goBack(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => _goBack(context),
          ),
          title: Text('Fertilizer Prediction',
              style: TextStyle(color: Colors.white))),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/backgrounds/Home.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: screenWidth * 0.05),
            child: Column(
              children: [
                SizedBox(height: screenHeight * 0.02),
                Center(
                  child: Text('The best fertilizer for you',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: screenWidth * 0.07,
                          ), textAlign: TextAlign.center),
                ),
                SizedBox(height: screenHeight * 0.02),
                Image.asset('assets/icons/${responseData.toLowerCase()}.png'),
                SizedBox(height: screenHeight * 0.02),
                Center(
                  child: Text(responseData,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: screenWidth * 0.07,
                          fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                ),
                SizedBox(height: screenHeight * 0.02),
                Primarybutton(func: (){
                  Navigator.pushNamed(context, '/marketplace', arguments: {'name': responseData});
                }, ButtonText: Text('See Best Prices', style: TextStyle(color: Theme.of(context).colorScheme.surface, fontSize: screenWidth * 0.05, fontWeight: FontWeight.w600)), height: screenHeight * 0.07, width: screenWidth * 0.5),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
