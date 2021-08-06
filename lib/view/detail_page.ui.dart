import 'package:flutter/material.dart';
import 'package:flutter_amiibo_responsive/model/amiibo.model.dart';
import 'package:flutter_amiibo_responsive/utils/utilities.dart';
import 'package:flutter_amiibo_responsive/view/widgets/vertical_icon_button.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key, required this.amiibo}) : super(key: key);

  final AmiiboModel amiibo;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(amiibo.name, style: const TextStyle(fontSize: 24)),
      ),
      body: OrientationBuilder(
        builder: (_, orientation) {
          return (size.width >= 600 || orientation == Orientation.landscape)
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
                );
        },
      ),
    );
  }

  Widget _setImage() {
    return Hero(
      tag: '${amiibo.head}_${amiibo.tail}',
      child: Image.network(amiibo.imageUrl, height: 350, fit: BoxFit.cover),
    );
  }

  Widget _setButtonSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: const <Widget>[
        VerticalIconButton(
          icon: Icons.shopping_bag,
          text: 'Buy article',
          color: Colors.blueGrey,
        ),
        VerticalIconButton(
          icon: Icons.favorite,
          text: 'Add favorite',
          color: Colors.blueGrey,
        ),
        VerticalIconButton(
          icon: Icons.share,
          text: 'Share to...',
          color: Colors.blueGrey,
        ),
      ],
    );
  }

  Widget _setTitleSection() {
    return Padding(
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
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  amiibo.amiiboSeries,
                  style: TextStyle(color: Colors.grey[500]),
                )
              ],
            ),
          ),
          Icon(Icons.art_track, color: Colors.blueGrey[500]),
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Text(
              amiibo.type,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }

  Widget _setDescriptionSection() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Text(
        Utilities.setLoremText(),
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
