import 'package:flutter/material.dart';

class Primarybutton extends StatefulWidget {
  final void Function() func;
  final Text ButtonText;
  final double height;
  final double width;
  const Primarybutton({super.key, required this.func, required this.ButtonText, required this.height, required this.width});

  @override
  State<Primarybutton> createState() => _PrimarybuttonState();
}

class _PrimarybuttonState extends State<Primarybutton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: widget.func, child: widget.ButtonText,
      style: ButtonStyle(
        minimumSize: WidgetStateProperty.all(Size(widget.width, widget.height)),
        backgroundColor: WidgetStateProperty.all(Theme.of(context).colorScheme.primary),
        padding: WidgetStateProperty.all(EdgeInsets.symmetric(vertical: widget.height * 0.1, horizontal: widget.width * 0.1)),
        shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(widget.width * 0.125))),
        textStyle: WidgetStateProperty.all(TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
      ),
    );
  }
}