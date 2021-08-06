import 'package:flutter/material.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({
    Key? key,
    required this.onTapAll,
    required this.onTapFigure,
    required this.onTapCard,
    required this.onTapYarn,
    required this.onTapBand,
  }) : super(key: key);

  final VoidCallback onTapAll;
  final VoidCallback onTapFigure;
  final VoidCallback onTapCard;
  final VoidCallback onTapYarn;
  final VoidCallback onTapBand;

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
        fontSize: 16, fontWeight: FontWeight.w300, color: Colors.green);

    return ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          decoration: const BoxDecoration(color: Colors.redAccent),
          child: Container(
            alignment: AlignmentDirectional.bottomStart,
            child: const Text(
              'Amiibo App',
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
          ),
        ),
        ListTile(
          onTap: onTapAll,
          leading: const Icon(Icons.list, color: Colors.green),
          title: const Text('All', style: textStyle),
        ),
        ListTile(
          onTap: onTapFigure,
          leading: const Icon(Icons.account_box, color: Colors.green),
          title: const Text('Figure', style: textStyle),
        ),
        ListTile(
          onTap: onTapCard,
          leading: const Icon(Icons.card_membership, color: Colors.green),
          title: const Text('Card', style: textStyle),
        ),
        ListTile(
          onTap: onTapYarn,
          leading: const Icon(Icons.wallpaper, color: Colors.green),
          title: const Text('Yarn', style: textStyle),
        ),
        ListTile(
          onTap: onTapBand,
          leading: const Icon(Icons.watch, color: Colors.green),
          title: const Text('Band', style: textStyle),
        ),
      ],
    );
  }
}
