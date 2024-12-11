import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

final class VerticalIconButton extends StatelessWidget {
  const VerticalIconButton({
    required this.icon,
    required this.text,
    super.key,
    this.color = Colors.black,
    this.onTap,
  });

  final IconData icon;
  final String text;
  final Color color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon, color: color),
            const Gap(5),
            Text(
              text.toUpperCase(),
              style: TextStyle(fontSize: 10, color: color),
            ),
          ],
        ),
      ),
    );
  }
}
