import 'package:flutter/material.dart';
import 'package:flutter_amiibo_responsive/model/amiibo.model.dart';
import 'package:flutter_amiibo_responsive/utils/utilities.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key, required this.amiibo}) : super(key: key);

  final AmiiboModel amiibo;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          amiibo.name,
          style: GoogleFonts.nunito(fontSize: 24),
        ),
      ),
      body: OrientationBuilder(
        builder: (_, orientation) =>
            (size.width >= 600 || orientation == Orientation.landscape)
                ? SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                _setImage(),
                                _setTitleSection(),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                _setButtonSection(),
                                _setDescriptionSection(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : ListView(
                    children: <Widget>[
                      _setImage(),
                      _setTitleSection(),
                      _setButtonSection(),
                      _setDescriptionSection(),
                    ],
                  ),
      ),
    );
  }

  Widget _setImage() => Hero(
        tag: '${amiibo.head}_${amiibo.tail}',
        child: Image.network(
          amiibo.imageUrl,
          height: 350,
          fit: BoxFit.cover,
        ),
      );

  Widget _setButtonSection() => Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _setButtonItem(Icons.shopping_bag, 'Buy article', Colors.blueGrey),
            _setButtonItem(Icons.favorite, 'Add favorite', Colors.blueGrey),
            _setButtonItem(Icons.share, 'Share to...', Colors.blueGrey),
          ],
        ),
      );

  Widget _setButtonItem(IconData icon, String text, Color color) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon, color: color),
            Container(
              margin: const EdgeInsets.only(top: 8),
              child: Text(
                text.toUpperCase(),
                style: GoogleFonts.nunito(
                  fontSize: 12,
                  color: color,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _setTitleSection() => Container(
        padding: const EdgeInsets.all(24),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      amiibo.name,
                      style: GoogleFonts.nunito(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    amiibo.amiiboSeries,
                    style: GoogleFonts.nunito(
                      color: Colors.grey[500],
                    ),
                  )
                ],
              ),
            ),
            Icon(
              Icons.art_track,
              color: Colors.blueGrey[500],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Text(
                amiibo.type,
                style: GoogleFonts.nunito(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      );

  Widget _setDescriptionSection() => Padding(
        padding: const EdgeInsets.all(24),
        child: Text(
          Utilities.setLoremText(),
          style: GoogleFonts.nunito(
            fontSize: 16,
          ),
        ),
      );
}
