import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_amiibo_responsive/bloc/amiibo_item/amiibo_item_cubit.dart';
import 'package:flutter_amiibo_responsive/model/amiibo_model.dart';
import 'package:flutter_amiibo_responsive/repository/amiibo_repository.dart';
import 'package:flutter_amiibo_responsive/utils/adaptive_contextual_layout.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

part 'widgets/detail_layout.dart';

part 'widgets/shared_widgets.dart';

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
    final screenTypes = <ScreenType>[.desktop, .tablet];
    final isDesktopOrTablet = screenTypes.contains(context.formFactor);

    useEffect(() {
      unawaited(
        context.read<AmiiboItemCubit>().fetchAmiiboItem(type, amiiboId),
      );
      return null;
    }, const []);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: isDesktopOrTablet
          ? AppBar(
              backgroundColor: colorScheme.primaryContainer,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).maybePop(),
              ),
              title: const Text('Amiibo App'),
            )
          : null,
      body: BlocBuilder<AmiiboItemCubit, AmiiboItemState>(
        builder: (_, state) => switch (state) {
          AmiiboItemStateInitial() => Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(
                colorScheme.primaryContainer,
              ),
            ),
          ),
          AmiiboItemStateSuccess(:final amiiboItem) =>
            isDesktopOrTablet
                ? _DesktopLayout(item: amiiboItem)
                : _MobileLayout(item: amiiboItem),
          AmiiboItemStateError() => Stack(
            children: <Widget>[
              const Center(
                child: Text(
                  'Error to get data',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: .bold,
                    color: Colors.white,
                  ),
                ),
              ),
              if (!isDesktopOrTablet)
                Positioned(
                  top: MediaQuery.paddingOf(context).top + 8,
                  left: 8,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.of(context).maybePop(),
                  ),
                ),
            ],
          ),
        },
      ),
    );
  }
}
