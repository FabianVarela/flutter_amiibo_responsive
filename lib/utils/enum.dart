import 'package:material_ui/material_ui.dart';

enum AmiiboType {
  all(null, 'All', Icons.list),
  figure('figure', 'Figure', Icons.account_box),
  card('card', 'Card', Icons.card_membership),
  yarn('yarn', 'Yarn', Icons.wallpaper),
  band('band', 'Band', Icons.watch);

  new(this.value, this.text, this.icon);

  final String? value;
  final String text;
  final IconData icon;
}
