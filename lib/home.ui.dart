import 'package:flutter/material.dart';
import 'package:flutter_amiibo_responsive/client/amiibo.client.dart';
import 'package:flutter_amiibo_responsive/detail_page.ui.dart';
import 'package:flutter_amiibo_responsive/model/amiibo.model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';

class HomePageUI extends StatefulWidget {
  HomePageUI({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageUIState createState() => _HomePageUIState();
}

class _HomePageUIState extends State<HomePageUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: GoogleFonts.nunito(fontSize: 24),
        ),
      ),
      body: FutureBuilder(
        future: AmiiboClient(Client()).getAmiiboList(),
        builder: (_, AsyncSnapshot<List<AmiiboModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return _setAmiiboList(snapshot.data);
            } else if (snapshot.hasError) {
              return _setErrorText((snapshot.error as dynamic).message);
            }
          }

          return Container();
        },
      ),
    );
  }

  Widget _setErrorText(String error) {
    return Center(
      child: Text(
        error ?? 'Error',
        style: GoogleFonts.nunito(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _setAmiiboList(List<AmiiboModel> amiibos) {
    return GridView.extent(
      maxCrossAxisExtent: 200,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      padding: const EdgeInsets.all(8),
      childAspectRatio: 1 / 1.2,
      children: amiibos.map((amiibo) => _GridItem(amiibo: amiibo)).toList(),
    );
  }
}

class _GridItem extends StatelessWidget {
  const _GridItem({Key key, @required this.amiibo}) : super(key: key);

  final AmiiboModel amiibo;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => DetailPage(amiibo: amiibo)),
          );
        },
        child: GridTile(
          child: Hero(
            tag: '${amiibo.head}_${amiibo.tail}',
            child: Image.network(
              amiibo.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
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
        ),
      ),
    );
  }
}
