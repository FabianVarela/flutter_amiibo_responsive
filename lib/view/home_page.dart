import 'package:flutter/material.dart';
import 'package:flutter_amiibo_responsive/bloc/amiibo_list/amiibo_list_cubit.dart';
import 'package:flutter_amiibo_responsive/bloc/amiibo_list/amiibo_list_state.dart';
import 'package:flutter_amiibo_responsive/repository/amiibo_repository.dart';
import 'package:flutter_amiibo_responsive/utils/enum.dart';
import 'package:flutter_amiibo_responsive/view/widgets/amiibo_item.dart';
import 'package:flutter_amiibo_responsive/view/widgets/drawer_menu.dart';
import 'package:flutter_amiibo_responsive/view/widgets/shimmer_grid_loading.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
    this.type,
    required this.onChange,
    required this.onGoToDetail,
  });

  final String? type;
  final ValueSetter<AmiiboType?> onChange;
  final ValueSetter<String> onGoToDetail;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AmiiboListCubit(context.read<AmiiboRepository>()),
      child: HomePageView(
        type: type,
        onChange: onChange,
        onGoToDetail: onGoToDetail,
      ),
    );
  }
}

class HomePageView extends StatefulWidget {
  const HomePageView({
    super.key,
    this.type,
    required this.onChange,
    required this.onGoToDetail,
  });

  final String? type;
  final ValueSetter<AmiiboType?> onChange;
  final ValueSetter<String> onGoToDetail;

  @override
  HomePageViewState createState() => HomePageViewState();
}

class HomePageViewState extends State<HomePageView> {
  @override
  void initState() {
    super.initState();
    context.read<AmiiboListCubit>().fetchAmiiboData(widget.type);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return OrientationBuilder(
      builder: (_, orientation) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Amiibo App', style: TextStyle(fontSize: 24)),
            backgroundColor: Colors.redAccent,
          ),
          drawer: orientation == Orientation.landscape && width >= 800
              ? null
              : Drawer(
                  child: DrawerMenu(
                    onTapAll: () => widget.onChange(null),
                    onTapFigure: () => widget.onChange(AmiiboType.figure),
                    onTapCard: () => widget.onChange(AmiiboType.card),
                    onTapYarn: () => widget.onChange(AmiiboType.yarn),
                    onTapBand: () => widget.onChange(AmiiboType.band),
                  ),
                ),
          body: orientation == Orientation.landscape && width >= 800
              ? Row(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: DrawerMenu(
                        makePop: false,
                        onTapAll: () => widget.onChange(null),
                        onTapFigure: () => widget.onChange(AmiiboType.figure),
                        onTapCard: () => widget.onChange(AmiiboType.card),
                        onTapYarn: () => widget.onChange(AmiiboType.yarn),
                        onTapBand: () => widget.onChange(AmiiboType.band),
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
      },
    );
  }
}

class _AmiiboList extends StatelessWidget {
  const _AmiiboList({required this.onTapAmiibo});

  final ValueSetter<String> onTapAmiibo;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocBuilder<AmiiboListCubit, AmiiboListState>(
      builder: (_, state) {
        return state.when(
          initial: () => const ShimmerGridLoading(),
          success: (list) {
            if (list.isEmpty) {
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
                for (var i = 0; i < list.length; i++)
                  AmiiboItem(
                    key: ValueKey('$i'),
                    amiibo: list[i],
                    onSelectAmiibo: () =>
                        onTapAmiibo('${list[i].head}${list[i].tail}'),
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
