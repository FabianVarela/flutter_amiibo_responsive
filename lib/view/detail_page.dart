import 'package:flutter/material.dart';
import 'package:flutter_amiibo_responsive/bloc/amiibo_item/amiibo_item_cubit.dart';
import 'package:flutter_amiibo_responsive/model/amiibo_model.dart';
import 'package:flutter_amiibo_responsive/repository/amiibo_repository.dart';
import 'package:flutter_amiibo_responsive/utils/adaptive_contextual_layout.dart';
import 'package:flutter_amiibo_responsive/view/widgets/vertical_icon_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class DetailPage extends StatelessWidget {
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

class DetailView extends HookWidget {
  const DetailView({required this.amiiboId, super.key, this.type});

  final String? type;
  final String amiiboId;

  @override
  Widget build(BuildContext context) {
    final isDesktopOrTablet = [ScreenType.desktop, ScreenType.tablet].contains(
      context.formFactor,
    );

    useEffect(
      () {
        context.read<AmiiboItemCubit>().fetchAmiiboItem(type, amiiboId);
        return null;
      },
      const [],
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Builder(
          builder: (builderContext) => Text(
            builderContext.select(
              (AmiiboItemCubit value) => switch (value.state) {
                AmiiboItemStateInitial() => 'Loading',
                AmiiboItemStateSuccess(:final amiiboItem) => amiiboItem.name,
                AmiiboItemStateError() => 'Error',
              },
            ),
            style: const TextStyle(fontSize: 24),
          ),
        ),
      ),
      body: BlocBuilder<AmiiboItemCubit, AmiiboItemState>(
        builder: (_, state) {
          if (state is AmiiboItemStateSuccess) {
            return SingleChildScrollView(
              padding: isDesktopOrTablet
                  ? const EdgeInsets.symmetric(vertical: 24, horizontal: 16)
                  : null,
              child: isDesktopOrTablet
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: _AmiiboDetail(item: state.amiiboItem),
                        ),
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
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            );
          }

          return const Center(
            child: CircularProgressIndicator(color: Colors.redAccent),
          );
        },
      ),
    );
  }
}

class _AmiiboDetail extends StatelessWidget {
  const _AmiiboDetail({required this.item});

  final AmiiboModel item;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Hero(
          tag: '${item.head}_${item.tail}',
          child: Image.network(
            item.imageUrl,
            height: 350,
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(24),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        item.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      item.amiiboSeries,
                      style: TextStyle(color: Colors.grey[500]),
                    ),
                  ],
                ),
              ),
              Icon(Icons.art_track, color: Colors.blueGrey[500]),
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Text(
                  item.type,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _AmiiboButtons extends StatelessWidget {
  const _AmiiboButtons();

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        VerticalIconButton(
          icon: Icons.shopping_bag,
          text: 'Buy article',
          color: Colors.green,
        ),
        VerticalIconButton(
          icon: Icons.favorite,
          text: 'Add favorite',
          color: Colors.green,
        ),
        VerticalIconButton(
          icon: Icons.share,
          text: 'Share to...',
          color: Colors.green,
        ),
      ],
    );
  }
}

class _AmiiboDescription extends StatelessWidget {
  const _AmiiboDescription();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Text(
        _setLoremText(),
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  String _setLoremText() =>
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
