import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_amiibo_responsive/bloc/amiibo_list/amiibo_list_cubit.dart';
import 'package:flutter_amiibo_responsive/bloc/game_series/game_series_cubit.dart';
import 'package:flutter_amiibo_responsive/repository/amiibo_repository.dart';
import 'package:flutter_amiibo_responsive/utils/adaptive_contextual_layout.dart';
import 'package:flutter_amiibo_responsive/view/widgets/amiibo_item.dart';
import 'package:flutter_amiibo_responsive/view/widgets/drawer_menu.dart';
import 'package:flutter_amiibo_responsive/view/widgets/shimmer_grid_loading.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

final class HomePage extends StatelessWidget {
  const HomePage({
    required this.onChangeType,
    required this.onChangeGameSeries,
    required this.onGoToDetail,
    this.type,
    this.gameSeries,
    super.key,
  });

  final String? type;
  final String? gameSeries;
  final ValueSetter<String?> onChangeType;
  final ValueSetter<String?> onChangeGameSeries;
  final ValueSetter<String> onGoToDetail;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AmiiboListCubit(context.read<AmiiboRepository>()),
        ),
        BlocProvider(
          create: (_) => GameSeriesCubit(context.read<AmiiboRepository>()),
        ),
      ],
      child: HomePageView(
        type: type,
        gameSeries: gameSeries,
        onChangeType: onChangeType,
        onChangeGameSeries: onChangeGameSeries,
        onGoToDetail: onGoToDetail,
      ),
    );
  }
}

final class HomePageView extends HookWidget {
  const HomePageView({
    required this.onChangeType,
    required this.onChangeGameSeries,
    required this.onGoToDetail,
    this.type,
    this.gameSeries,
    super.key,
  });

  final String? type;
  final String? gameSeries;
  final ValueSetter<String?> onChangeType;
  final ValueSetter<String?> onChangeGameSeries;
  final ValueSetter<String> onGoToDetail;

  @override
  Widget build(BuildContext context) {
    final isDesktopOrTablet = [
      ScreenType.desktop,
      ScreenType.tablet,
    ].contains(context.formFactor);

    final selectedType = useState<String?>(type);
    final selectedSeries = useState<String?>(gameSeries);

    useEffect(() {
      unawaited(context.read<GameSeriesCubit>().fetchGameSeries());
      unawaited(
        context.read<AmiiboListCubit>().fetchAmiiboData(
          type: selectedType.value,
          gameSeries: selectedSeries.value,
        ),
      );
      return null;
    }, const []);

    final drawerMenu = DrawerMenu(
      onSelectType: (type) {
        selectedType.value = type;
        _typeChange(context, type, selectedSeries.value);
      },
      onSelectGameSeries: (series) {
        selectedSeries.value = series;
        _seriesChange(context, series, selectedType.value);
      },
      makePop: !isDesktopOrTablet,
      selectedType: selectedType.value,
      selectedGameSeries: selectedSeries.value,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Amiibo App', style: TextStyle(fontSize: 24)),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      drawer: switch (isDesktopOrTablet) {
        false => Drawer(child: drawerMenu),
        _ => null,
      },
      body: switch (isDesktopOrTablet) {
        true => Row(
          children: <Widget>[
            Expanded(flex: 2, child: drawerMenu),
            Expanded(flex: 5, child: _AmiiboList(onTapAmiibo: onGoToDetail)),
          ],
        ),
        _ => _AmiiboList(onTapAmiibo: onGoToDetail),
      },
    );
  }

  void _typeChange(BuildContext context, String? type, String? series) {
    onChangeType(type);
    unawaited(
      context.read<AmiiboListCubit>().fetchAmiiboData(
        type: type,
        gameSeries: series,
      ),
    );
  }

  void _seriesChange(BuildContext context, String? series, String? type) {
    onChangeGameSeries(series);
    unawaited(
      context.read<AmiiboListCubit>().fetchAmiiboData(
        type: type,
        gameSeries: series,
      ),
    );
  }
}

final class _AmiiboList extends StatelessWidget {
  const _AmiiboList({required this.onTapAmiibo});

  final ValueSetter<String> onTapAmiibo;

  @override
  Widget build(BuildContext context) {
    final isDesktopOrTablet = [
      ScreenType.desktop,
      ScreenType.tablet,
    ].contains(context.formFactor);

    return BlocBuilder<AmiiboListCubit, AmiiboListState>(
      builder: (_, state) => switch (state) {
        AmiiboListStateInitial() => const ShimmerGridLoading(),
        AmiiboListStateSuccess(:final amiiboList) when amiiboList.isEmpty =>
          const Center(
            child: Text(
              'No data found',
              style: TextStyle(fontSize: 30, fontWeight: .bold),
            ),
          ),
        AmiiboListStateSuccess(:final amiiboList) => GridView.extent(
          maxCrossAxisExtent: isDesktopOrTablet ? 300 : 200,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: 1 / 1.2,
          padding: const .all(8),
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
            style: TextStyle(fontSize: 30, fontWeight: .bold),
          ),
        ),
      },
    );
  }
}
