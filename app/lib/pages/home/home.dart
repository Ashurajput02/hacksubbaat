import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:piwot2/components/schemeCarousel.dart';
import 'package:piwot2/components/weatherContainer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var box = Hive.box('appBox');

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
          leading: CircleAvatar(child: Image.asset('assets/images/logo.png')),
          backgroundColor: Theme.of(context).primaryColor,
          title: Text('कृषिGuru',
              style: TextStyle(
                  color: Colors.white, fontSize: screenHeight * 0.03)),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text(box.get('userData')['name'][0])),
              
                onTap: () {
                  Navigator.pushNamed(context, '/profile');
                },
              ),
            ),
          ]),
          body: Stack(
            children: [
              Container(
                width: screenWidth,
                height: screenHeight,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/backgrounds/Home.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                children: [
                  Schemecarousel(),
                  SizedBox(
                    height: screenHeight * 0.1,
                  ),
                  Weathercontainer(),
                ],
              ),

            ],
          )
    );
  }
}
