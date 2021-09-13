import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_amiibo_responsive/bloc/amiibo_list/amiibo_list_cubit.dart';
import 'package:flutter_amiibo_responsive/bloc/amiibo_list/amiibo_list_state.dart';
import 'package:flutter_amiibo_responsive/utils/utilities.dart';
import 'package:flutter_amiibo_responsive/view/widgets/amiibo_item.dart';
import 'package:flutter_amiibo_responsive/view/widgets/drawer_menu.dart';
import 'package:flutter_amiibo_responsive/view/widgets/shimmer_grid_loading.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageUI extends StatefulWidget {
  const HomePageUI({
    Key? key,
    this.type,
    required this.onChangeType,
    required this.onGoToDetail,
  }) : super(key: key);

  final String? type;
  final ValueSetter<String?> onChangeType;
  final ValueSetter<String> onGoToDetail;

  @override
  _HomePageUIState createState() => _HomePageUIState();
}

class _HomePageUIState extends State<HomePageUI> {
  @override
  void initState() {
    super.initState();
    context.read<AmiiboListCubit>().fetchAmiiboData(widget.type);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return OrientationBuilder(builder: (_, orientation) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Amiibo App', style: TextStyle(fontSize: 24)),
          backgroundColor: Colors.redAccent,
        ),
        drawer: orientation == Orientation.landscape && width >= 800
            ? null
            : Drawer(
                child: DrawerMenu(
                  onTapAll: () => widget.onChangeType(null),
                  onTapFigure: () => widget.onChangeType(Utilities.types[0]),
                  onTapCard: () => widget.onChangeType(Utilities.types[1]),
                  onTapYarn: () => widget.onChangeType(Utilities.types[2]),
                  onTapBand: () => widget.onChangeType(Utilities.types[3]),
                ),
              ),
        body: orientation == Orientation.landscape && width >= 800
            ? Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: DrawerMenu(
                      makePop: false,
                      onTapAll: () => widget.onChangeType(null),
                      onTapFigure: () => widget.onChangeType(
                        Utilities.types[0],
                      ),
                      onTapCard: () => widget.onChangeType(Utilities.types[1]),
                      onTapYarn: () => widget.onChangeType(Utilities.types[2]),
                      onTapBand: () => widget.onChangeType(Utilities.types[3]),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: _AmiiboList(onTapAmiibo: widget.onGoToDetail),
                  ),
                ],
              )
            : _AmiiboList(onTapAmiibo: widget.onGoToDetail),
      );
    });
  }
}

class _AmiiboList extends StatelessWidget {
  const _AmiiboList({Key? key, required this.onTapAmiibo}) : super(key: key);

  final ValueSetter<String> onTapAmiibo;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocBuilder<AmiiboListCubit, AmiiboListState>(
      builder: (_, state) {
        return state.when(
          initial: () => const ShimmerGridLoading(),
          success: (amiiboList) {
            if (amiiboList.isEmpty) {
              return const Center(
                child: Text(
                  'No data found',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              );
            }

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
                    onSelectAmiibo: () => onTapAmiibo(
                        '${amiiboList[i].head}${amiiboList[i].tail}'),
                  )
              ],
            );
          },
          error: () => const Center(
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
  }
}
