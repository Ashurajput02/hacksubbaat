import 'package:flutter/material.dart';

class Registerdetails extends StatefulWidget {
  final String email;
  final String password;
  const Registerdetails(
      {super.key, required this.email, required this.password});

  @override
  State<Registerdetails> createState() => _RegisterdetailsState();
}

class _RegisterdetailsState extends State<Registerdetails> {
  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  int year = 0;
  String gender = '';
  bool isOpenToTeams = false;
  
  

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
