import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:piwot2/components/schemeCarousel.dart';
import 'package:piwot2/pages/home/chatbot.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/dataSyncService.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _isLoading = true;
  var box = Hive.box('appBox');
  SharedPreferences? prefs;
  bool isDark = false;

  Future<void> dataSync() async {
    DataSyncService dataSyncService = DataSyncService();
    await dataSyncService.syncData();
    setState(() => _isLoading = false);
  }
  @override
  void initState()  {
    dataSync();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return _isLoading
        ? Scaffold(
          body: Center(
            child: Column(
              children: [
                Spacer(),
                CircularProgressIndicator(),
                SizedBox(height: screenHeight * 0.02),
                Text('Fetching Data', style: TextStyle(fontSize: screenHeight * 0.03)),
                Spacer(),
              ],
            ),
          ),
        )
        :
    Scaffold(
        appBar: AppBar(
            leading: CircleAvatar(
                child: Image.asset('assets/icons/appIcon.png',
                    height: screenHeight * 0.07)),
            backgroundColor: Color(0xFF238B45),
            title: Text('कृषिGuru',
                style: TextStyle(
                    color: Colors.white, fontSize: screenHeight * 0.03)),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Text(
                      box.get('userData')['name'][0],
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/profile');
                  },
                ),
              ),
            ]),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Chatbot()),
            );
          },
          backgroundColor: Colors.orange,
          child: const Icon(
            Icons.chat_bubble_outline,
            color: Colors.white,
          ),
        ),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Schemecarousel(),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Categories:',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: screenHeight * 0.03,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: screenHeight * 0.15,
                      height: screenHeight * 0.15,
                      child: GestureDetector(
                        onTap: () {
                          
                        },
                        child: Card(
                          color: Theme.of(context).colorScheme.primary,
                          child: Padding(
                            padding: EdgeInsets.all(screenHeight * 0.01),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(screenHeight * 0.01),
                                color: Theme.of(context).colorScheme.surface,
                              ),
                              child: Column(
                                children: [
                                  Image.asset('assets/icons/cropIcon.png'),
                                  Text(
                                    'Crop Disease Prediction',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                      fontSize: screenHeight * 0.015,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: screenHeight * 0.15,
                      height: screenHeight * 0.15,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/fertilizer');
                        },
                        child: Card(
                          color: Theme.of(context).colorScheme.primary,
                          child: Padding(
                            padding: EdgeInsets.all(screenHeight * 0.01),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(screenHeight * 0.01),
                                color: Theme.of(context).colorScheme.surface,
                              ),
                              child: Column(
                                children: [
                                  SizedBox(height: screenHeight * 0.01),
                                  Image.asset(
                                      'assets/icons/fertilizerIcon.png'),
                                  SizedBox(height: screenHeight * 0.01),
                                  Text(
                                    'Fertilizer Detection',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                      fontSize: screenHeight * 0.015,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: screenHeight * 0.15,
                      height: screenHeight * 0.15,
                      child: GestureDetector(
                        onTap: () {
                          print('Weather Prediction');
                        },
                        child: Card(
                          color: Theme.of(context).colorScheme.primary,
                          child: Padding(
                            padding: EdgeInsets.all(screenHeight * 0.01),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(screenHeight * 0.01),
                                color: Theme.of(context).colorScheme.surface,
                              ),
                              child: Column(
                                children: [
                                  SizedBox(height: screenHeight * 0.01),
                                  Image.asset('assets/icons/landIcon.png'),
                                  SizedBox(height: screenHeight * 0.01),
                                  Text(
                                    'Know Your\nLand',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                      fontSize: screenHeight * 0.015,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text("Marketplace",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: screenHeight * 0.03)),
                ),
                Container(
                    width: screenWidth,
                    height: screenHeight * 0.25,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(screenWidth * 0.02),
                        topRight: Radius.circular(screenWidth * 0.02),
                      ),
                    ),
                    child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/marketplace',
                                    arguments: {'name': 'Urea'});
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Container(
                                  width: screenWidth * 0.3,
                                  height: screenHeight * 0.15,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(screenWidth * 0.02),
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(height: screenHeight * 0.01),
                                      Image.asset('assets/icons/urea.png', height: screenHeight * 0.09,),
                                      SizedBox(height: screenHeight * 0.01),
                                      Text(
                                        'Urea',
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary,
                                          fontSize: screenHeight * 0.015,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/marketplace',
                                    arguments: {'name': 'DAP'});
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Container(
                                  width: screenWidth * 0.3,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(screenWidth * 0.02),
                                  ),
                                  height: screenHeight * 0.15,
                                  child: Column(
                                    children: [
                                      SizedBox(height: screenHeight * 0.01),
                                      Image.asset('assets/icons/dap.png', height: screenHeight * 0.09,),
                                      SizedBox(height: screenHeight * 0.01),
                                      Text(
                                        'DAP',
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary,
                                          fontSize: screenHeight * 0.015,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/marketplace',
                                    arguments: {'name': 'Nitrophosphate'});
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Container(
                                  width: screenWidth * 0.3,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(screenWidth * 0.02),
                                  ),
                                  height: screenHeight * 0.15,
                                  child: Column(
                                    children: [
                                      SizedBox(height: screenHeight * 0.01),
                                      Image.asset('assets/icons/nitrophosphate.png',),
                                      SizedBox(height: screenHeight * 0.01),
                                      Text(
                                        'Nitrophosphate',
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary,
                                          fontSize: screenHeight * 0.015,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/marketplace',
                                    arguments: {'name': 'Phosphorus'});
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Container(
                                  width: screenWidth * 0.3,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(screenWidth * 0.02),
                                  ),
                                  height: screenHeight * 0.15,
                                  child: Column(
                                    children: [
                                      SizedBox(height: screenHeight * 0.01),
                                      Image.asset('assets/icons/phosphate.png', height: screenHeight * 0.09,),
                                      SizedBox(height: screenHeight * 0.01),
                                      Text(
                                        'Phosphorus',
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary,
                                          fontSize: screenHeight * 0.015,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/marketplace',
                                    arguments: {'name': 'Potassium'});
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Container(
                                  width: screenWidth * 0.3,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(screenWidth * 0.02),
                                  ),
                                  height: screenHeight * 0.15,
                                  child: Column(
                                    children: [
                                      SizedBox(height: screenHeight * 0.01),
                                      Image.asset('assets/icons/potassium.png', height: screenHeight * 0.09,),
                                      SizedBox(height: screenHeight * 0.01),
                                      Text(
                                        'Potassium',
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary,
                                          fontSize: screenHeight * 0.015,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ))),
                Spacer(),
              ],
            ),
          ],
        ));
  }
}
