import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_amiibo_responsive/bloc/amiibo_list/amiibo_list_cubit.dart';
import 'package:flutter_amiibo_responsive/repository/amiibo_repository.dart';
import 'package:flutter_amiibo_responsive/utils/adaptive_contextual_layout.dart';
import 'package:flutter_amiibo_responsive/view/widgets/amiibo_item.dart';
import 'package:flutter_amiibo_responsive/view/widgets/drawer_menu.dart';
import 'package:flutter_amiibo_responsive/view/widgets/shimmer_grid_loading.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

final class HomePage extends StatelessWidget {
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

final class HomePageView extends HookWidget {
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
    final isDesktopOrTablet = [ScreenType.desktop, ScreenType.tablet].contains(
      context.formFactor,
    );

    useEffect(
      () {
        context.read<AmiiboListCubit>().fetchAmiiboData(type);
        return null;
      },
      const [],
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Amiibo App', style: TextStyle(fontSize: 24)),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      drawer: switch (isDesktopOrTablet) {
        false => Drawer(
            child: DrawerMenu(onSelect: onChange),
          ),
        _ => null,
      },
      body: switch (isDesktopOrTablet) {
        true => Row(
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
          ),
        _ => _AmiiboList(onTapAmiibo: onGoToDetail),
      },
    );
  }
}

final class _AmiiboList extends StatelessWidget {
  const _AmiiboList({required this.onTapAmiibo});

  final ValueSetter<String> onTapAmiibo;

  @override
  Widget build(BuildContext context) {
    final isDesktopOrTablet = [ScreenType.desktop, ScreenType.tablet].contains(
      context.formFactor,
    );

    return BlocBuilder<AmiiboListCubit, AmiiboListState>(
      builder: (_, state) {
        return switch (state) {
          AmiiboListStateInitial() => const ShimmerGridLoading(),
          AmiiboListStateSuccess(:final amiiboList) when amiiboList.isEmpty =>
            const Center(
              child: Text(
                'No data found',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
          AmiiboListStateSuccess(:final amiiboList) => GridView.extent(
              maxCrossAxisExtent: isDesktopOrTablet ? 300 : 200,
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
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
        };
      },
    );
  }
}
