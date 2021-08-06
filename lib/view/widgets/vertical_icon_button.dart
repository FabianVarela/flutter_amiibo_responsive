import 'package:flutter/material.dart';

class VerticalIconButton extends StatelessWidget {
  const VerticalIconButton({
    Key? key,
    required this.icon,
    required this.text,
    this.color = Colors.black,
    this.onTap,
  }) : super(key: key);

  final IconData icon;
  final String text;
  final Color color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon, color: color),
            Container(
              margin: const EdgeInsets.only(top: 8),
              child: Text(
                text.toUpperCase(),
                style: TextStyle(fontSize: 12, color: color),
              ),
            )
          ],
        ),
      ),
    );
  }
}
