import 'package:flutter/material.dart';

class CyanButton extends StatelessWidget {
  final String label;
  final Function() onPressed;
  final double width;
  const CyanButton(
      {Key? key,
      required this.label,
      required this.onPressed,
      required this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: MediaQuery.of(context).size.width * width,
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 173, 85, 79),
          borderRadius: BorderRadius.circular(25)),
      child: MaterialButton(
        textColor: Colors.white,
        onPressed: onPressed,
        child: Text(
          label,
        ),
      ),
    );
  }
}
