import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  
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
                color: Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(20)
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Image.asset('assets/images/logo_wolne_lektury.png'),
                  const Text("Wielka darmowa biblioteka!"),
                  const Text("Używanie aplikacji wiąże się z opłatami o wysokości 20 smoczych monet za godzinę korzystania."),
                  TextButton(onPressed: () {}, child: const Text("Zacznij przeglądać")),
                  TextButton(onPressed: () {}, child: const Text("Wyjdź z aplikacji"))
                ],
                ),
            )
          ],
       )
    );
  }

}
