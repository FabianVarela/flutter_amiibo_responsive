import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_amiibo_responsive/bloc/amiibo_item/amiibo_item_cubit.dart';
import 'package:flutter_amiibo_responsive/model/amiibo_model.dart';
import 'package:flutter_amiibo_responsive/repository/amiibo_repository.dart';
import 'package:flutter_amiibo_responsive/utils/adaptive_contextual_layout.dart';
import 'package:flutter_amiibo_responsive/view/widgets/vertical_icon_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

final class DetailPage extends StatelessWidget {
  const DetailPage({required this.amiiboId, super.key, this.type});

  final String? type;
  final String amiiboId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AmiiboItemCubit(context.read<AmiiboRepository>()),
      child: DetailView(type: type, amiiboId: amiiboId),
    );
  }
}

final class DetailView extends HookWidget {
  const DetailView({required this.amiiboId, super.key, this.type});

  final String? type;
  final String amiiboId;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDesktopOrTablet = [
      ScreenType.desktop,
      ScreenType.tablet,
    ].contains(context.formFactor);

    useEffect(() {
      unawaited(
        context.read<AmiiboItemCubit>().fetchAmiiboItem(type, amiiboId),
      );
      return null;
    }, const []);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.primaryContainer,
        title: Builder(
          builder: (builderContext) {
            return Text(
              builderContext.select(
                (AmiiboItemCubit value) => switch (value.state) {
                  AmiiboItemStateInitial() => 'Loading',
                  AmiiboItemStateSuccess(:final amiiboItem) => amiiboItem.name,
                  AmiiboItemStateError() => 'Error',
                },
              ),
              style: const TextStyle(fontSize: 24),
            );
          },
        ),
      ),
      body: BlocBuilder<AmiiboItemCubit, AmiiboItemState>(
        builder: (_, state) {
          if (state is AmiiboItemStateSuccess) {
            return SingleChildScrollView(
              padding: isDesktopOrTablet
                  ? const .symmetric(vertical: 24, horizontal: 16)
                  : null,
              child: isDesktopOrTablet
                  ? Row(
                      crossAxisAlignment: .start,
                      children: <Widget>[
                        Expanded(child: _AmiiboDetail(item: state.amiiboItem)),
                        const Expanded(
                          child: Column(
                            children: <Widget>[
                              _AmiiboButtons(),
                              _AmiiboDescription(),
                            ],
                          ),
                        ),
                      ],
                    )
                  : Column(
                      children: <Widget>[
                        _AmiiboDetail(item: state.amiiboItem),
                        const _AmiiboButtons(),
                        const _AmiiboDescription(),
                      ],
                    ),
            );
          }

          if (state is AmiiboItemStateError) {
            return const Center(
              child: Text(
                'Error to get data',
                style: TextStyle(fontSize: 30, fontWeight: .bold),
              ),
            );
          }

          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(colorScheme.primaryContainer),
            ),
          );
        },
      ),
    );
  }
}

final class _AmiiboDetail extends StatelessWidget {
  const _AmiiboDetail({required this.item});

  final AmiiboModel item;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Hero(
          tag: '${item.head}_${item.tail}',
          child: Image.network(item.imageUrl, height: 350, fit: .cover),
        ),
        Padding(
          padding: const .all(24),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: .start,
                  children: <Widget>[
                    Container(
                      padding: const .only(bottom: 8),
                      child: Text(
                        item.name,
                        style: const TextStyle(fontWeight: .bold),
                      ),
                    ),
                    Text(item.amiiboSeries),
                  ],
                ),
              ),
              const Icon(Icons.art_track),
              Padding(
                padding: const .only(left: 4),
                child: Text(
                  item.type,
                  style: const TextStyle(fontSize: 14, fontWeight: .bold),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

final class _AmiiboButtons extends StatelessWidget {
  const _AmiiboButtons();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final iconButtonList = <({IconData icon, String text})>[
      (icon: Icons.shopping_bag, text: 'Buy article'),
      (icon: Icons.favorite, text: 'Add favorite'),
      (icon: Icons.share, text: 'Share to...'),
    ];

    return Row(
      mainAxisAlignment: .spaceEvenly,
      children: iconButtonList.map((item) {
        return VerticalIconButton(
          icon: item.icon,
          text: item.text,
          color: colorScheme.onTertiaryContainer,
        );
      }).toList(),
    );
  }
}

final class _AmiiboDescription extends StatelessWidget {
  const _AmiiboDescription();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const .all(24),
      child: Text(_setLoremText, style: const TextStyle(fontSize: 16)),
    );
  }

  String get _setLoremText =>
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus vitae '
      'arcu ac erat consectetur imperdiet rutrum sed ex. Morbi orci justo, '
      'tincidunt ac vehicula a, sagittis sit amet sapien. '
      'Cras consectetur nisi quis ligula molestie, vel ullamcorper massa '
      'sollicitudin. In molestie a nulla ut malesuada. Quisque rhoncus '
      'suscipit justo, in auctor metus interdum quis. Duis sodales cursus '
      'tortor, eu mattis eros rhoncus ut. Donec sagittis ex non pulvinar '
      'auctor. Pellentesque et sollicitudin mi. Quisque eget efficitur '
      'libero, porta vestibulum leo. Phasellus justo risus, commodo '
      'non viverra eget, mattis ac lacus. Etiam eget finibus erat. '
      'Sed et placerat ipsum.';
}
