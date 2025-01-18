import 'package:flutter/material.dart';
import 'package:piwot2/services/userApiService.dart';

import '../../components/primaryButton.dart';

class Registerdetails extends StatefulWidget {
  final String email;
  final String password;
  final String name;
  final String phone;
  const Registerdetails(
      {super.key,
      required this.email,
      required this.password,
      required this.name,
      required this.phone});

  @override
  State<Registerdetails> createState() => _RegisterdetailsState();
}

class _RegisterdetailsState extends State<Registerdetails> {
  bool isFarmer = false;
  String gender = '';
  Color maleColor = Colors.transparent;
  Color femaleColor = Colors.transparent;
  Color othersColor = Colors.transparent;
  Color farmerColor = Colors.transparent;
  Color doctorColor = Colors.transparent;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamed(context, '/login');
        return false;
      },
      child: Scaffold(
        body: Stack(children: [
          Container(
            width: screenWidth,
            height: screenHeight,
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: const AssetImage('assets/backgrounds/Startup.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  AnimatedPadding(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Container(
                      width: screenWidth * 0.9,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceContainer,
                        borderRadius: BorderRadius.circular(screenWidth * 0.05),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: screenHeight * 0.01),
                          Padding(
                            padding: EdgeInsets.only(left: screenWidth * 0.05),
                            child: Text(
                              "Gender",
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: screenWidth * 0.07,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    gender = 'Male';
                                    maleColor = Colors.lightGreen;
                                    femaleColor = Colors.transparent;
                                    othersColor = Colors.transparent;
                                  });
                                },
                                child: Container(
                                  width: screenWidth * 0.25,
                                  height: screenWidth * 0.25,
                                  decoration: BoxDecoration(
                                    color: maleColor,
                                    border: Border.all(
                                      color: Theme.of(context).colorScheme.primary,
                                      width: screenWidth * 0.005,
                                    ),
                                  ),
                                  child: Column(children: [
                                    Icon(Icons.person,
                                        color: Colors.blue,
                                        size: screenWidth * 0.15),
                                    Text('Male',
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            fontSize: screenWidth * 0.05)),
                                  ]),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    gender = 'Female';
                                    femaleColor = Colors.lightGreen;
                                    maleColor = Colors.transparent;
                                    othersColor = Colors.transparent;
                                  });
                                },
                                child: Container(
                                  width: screenWidth * 0.25,
                                  height: screenWidth * 0.25,
                                  decoration: BoxDecoration(
                                    color: femaleColor,
                                    border: Border.all(
                                      color: Theme.of(context).colorScheme.primary,
                                      width: screenWidth * 0.005,
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Icon(Icons.person,
                                          color: Colors.pink,
                                          size: screenWidth * 0.15),
                                      Text('Female',
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                              fontSize: screenWidth * 0.05)),
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    gender = 'Others';
                                    othersColor = Colors.lightGreen;
                                    maleColor = Colors.transparent;
                                    femaleColor = Colors.transparent;
                                  });
                                },
                                child: Container(
                                  width: screenWidth * 0.25,
                                  height: screenWidth * 0.25,
                                  decoration: BoxDecoration(
                                    color: othersColor,
                                    border: Border.all(
                                      color: Theme.of(context).colorScheme.primary,
                                      width: screenWidth * 0.005,
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Icon(Icons.person,
                                          color: Colors.orange,
                                          size: screenWidth * 0.15),
                                      Text('Other',
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                              fontSize: screenWidth * 0.05)),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          Padding(
                            padding: EdgeInsets.only(left: screenWidth * 0.05),
                            child: Text(
                              'Choose your role',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: screenWidth * 0.07,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          Padding(
                            padding: EdgeInsets.only(left: screenWidth * 0.05),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isFarmer = true;
                                      farmerColor = Colors.lightGreen;
                                      doctorColor = Colors.transparent;
                                    });
                                  },
                                  child: Container(
                                    width: screenWidth * 0.8,
                                    height: screenWidth * 0.4,
                                    decoration: BoxDecoration(
                                      color: farmerColor,
                                      border: Border.all(
                                        color: Theme.of(context).colorScheme.primary,
                                        width: screenWidth * 0.005,
                                      ),
                                      borderRadius:
                                          BorderRadius.circular(screenWidth * 0.02),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Image.asset('assets/icons/farmer.png',
                                            width: screenWidth * 0.2),
                                        Text('Farmer',
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                                fontSize: screenWidth * 0.1)),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.02),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isFarmer = false;
                                      doctorColor = Colors.lightGreen;
                                      farmerColor = Colors.transparent;
                                    });
                                  },
                                  child: Container(
                                    width: screenWidth * 0.8,
                                    height: screenWidth * 0.4,
                                    decoration: BoxDecoration(
                                      color: doctorColor,
                                      border: Border.all(
                                        color: Theme.of(context).colorScheme.primary,
                                        width: screenWidth * 0.005,
                                      ),
                                      borderRadius:
                                          BorderRadius.circular(screenWidth * 0.02),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Image.asset('assets/icons/doctor.png',
                                            width: screenWidth * 0.2),
                                        Text('Doctor',
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                                fontSize: screenWidth * 0.1)),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          Center(
                            child: Primarybutton(
                              func: onLoginPressed,
                              ButtonText: Text(
                                'Next',
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .surfaceContainer,
                                  fontSize: screenWidth * 0.07,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              height: screenHeight * 0.07,
                              width: screenWidth * 0.8,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.02),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }

  void onLoginPressed() {
    var response = UserApiService.createUser(widget.name, widget.email, widget.email,
        widget.password, isFarmer, widget.phone, gender);
    response.then((value) {
      if (value['error'] == null) {
        Navigator.pushNamed(context, '/login');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(value['error']),
          duration: const Duration(seconds: 3),
        ));
      }
    });
  }
}
