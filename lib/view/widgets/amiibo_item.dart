import 'package:flutter/material.dart';
import 'package:flutter_amiibo_responsive/model/amiibo_model.dart';
import 'package:google_fonts/google_fonts.dart';

final class AmiiboItem extends StatelessWidget {
  const AmiiboItem({
    required this.amiibo,
    required this.onSelectAmiibo,
    super.key,
  });

  final AmiiboModel amiibo;
  final VoidCallback onSelectAmiibo;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      child: InkWell(
        onTap: onSelectAmiibo,
        child: GridTile(
          footer: GridTileBar(
            backgroundColor: colorScheme.surfaceContainerHighest.withValues(
              alpha: .6,
            ),
            title: Text(
              amiibo.name,
              style: GoogleFonts.nunito(fontSize: 16),
            ),
            subtitle: Text(
              amiibo.gameSeries ?? 'Sin serie',
              style: GoogleFonts.nunito(fontSize: 14),
            ),
          ),
          child: Hero(
            tag: '${amiibo.head}_${amiibo.tail}',
            child: Image.network(amiibo.imageUrl, fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}
