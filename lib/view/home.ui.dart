import 'package:flutter/material.dart';
import 'package:flutter_amiibo_responsive/client/amiibo.client.dart';
import 'package:flutter_amiibo_responsive/model/amiibo.model.dart';
import 'package:flutter_amiibo_responsive/view/detail_page.ui.dart';
import 'package:flutter_amiibo_responsive/view/widgets/grid_item.dart';
import 'package:flutter_amiibo_responsive/view/widgets/shimmer_grid_loading.dart';
import 'package:http/http.dart';

class HomePageUI extends StatefulWidget {
  const HomePageUI({Key? key}) : super(key: key);

  @override
  _HomePageUIState createState() => _HomePageUIState();
}

class _HomePageUIState extends State<HomePageUI> {
  late String? _type;

  @override
  void initState() {
    _type = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (MediaQuery.of(context).size.width >= 840)
        ? Scaffold(
            appBar: AppBar(
              title: const Text('Amiibo App', style: TextStyle(fontSize: 24)),
            ),
            body: Row(
              children: <Widget>[
                Expanded(flex: 2, child: _setDrawerBody()),
                Expanded(flex: 5, child: _setFutureList()),
              ],
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: const Text('Amiibo App', style: TextStyle(fontSize: 24)),
            ),
            drawer: Drawer(child: _setDrawerBody()),
            body: _setFutureList(),
          );
  }

  Widget _setDrawerBody() {
    return ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          decoration: const BoxDecoration(color: Colors.blueGrey),
          child: Container(
            alignment: AlignmentDirectional.bottomStart,
            child: const Text(
              'Amiibo App',
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
          ),
        ),
        _menuItem(Icons.list, 'All', _setType),
        _menuItem(Icons.account_box, 'Figure', () => _setType('figure')),
        _menuItem(Icons.card_membership, 'Card', () => _setType('card')),
        _menuItem(Icons.wallpaper, 'Yarn', () => _setType('yarn')),
      ],
    );
  }

  Widget _menuItem(IconData icon, String text, VoidCallback onPress) {
    return ListTile(
      onTap: onPress,
      leading: Icon(icon),
      title: Text(
        text,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
      ),
    );
  }

  Widget _setFutureList() {
    return FutureBuilder(
      future: AmiiboClient(Client()).getAmiiboList(_type),
      builder: (_, AsyncSnapshot<List<AmiiboModel>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const ShimmerGridLoading();
        }

        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return _setAmiiboList(snapshot.data!);
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

        return Container();
      },
    );
  }

  Widget _setAmiiboList(List<AmiiboModel> amiibos) {
    final size = MediaQuery.of(context).size;

    return GridView.extent(
      maxCrossAxisExtent: size.width >= 600 ? 300 : 200,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      padding: const EdgeInsets.all(8),
      childAspectRatio: 1 / 1.2,
      children: <Widget>[
        for (var i = 0; i < amiibos.length; i++)
          GridItem(
            amiibo: amiibos[i],
            onSelectAmiibo: () => _goToDetail(amiibos[i]),
          )
      ],
    );
  }

  Future<void> _goToDetail(AmiiboModel amiibo) => Navigator.push<void>(
      context, MaterialPageRoute(builder: (_) => DetailPage(amiibo: amiibo)));

  void _setType([String? type]) => setState(() => _type = type);
}
