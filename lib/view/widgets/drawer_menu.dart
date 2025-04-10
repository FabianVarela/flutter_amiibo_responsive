import 'package:flutter/material.dart';
import 'package:flutter_amiibo_responsive/utils/enum.dart';

typedef AmiiboDrawerItem = (AmiiboType?, String, IconData);

final class DrawerMenu extends StatelessWidget {
  const DrawerMenu({required this.onSelect, this.makePop = true, super.key});

  final ValueSetter<String?> onSelect;
  final bool makePop;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          decoration: BoxDecoration(color: colorScheme.primaryContainer),
          child: Container(
            alignment: AlignmentDirectional.bottomStart,
            child: const Text('Amiibo App', style: TextStyle(fontSize: 24)),
          ),
        ),
        ...AmiiboType.values.map((type) {
          return ListTile(
            onTap: () {
              onSelect(type.value);
              if (makePop) Navigator.of(context).pop();
            },
            leading: Icon(type.icon, color: colorScheme.onTertiaryContainer),
            title: Text(
              type.text,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w300,
                color: colorScheme.onTertiaryContainer,
              ),
            ),
          );
        }),
      ],
    );
  }
}
