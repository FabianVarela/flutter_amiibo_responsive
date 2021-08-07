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
        backgroundColor: Colors.redAccent,
      ),
      body: OrientationBuilder(
        builder: (_, orientation) {
          return (size.width >= 600 || orientation == Orientation.landscape)
              ? SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            _AmiiboImage(
                              tagId: '${amiibo.head}_${amiibo.tail}',
                              imageUrl: amiibo.imageUrl,
                            ),
                            _AmiiboDetail(
                              name: amiibo.name,
                              series: amiibo.amiiboSeries,
                              type: amiibo.type,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: const <Widget>[
                            _AmiiboButtons(),
                            _AmiiboDescription(),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : ListView(
                  children: <Widget>[
                    _AmiiboImage(
                      tagId: '${amiibo.head}_${amiibo.tail}',
                      imageUrl: amiibo.imageUrl,
                    ),
                    _AmiiboDetail(
                      name: amiibo.name,
                      series: amiibo.amiiboSeries,
                      type: amiibo.type,
                    ),
                    const _AmiiboButtons(),
                    const _AmiiboDescription(),
                  ],
                );
        },
      ),
    );
  }
}

class _AmiiboImage extends StatelessWidget {
  const _AmiiboImage({Key? key, required this.tagId, required this.imageUrl})
      : super(key: key);

  final String tagId;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tagId,
      child: Image.network(imageUrl, height: 350, fit: BoxFit.cover),
    );
  }
}

class _AmiiboDetail extends StatelessWidget {
  const _AmiiboDetail({
    Key? key,
    required this.name,
    required this.series,
    required this.type,
  }) : super(key: key);

  final String name;
  final String series;
  final String type;

  @override
  Widget build(BuildContext context) {
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
                    name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Text(series, style: TextStyle(color: Colors.grey[500])),
              ],
            ),
          ),
          Icon(Icons.art_track, color: Colors.blueGrey[500]),
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Text(
              type,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

class _AmiiboButtons extends StatelessWidget {
  const _AmiiboButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: const <Widget>[
        VerticalIconButton(
          icon: Icons.shopping_bag,
          text: 'Buy article',
          color: Colors.green,
        ),
        VerticalIconButton(
          icon: Icons.favorite,
          text: 'Add favorite',
          color: Colors.green,
        ),
        VerticalIconButton(
          icon: Icons.share,
          text: 'Share to...',
          color: Colors.green,
        ),
      ],
    );
  }
}

class _AmiiboDescription extends StatelessWidget {
  const _AmiiboDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Text(
        Utilities.setLoremText(),
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
