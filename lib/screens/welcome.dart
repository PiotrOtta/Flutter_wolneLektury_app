import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wolne_lektury_client/widgets/custom_elevated_button.dart';
import 'package:flutter_svg/flutter_svg.dart';

const String svgString = '''
<svg viewBox="0 0 500 400" xmlns="http://www.w3.org/2000/svg">
  <rect x="62.256" y="-13.086" width="470.226" height="652.249" style="fill: rgb(250, 194, 0);"/>
  <path style="fill: rgb(150, 190, 10);" d="M 31.919 -23.198 C 148.776 -23.198 224.554 100.055 171.807 204.33 C 141.928 263.398 166.211 335.491 225.739 364.443 C 358.401 428.964 371.468 612.901 249.26 695.528 C 247.068 697.01 244.845 698.447 242.593 699.837 C 114.586 778.847 -50.949 689.656 -55.37 539.294 C -56.038 516.568 -52.735 493.899 -45.61 472.309 C -24.433 408.138 -47.695 337.666 -102.913 298.713 A 178.723 178.723 0 0 1 31.919 -23.198 Z"/>
  <path style="fill: rgb(223, 15, 25);" d="M 257.348 -56.343 C 294.681 -56.343 318.015 -99.264 299.348 -133.599 C 280.682 -167.935 234.013 -167.935 215.347 -133.599 C 210.739 -125.125 208.501 -115.432 208.893 -105.656 C 212.768 -9.251 262.098 78.599 340.123 128.046 C 452.188 199.064 594.62 114.62 596.503 -23.955 C 596.64 -34.078 595.974 -44.196 594.511 -54.2 C 575.136 -192.145 422.412 -256.087 319.607 -169.297 C 286.326 -141.199 264.123 -100.917 257.348 -56.343 Z"/>
  <path style="fill: rgb(40, 100, 115);" d="M 505.404 282.869 C 626.434 282.869 702.075 413.059 641.562 517.21 C 626.865 542.504 605.327 563.198 579.391 576.944 C 495.389 621.465 394.386 558.932 397.584 464.382 C 398.033 451.119 400.641 438.016 405.306 425.582 C 426.147 370.028 378.652 312.887 319.814 322.73 C 317.831 323.061 315.862 323.469 313.91 323.953 C 258.608 337.664 209.106 286.744 224.807 232.297 C 240.51 177.849 309.639 160.71 349.24 201.447 C 352.264 204.556 355.005 207.925 357.432 211.513 C 390.201 260.07 446.741 287.335 505.404 282.869 Z"/>
</svg>
''';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      fit: StackFit.expand,
      children: [
        Positioned.fill(child: SvgPicture.string(svgString, fit: BoxFit.fill)),
        Container(
          transform: Matrix4.translationValues(0.0, 400.0, 0.0),
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.circular(20)),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Image.asset(
                'assets/images/logo.png',
                cacheWidth: 200,
              ),
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
