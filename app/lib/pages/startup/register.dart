import '/components/primaryButton.dart';
import '/services/userApiService.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  bool isEmailValid = true;
  String emailErrorText = '';
  bool isPhoneValid = true;
  String phoneErrorText = '';
  bool _obscureText = true;
  final box = Hive.box('appBox');

  bool validateEmail(String email) {
    String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(email);
  }

  bool validatePhone(String phone) {
    String pattern = r'^\d{10}$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(phone);
  }

  void onRegisterPressed() {
    setState(() {
      isEmailValid = validateEmail(emailController.text);
      emailErrorText = isEmailValid ? '' : 'Please enter a valid email';
      isPhoneValid = validatePhone(phoneController.text);
      phoneErrorText =
          isPhoneValid ? '' : 'Please enter a valid 10-digit phone number';
    });

    if (isEmailValid && isPhoneValid && emailController.text.isNotEmpty) {
      var response = UserApiService.getUser(emailController.text);
      response.then((user) {
        if (user.isEmpty) {
          Navigator.pushReplacementNamed(context, '/registerDetails',
              arguments: {
                'email': emailController.text,
                'password': passwordController.text,
                'name': nameController.text,
                'phone': phoneController.text
              });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('User already exists',
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onSurface)),
            backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
          ));
        }
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
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            width: screenWidth,
            height: screenHeight,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/backgrounds/Startup.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(height: screenHeight * 0.05),
                            Padding(
                padding: EdgeInsets.only(top: screenWidth * 0.2),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Image.asset(
                    'assets/icons/appIcon.png',
                    width: screenWidth * 0.5,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
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
                              "Welcome",
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
                          height: screenHeight * 0.07,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(screenWidth * 0.1),
                          ),
                          child: TextField(
                            controller: nameController,
                            decoration: InputDecoration(
                              hintText: 'Name',
                              hintStyle: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(screenWidth * 0.1),
                              ),
                              prefixIcon: Icon(
                                Icons.person,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
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
                            controller: phoneController,
                            decoration: InputDecoration(
                              hintText: 'Phone Number',
                              hintStyle: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(screenWidth * 0.1),
                              ),
                              prefixIcon: Icon(
                                Icons.phone,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                          ),
                        ),
                        if (!isPhoneValid)
                          Container(
                            width: screenWidth * 0.8,
                            padding: EdgeInsets.only(left: screenWidth * 0.05),
                            child: Text(
                              phoneErrorText,
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
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(screenWidth * 0.1),
                              ),
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Theme.of(context).colorScheme.onSurface,
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
                          func: onRegisterPressed,
                          ButtonText: Text(
                            'Register',
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
                              'Already have an Account?',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontSize: screenWidth * 0.04,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, '/login');
                              },
                              child: Text(
                                'Sign In',
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
            ],
          ),
        ],
      ),
    );
  }
}
