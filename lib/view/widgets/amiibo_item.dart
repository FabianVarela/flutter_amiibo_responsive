import 'package:flutter/material.dart';
import 'package:flutter_amiibo_responsive/model/amiibo.model.dart';
import 'package:google_fonts/google_fonts.dart';

class AmiiboItem extends StatelessWidget {
  const AmiiboItem({
    Key? key,
    required this.amiibo,
    required this.onSelectAmiibo,
  }) : super(key: key);

  final AmiiboModel amiibo;
  final VoidCallback onSelectAmiibo;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      child: InkWell(
        onTap: onSelectAmiibo,
        child: GridTile(
          footer: GridTileBar(
            backgroundColor: Colors.black45,
            title: Text(
              amiibo.name,
              style: GoogleFonts.nunito(fontSize: 16),
            ),
            subtitle: Text(
              amiibo.gameSeries,
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
