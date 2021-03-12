import 'package:flutter/material.dart';
import 'package:flutter_amiibo_responsive/client/amiibo.client.dart';
import 'package:flutter_amiibo_responsive/view/detail_page.ui.dart';
import 'package:flutter_amiibo_responsive/model/amiibo.model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';

class HomePageUI extends StatefulWidget {
  HomePageUI({Key? key, required this.title}) : super(key: key);

  final String title;

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
              appBar: _setAppBar(),
              body: Row(
                children: <Widget>[
                  Expanded(flex: 2, child: _setDrawerBody()),
                  Expanded(flex: 5, child: _setFutureList()),
                ],
              ),
            )
          : Scaffold(
              appBar: _setAppBar(),
              drawer: Drawer(child: _setDrawerBody()),
              body: _setFutureList(),
            );

  PreferredSizeWidget? _setAppBar() => AppBar(
        title: Text(
          widget.title,
          style: GoogleFonts.nunito(fontSize: 24),
        ),
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
              style: GoogleFonts.nunito(
                fontSize: 24,
                color: Colors.white,
              ),
            ),
          ),
        ),
        _menuItem(Icons.list, 'All', () => _setType()),
        _menuItem(Icons.account_box, 'Figure', () => _setType(type: 'figure')),
        _menuItem(Icons.card_membership, 'Card', () => _setType(type: 'card')),
        _menuItem(Icons.wallpaper, 'Yarn', () => _setType(type: 'yarn')),
      ],
    );
  }

  Widget _menuItem(IconData icon, String text, void Function() onPress) =>
      ListTile(
        onTap: onPress,
        leading: Icon(icon),
        title: Text(
          text,
          style: GoogleFonts.nunito(
            fontSize: 16,
            fontWeight: FontWeight.w300,
          ),
        ),
      );

  Widget _setFutureList() => FutureBuilder(
        future: AmiiboClient(Client()).getAmiiboList(_type),
        builder: (_, AsyncSnapshot<List<AmiiboModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
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
          style: GoogleFonts.nunito(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      );

  Widget _setAmiiboList(List<AmiiboModel> amiibos) => GridView.extent(
        maxCrossAxisExtent:
            MediaQuery.of(context).size.width >= 600 ? 300 : 200,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        padding: const EdgeInsets.all(8),
        childAspectRatio: 1 / 1.2,
        children: amiibos.map((amiibo) => _GridItem(amiibo: amiibo)).toList(),
      );

  void _setType({String? type}) => setState(() => _type = type);
}

class _GridItem extends StatelessWidget {
  const _GridItem({Key? key, required this.amiibo}) : super(key: key);

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
