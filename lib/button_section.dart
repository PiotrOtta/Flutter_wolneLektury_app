import 'package:flutter/material.dart';

class ButtonSection extends StatelessWidget {
  const ButtonSection({super.key});

  @override
  Widget build(BuildContext context) {
    // final Color color = Theme.of(context).primaryColor;
    const Color color = Colors.black;
    return SizedBox(
        width: 280,
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.white,
              border:
                  Border.all(color: const Color.fromARGB(255, 244, 244, 244)),
              borderRadius: const BorderRadius.all(Radius.circular(12))),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ButtonWithText(
                color: color,
                icon: Icons.home,
                // label: 'Wróć do listy',
              ),
              ButtonWithText(
                color: color,
                icon: Icons.search,
                // label: 'ROUTE',
              ),
              ButtonWithText(
                color: color,
                icon: Icons.favorite,
                // label: 'Like',
              ),
            ],
          ),
        ));
  }
}

class ButtonWithText extends StatelessWidget {
  const ButtonWithText({
    super.key,
    required this.color,
    required this.icon,
    this.label,
  });

  final Color color;
  final IconData icon;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:
            const EdgeInsets.only(bottom: 14, left: 22, right: 22, top: 14),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(icon, color: color),
            (label?.isNotEmpty ?? false)
                ? Text(
                    label!,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: color,
                    ),
                  )
                : Container(),
          ],
        ));
  }
}
