import 'package:flutter/material.dart';
// import 'package:wolne_lektury_client/button_section.dart';
import 'package:wolne_lektury_client/screens/navigation.dart';
import 'package:wolne_lektury_client/screens/welcome.dart';
// import 'package:wolne_lektury_client/title_section.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Wolne lektury API klient",
      theme: ThemeData(useMaterial3: true),
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/navigation': (context) => const NavigationScreen()
      },
    );
  }
}
