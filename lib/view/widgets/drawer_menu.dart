import 'package:flutter/material.dart';
import 'package:flutter_amiibo_responsive/utils/enum.dart';

typedef AmiiboDrawerItem = (AmiiboType?, String, IconData);

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({
    required this.onSelect,
    this.makePop = true,
    super.key,
  });

  final ValueSetter<String?> onSelect;
  final bool makePop;

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w300,
      color: Colors.green,
    );

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
        ...AmiiboType.values.map((type) {
          return ListTile(
            onTap: () {
              onSelect(type.value);
              if (makePop) Navigator.of(context).pop();
            },
            leading: Icon(type.icon, color: Colors.green),
            title: Text(type.text, style: textStyle),
          );
        }),
      ],
    );
  }
}
