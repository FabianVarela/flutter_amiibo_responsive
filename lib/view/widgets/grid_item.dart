import 'package:flutter/material.dart';
import 'package:flutter_amiibo_responsive/model/amiibo.model.dart';
import 'package:flutter_amiibo_responsive/view/detail_page.ui.dart';
import 'package:google_fonts/google_fonts.dart';

class GridItem extends StatelessWidget {
  const GridItem({Key? key, required this.amiibo}) : super(key: key);

  final AmiiboModel amiibo;

  @override
  Widget build(BuildContext context) => Card(
    clipBehavior: Clip.antiAlias,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(6),
    ),
    child: InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => DetailPage(amiibo: amiibo)),
        );
      },
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
          child: Image.network(
            amiibo.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    ),
  );
}
