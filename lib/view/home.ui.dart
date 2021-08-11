import 'package:flutter/material.dart';
import 'package:flutter_amiibo_responsive/client/amiibo.client.dart';
import 'package:flutter_amiibo_responsive/model/amiibo.model.dart';
import 'package:flutter_amiibo_responsive/view/widgets/amiibo_item.dart';
import 'package:flutter_amiibo_responsive/view/widgets/drawer_menu.dart';
import 'package:flutter_amiibo_responsive/view/widgets/shimmer_grid_loading.dart';
import 'package:http/http.dart';

class HomePageUI extends StatefulWidget {
  const HomePageUI({Key? key, required this.onGoToDetail}) : super(key: key);

  final ValueSetter<AmiiboModel> onGoToDetail;

  @override
  _HomePageUIState createState() => _HomePageUIState();
}

class _HomePageUIState extends State<HomePageUI> {
  late String? _type;

  @override
  void initState() {
    super.initState();
    _type = null;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Amiibo App', style: TextStyle(fontSize: 24)),
        backgroundColor: Colors.redAccent,
      ),
      drawer: size.width >= 840
          ? null
          : Drawer(
              child: DrawerMenu(
                onTapAll: () {
                  _popDrawer(context);
                  _setType();
                },
                onTapFigure: () {
                  _popDrawer(context);
                  _setType('figure');
                },
                onTapCard: () {
                  _popDrawer(context);
                  _setType('card');
                },
                onTapYarn: () {
                  _popDrawer(context);
                  _setType('yarn');
                },
                onTapBand: () {
                  _popDrawer(context);
                  _setType('band');
                },
              ),
            ),
      body: OrientationBuilder(
        builder: (_, orientation) {
          return (orientation == Orientation.landscape || size.width >= 840)
              ? Row(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: DrawerMenu(
                        onTapAll: _setType,
                        onTapFigure: () => _setType('figure'),
                        onTapCard: () => _setType('card'),
                        onTapYarn: () => _setType('yarn'),
                        onTapBand: () => _setType('band'),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: _AmiiboList(
                        type: _type,
                        onTapAmiibo: widget.onGoToDetail,
                      ),
                    ),
                  ],
                )
              : _AmiiboList(type: _type, onTapAmiibo: widget.onGoToDetail);
        },
      ),
    );
  }

  void _popDrawer(BuildContext context) => Navigator.of(context).pop();

  void _setType([String? type]) => setState(() => _type = type);
}

class _AmiiboList extends StatelessWidget {
  const _AmiiboList({Key? key, required this.type, required this.onTapAmiibo})
      : super(key: key);

  final String? type;
  final ValueSetter<AmiiboModel> onTapAmiibo;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return FutureBuilder(
      future: AmiiboClient(Client()).getAmiiboList(type),
      builder: (_, AsyncSnapshot<List<AmiiboModel>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const ShimmerGridLoading();
        }

        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            final amiiboList = snapshot.data!;

            return GridView.extent(
              maxCrossAxisExtent: size.width >= 600 ? 300 : 200,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              padding: const EdgeInsets.all(8),
              childAspectRatio: 1 / 1.2,
              children: <Widget>[
                for (var i = 0; i < amiiboList.length; i++)
                  AmiiboItem(
                    amiibo: amiiboList[i],
                    onSelectAmiibo: () => onTapAmiibo(amiiboList[i]),
                  )
              ],
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text(
                'Error to get data',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            );
          }
        }

        return const Offstage();
      },
    );
  }
}
