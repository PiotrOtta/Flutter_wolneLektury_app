import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;

  const CustomElevatedButton(
      {super.key,
      required this.buttonText,
      required this.onPressed,
      this.backgroundColor = const Color.fromARGB(255, 150, 191, 13),
      this.textColor = Colors.white});

  @override
  Widget build(BuildContext context) {

    return Row(children: [
      Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          margin: const EdgeInsets.only(top: 15.0),
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: backgroundColor,
              foregroundColor: textColor,
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(20.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(buttonText),
            ),
          ),
        ),
      ),
    ]);
  }
}
