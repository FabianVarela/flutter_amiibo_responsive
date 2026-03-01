import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_amiibo_responsive/bloc/amiibo_list/amiibo_list_cubit.dart';
import 'package:flutter_amiibo_responsive/bloc/amiibo_series/amiibo_series_cubit.dart';
import 'package:flutter_amiibo_responsive/bloc/game_series/game_series_cubit.dart';
import 'package:flutter_amiibo_responsive/repository/amiibo_repository.dart';
import 'package:flutter_amiibo_responsive/utils/adaptive_contextual_layout.dart';
import 'package:flutter_amiibo_responsive/view/widgets/amiibo_item.dart';
import 'package:flutter_amiibo_responsive/view/widgets/drawer_menu.dart';
import 'package:flutter_amiibo_responsive/view/widgets/filter_chips.dart';
import 'package:flutter_amiibo_responsive/view/widgets/shimmer_grid_loading.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

final class HomePage extends StatelessWidget {
  const HomePage({
    required this.onChangeType,
    required this.onChangeGameSeries,
    required this.onChangeAmiiboSeries,
    required this.onGoToDetail,
    this.type,
    this.gameSeries,
    this.amiiboSeries,
    super.key,
  });

  final String? type;
  final String? gameSeries;
  final String? amiiboSeries;
  final ValueSetter<String?> onChangeType;
  final ValueSetter<String?> onChangeGameSeries;
  final ValueSetter<String?> onChangeAmiiboSeries;
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
        BlocProvider(
          create: (_) => AmiiboSeriesCubit(context.read<AmiiboRepository>()),
        ),
      ],
      child: HomePageView(
        type: type,
        gameSeries: gameSeries,
        amiiboSeries: amiiboSeries,
        onChangeType: onChangeType,
        onChangeGameSeries: onChangeGameSeries,
        onChangeAmiiboSeries: onChangeAmiiboSeries,
        onGoToDetail: onGoToDetail,
      ),
    );
  }
}

final class HomePageView extends HookWidget {
  const HomePageView({
    required this.onChangeType,
    required this.onChangeGameSeries,
    required this.onChangeAmiiboSeries,
    required this.onGoToDetail,
    this.type,
    this.gameSeries,
    this.amiiboSeries,
    super.key,
  });

  final String? type;
  final String? gameSeries;
  final String? amiiboSeries;
  final ValueSetter<String?> onChangeType;
  final ValueSetter<String?> onChangeGameSeries;
  final ValueSetter<String?> onChangeAmiiboSeries;
  final ValueSetter<String> onGoToDetail;

  @override
  Widget build(BuildContext context) {
    final isDesktopOrTablet = [
      ScreenType.desktop,
      ScreenType.tablet,
    ].contains(context.formFactor);

    final selectedType = useState<String?>(type);
    final selectedGameSeries = useState<String?>(gameSeries);
    final selectedAmiiboSeries = useState<String?>(amiiboSeries);

    useEffect(() {
      unawaited(context.read<GameSeriesCubit>().fetchGameSeries());
      unawaited(context.read<AmiiboSeriesCubit>().fetchAmiiboSeries());
      unawaited(
        context.read<AmiiboListCubit>().fetchAmiiboData(
          type: selectedType.value,
          gameSeries: selectedGameSeries.value,
          amiiboSeries: selectedAmiiboSeries.value,
        ),
      );
      return null;
    }, const []);

    final drawerMenu = DrawerMenu(
      onSelectType: (type) {
        selectedType.value = type;
        _fetchAmiiboData(
          context,
          type: type,
          gameSeries: selectedGameSeries.value,
          amiiboSeries: selectedAmiiboSeries.value,
        );
      },
      onSelectGameSeries: (series) {
        selectedGameSeries.value = series;
        _fetchAmiiboData(
          context,
          type: selectedType.value,
          gameSeries: series,
          amiiboSeries: selectedAmiiboSeries.value,
        );
      },
      makePop: !isDesktopOrTablet,
      selectedType: selectedType.value,
      selectedGameSeries: selectedGameSeries.value,
    );

    final mainContent = Column(
      children: <Widget>[
        FilterChipsSection(
          selectedAmiiboSeries: selectedAmiiboSeries.value,
          onSelectAmiiboSeries: (series) {
            selectedAmiiboSeries.value = series;
            onChangeAmiiboSeries(series);
            _fetchAmiiboData(
              context,
              type: selectedType.value,
              gameSeries: selectedGameSeries.value,
              amiiboSeries: series,
            );
          },
        ),
        Expanded(child: _AmiiboList(onTapAmiibo: onGoToDetail)),
      ],
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
            Expanded(flex: 5, child: mainContent),
          ],
        ),
        _ => mainContent,
      },
    );
  }

  void _fetchAmiiboData(
    BuildContext context, {
    String? type,
    String? gameSeries,
    String? amiiboSeries,
  }) {
    onChangeType(type);
    onChangeGameSeries(gameSeries);
    unawaited(
      context.read<AmiiboListCubit>().fetchAmiiboData(
        type: type,
        gameSeries: gameSeries,
        amiiboSeries: amiiboSeries,
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
