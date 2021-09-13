import 'package:flutter/material.dart';
import 'package:flutter_amiibo_responsive/bloc/amiibo_item/amiibo_item_cubit.dart';
import 'package:flutter_amiibo_responsive/bloc/amiibo_item/amiibo_item_state.dart';
import 'package:flutter_amiibo_responsive/utils/utilities.dart';
import 'package:flutter_amiibo_responsive/view/widgets/vertical_icon_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailPageUI extends StatefulWidget {
  const DetailPageUI({Key? key, this.type, required this.amiiboId})
      : super(key: key);

  final String? type;
  final String amiiboId;

  @override
  _DetailPageUIState createState() => _DetailPageUIState();
}

class _DetailPageUIState extends State<DetailPageUI> {
  @override
  void initState() {
    super.initState();
    context
        .read<AmiiboItemCubit>()
        .fetchAmiiboItem(widget.type, widget.amiiboId);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return BlocBuilder<AmiiboItemCubit, AmiiboItemState>(
      builder: (_, state) {
        return state.when(
          initial: () {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.redAccent,
                title: const Text('Loading', style: TextStyle(fontSize: 24)),
              ),
              body: const Center(
                child: CircularProgressIndicator(color: Colors.redAccent),
              ),
            );
          },
          success: (item) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.redAccent,
                title: Text(item.name, style: const TextStyle(fontSize: 24)),
              ),
              body: OrientationBuilder(
                builder: (_, orientation) {
                  return (width >= 600 || orientation == Orientation.landscape)
                      ? SingleChildScrollView(
                          padding: const EdgeInsets.all(24),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    _AmiiboImage(
                                      tagId: '${item.head}_${item.tail}',
                                      imageUrl: item.imageUrl,
                                    ),
                                    _AmiiboDetail(
                                      name: item.name,
                                      series: item.amiiboSeries,
                                      type: item.type,
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
                              tagId: '${item.head}_${item.tail}',
                              imageUrl: item.imageUrl,
                            ),
                            _AmiiboDetail(
                              name: item.name,
                              series: item.amiiboSeries,
                              type: item.type,
                            ),
                            const _AmiiboButtons(),
                            const _AmiiboDescription(),
                          ],
                        );
                },
              ),
            );
          },
          error: () {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.redAccent,
                title: const Text('Error', style: TextStyle(fontSize: 24)),
              ),
              body: const Center(
                child: Text(
                  'Error to get data',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            );
          },
        );
      },
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
