import 'package:flutter/material.dart';
import 'package:flutter_amiibo_responsive/client/amiibo.client.dart';
import 'package:flutter_amiibo_responsive/model/amiibo.model.dart';
import 'package:flutter_amiibo_responsive/view/widgets/grid_item.dart';
import 'package:flutter_amiibo_responsive/view/widgets/loading_list.dart';
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
  Widget build(BuildContext context) =>
      (MediaQuery.of(context).size.width >= 840)
          ? Scaffold(
              appBar: AppBar(
                title: Text('Amiibo App', style: TextStyle(fontSize: 24)),
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
                title: Text('Amiibo App', style: TextStyle(fontSize: 24)),
              ),
              drawer: Drawer(child: _setDrawerBody()),
              body: _setFutureList(),
            );

  Widget _setDrawerBody() {
    return ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          decoration: BoxDecoration(color: Colors.blueGrey),
          child: Container(
            alignment: AlignmentDirectional.bottomStart,
            child: Text(
              'Amiibo App',
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
          ),
        ),
        _menuItem(Icons.list, 'All', () => _setType()),
        _menuItem(Icons.account_box, 'Figure', () => _setType('figure')),
        _menuItem(Icons.card_membership, 'Card', () => _setType('card')),
        _menuItem(Icons.wallpaper, 'Yarn', () => _setType('yarn')),
      ],
    );
  }

  Widget _menuItem(IconData icon, String text, void Function() onPress) =>
      ListTile(
        onTap: onPress,
        leading: Icon(icon),
        title: Text(
          text,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
        ),
      );

  Widget _setFutureList() => FutureBuilder(
        future: AmiiboClient(Client()).getAmiiboList(_type),
        builder: (_, AsyncSnapshot<List<AmiiboModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingList();
          }

          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return _setAmiiboList(snapshot.data!);
            } else if (snapshot.hasError) {
              return _setErrorText((snapshot.error as dynamic).message);
            }
          }

          return Container();
        },
      );

  Widget _setErrorText(String? error) => Center(
        child: Text(
          error ?? 'Error',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      );

  Widget _setAmiiboList(List<AmiiboModel> amiibos) {
    final size = MediaQuery.of(context).size;
    return GridView.extent(
      maxCrossAxisExtent: size.width >= 600 ? 300 : 200,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      padding: const EdgeInsets.all(8),
      childAspectRatio: 1 / 1.2,
      children: <Widget>[
        for (var i = 0; i < amiibos.length; i++) GridItem(amiibo: amiibos[i])
      ],
    );
  }

  void _setType([String? type]) => setState(() => _type = type);
}
