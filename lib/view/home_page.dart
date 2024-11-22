import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_amiibo_responsive/bloc/amiibo_list/amiibo_list_cubit.dart';
import 'package:flutter_amiibo_responsive/repository/amiibo_repository.dart';
import 'package:flutter_amiibo_responsive/view/widgets/amiibo_item.dart';
import 'package:flutter_amiibo_responsive/view/widgets/drawer_menu.dart';
import 'package:flutter_amiibo_responsive/view/widgets/shimmer_grid_loading.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    required this.onChange,
    required this.onGoToDetail,
    super.key,
    this.type,
  });

  final String? type;
  final ValueSetter<String?> onChange;
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

class HomePageView extends HookWidget {
  const HomePageView({
    required this.onChange,
    required this.onGoToDetail,
    super.key,
    this.type,
  });

  final String? type;
  final ValueSetter<String?> onChange;
  final ValueSetter<String> onGoToDetail;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    useEffect(
      () {
        context.read<AmiiboListCubit>().fetchAmiiboData(type);
        return null;
      },
      const [],
    );

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
                  child: DrawerMenu(onSelect: onChange),
                ),
          body: orientation == Orientation.landscape && width >= 800
              ? Row(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: DrawerMenu(onSelect: onChange, makePop: false),
                    ),
                    Expanded(
                      flex: 5,
                      child: _AmiiboList(onTapAmiibo: onGoToDetail),
                    ),
                  ],
                )
              : _AmiiboList(onTapAmiibo: onGoToDetail),
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
    final width = MediaQuery.sizeOf(context).width;

    return BlocBuilder<AmiiboListCubit, AmiiboListState>(
      builder: (_, state) {
        return switch (state) {
          AmiiboListStateInitial() => const ShimmerGridLoading(),
          AmiiboListStateSuccess(:final amiiboList) when amiiboList.isEmpty =>
            const Center(
              child: Text(
                'No data found',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          AmiiboListStateSuccess(:final amiiboList) => GridView.extent(
              maxCrossAxisExtent: width >= 600 ? 300 : 200,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              padding: const EdgeInsets.all(8),
              childAspectRatio: 1 / 1.2,
              children: amiiboList.mapIndexed((index, item) {
                final internalId = '${item.head}${item.tail}';
                return AmiiboItem(
                  key: ValueKey('$index'),
                  amiibo: item,
                  onSelectAmiibo: () => onTapAmiibo(internalId),
                );
              }).toList(),
            ),
          AmiiboListStateError() => const Center(
              child: Text(
                'Error to get data',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
        };
      },
    );
  }
}
