import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wolne_lektury_client/widgets/custom_elevated_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Image.asset('assets/images/abstract_color_pattern.jpg'),
        Container(
          transform: Matrix4.translationValues(0.0, -50.0, 0.0),
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.circular(20)),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Image.asset('assets/images/logo_wolne_lektury.png'),
              const SizedBox(
                height: 20.0,
              ),
              const Text(
                "Wielka darmowa biblioteka!",
                style: TextStyle(fontSize: 25.0),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20.0,
              ),
              const Text(
                "Używanie aplikacji wiąże się z opłatami o wysokości 20 smoczych monet za godzinę korzystania.",
                style: TextStyle(fontSize: 15),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30.0,
              ),
              CustomElevatedButton(
                buttonText: 'ZACZNIJ PRZEGLĄDAĆ',
                onPressed: () {
                  Navigator.pushReplacementNamed(context, "/navigation");
                },
              ),
              CustomElevatedButton(
                buttonText: 'WYJDŹ Z APLIKACJI',
                onPressed: () {
                  SystemNavigator.pop(); // Android
                  exit(0); // IOS
                },
                backgroundColor: Colors.white,
                textColor: Colors.grey,
              ),
            ],
          ),
        )
      ],
    ));
  }
}
