import 'package:flutter/material.dart';

class Profilebutton extends StatelessWidget {
  final Function onPressed;
  final String title;
  final IconData iconLeading;
  final IconData iconTrailing;
  final Color? iconColor;
  const Profilebutton({super.key, required this.onPressed, required this.title, required this.iconLeading, required this.iconTrailing, this.iconColor});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return ListTile(
      leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
          child:
              Icon(iconLeading, color: iconColor ?? Theme.of(context).colorScheme.primary)),
      title: Text(title,
          style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: screenHeight * 0.02,
              fontWeight: FontWeight.normal)),
      trailing: IconButton(
          onPressed: () => onPressed(),
          icon: Icon(Icons.arrow_forward_ios,
              color: Theme.of(context).colorScheme.onSurface)),
    );
  }
}
