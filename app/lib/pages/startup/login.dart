import 'package:devsync/components/primaryButton.dart';
import 'package:devsync/services/userApiService.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isEmailValid = true;
  String emailErrorText = '';
  bool _obscureText = true;
  final box = Hive.box('appBox');
  bool validateEmail(String email) {
    var box = Hive.box('appBox');
    List<dynamic> colleges = box.get('College') ?? [];

    for (var college in colleges) {
      String pattern = college['EmailRegex'];
      RegExp regex = RegExp(pattern);
      if (regex.hasMatch(email)) {
        return true;
      }
    }
    return false;
  }

  void onLoginPressed() {
    setState(() {
      isEmailValid = validateEmail(emailController.text);
      emailErrorText =
          isEmailValid ? '' : 'Please login via your college email';
    });

    if (isEmailValid && emailController.text.isNotEmpty) {
      var reponse = UserApiService.loginUser(
          emailController.text, passwordController.text);
      reponse.then((user) {
        var response2 = UserApiService.getUser(emailController.text);
        response2.then((user2) {
          Map<String, dynamic> userData = {
          'username': user['user']['username'],
          'email': user['user']['email'],
          'name': user['user']['Name'],
          'profilePicture': user['user']['profilePicture'],
          'bio': user['user']['Bio'],
          'skills': user['user']['Skills'],
          'year': user['user']['Year'],
          'gender': user['user']['Gender'],
          'isOpenToTeams': user['user']['isOpenToTeams'],
          'college': user2[0]['college']['Name'],
        };
        box.put('userData', userData);
        }).catchError((error) {
          print('Error: $error');
        });

      }).catchError((error) {
        print('Error: $error');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Invalid Details',
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface)),
          backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
        ));
      });
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  @override
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: screenHeight * 0.4,
                  width: screenWidth,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              Container(
                width: screenWidth,
                height: screenHeight * 0.72,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(screenWidth * 0.05),
                    bottomRight: Radius.circular(screenWidth * 0.05),
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              SizedBox(height: screenHeight * 0.05),
              Center(
                child: Image.asset(
                  'assets/icons/Logo.png',
                  width: screenWidth * 0.5,
                ),
              ),
              SizedBox(height: screenHeight * 0.07),
              const Spacer(),
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
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: screenHeight * 0.01),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: screenWidth * 0.05),
                            child: Text(
                              "Welcome Back!",
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: screenWidth * 0.05,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        Container(
                          width: screenWidth * 0.8,
                          height: screenHeight * 0.06,
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).colorScheme.surfaceContainer,
                            borderRadius:
                                BorderRadius.circular(screenWidth * 0.1),
                          ),
                          child: TextField(
                            controller: emailController,
                            decoration: InputDecoration(
                              hintText: 'Email',
                              hintStyle: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(screenWidth * 0.1),
                              ),
                              prefixIcon: Icon(
                                Icons.email,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                          ),
                        ),
                        if (!isEmailValid)
                          Container(
                            width: screenWidth * 0.8,
                            padding: EdgeInsets.only(left: screenWidth * 0.05),
                            child: Text(
                              emailErrorText,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.error,
                                fontSize: screenWidth * 0.03,
                              ),
                            ),
                          ),
                        SizedBox(height: screenHeight * 0.02),
                        Container(
                          width: screenWidth * 0.8,
                          height: screenHeight * 0.07,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(screenWidth * 0.1),
                          ),
                          child: TextField(
                            controller: passwordController,
                            obscureText: _obscureText,
                            decoration: InputDecoration(
                              hintText: 'Password',
                              hintStyle: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(screenWidth * 0.1),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureText
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        Primarybutton(
                          func: onLoginPressed,
                          ButtonText: Text(
                            'Login',
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account?',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontSize: screenWidth * 0.04,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(context, '/register');
                              },
                              child: Text(
                                'Register',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: screenWidth * 0.04,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Image.asset(
                'assets/icons/CRISPR_white.png',
                width: screenWidth * 0.25,
              ),
              SizedBox(height: screenHeight * 0.07),
            ],
          ),
        ],
      ),
    );
  }
}
