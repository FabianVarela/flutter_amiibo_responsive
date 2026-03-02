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
      body: BlocBuilder<AmiiboItemCubit, AmiiboItemState>(
        builder: (_, state) => switch (state) {
          AmiiboItemStateInitial() => Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(
                colorScheme.primaryContainer,
              ),
            ),
          ),
          AmiiboItemStateSuccess(:final amiiboItem) => CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: _AmiiboImageSection(item: amiiboItem),
              ),
              SliverToBoxAdapter(
                child: _AmiiboInfoSection(
                  item: amiiboItem,
                  isDesktopOrTablet: isDesktopOrTablet,
                ),
              ),
            ],
          ),
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

final class _AmiiboImageSection extends StatelessWidget {
  const _AmiiboImageSection({required this.item});

  final AmiiboModel item;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        SizedBox.fromSize(
          size: const .fromHeight(420),
          child: ColoredBox(
            color: Colors.black,
            child: Center(
              child: Hero(
                tag: '${item.head}_${item.tail}',
                child: Container(
                  margin: const .all(24),
                  decoration: BoxDecoration(
                    borderRadius: .circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: .3),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: .circular(24),
                    child: Image.network(
                      item.imageUrl,
                      height: 350,
                      fit: .cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: MediaQuery.paddingOf(context).top + 8,
          left: 8,
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).maybePop(),
          ),
        ),
      ],
    );
  }
}

final class _AmiiboInfoSection extends StatelessWidget {
  const _AmiiboInfoSection({
    required this.item,
    required this.isDesktopOrTablet,
  });

  final AmiiboModel item;
  final bool isDesktopOrTablet;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: const .vertical(top: .circular(24)),
      ),
      child: Padding(
        padding: const .symmetric(vertical: 20),
        child: Column(
          children: <Widget>[
            _SeriesBadge(series: item.amiiboSeries),
            const Gap(16),
            Text(
              item.name,
              textAlign: .center,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: .bold,
                color: Colors.white,
              ),
            ),
            const Gap(8),
            Text(
              '${item.amiiboSeries}  •  ${item.character.toUpperCase()}',
              textAlign: .center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
                letterSpacing: 1,
              ),
            ),
            const Gap(24),
            _ActionButtons(isDesktopOrTablet: isDesktopOrTablet),
            const Gap(32),
            if (item.releaseDate != null) ...[
              _RegionalReleasesSection(releaseDate: item.releaseDate!),
              const Gap(32),
            ],
            _SpecificationsSection(item: item),
          ],
        ),
      ),
    );
  }
}

final class _SeriesBadge extends StatelessWidget {
  const _SeriesBadge({required this.series});

  final String series;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const .symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: .circular(20),
        color: Colors.pink.withValues(alpha: .15),
        border: .all(color: Colors.pink.withValues(alpha: .3)),
      ),
      child: Row(
        spacing: 8,
        mainAxisSize: .min,
        children: <Widget>[
          Icon(Icons.games, size: 16, color: Colors.pink[300]),
          Text(
            '${series.toUpperCase()} SERIES',
            style: TextStyle(
              fontSize: 12,
              fontWeight: .bold,
              color: Colors.pink[300],
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}

final class _ActionButtons extends StatelessWidget {
  const _ActionButtons({required this.isDesktopOrTablet});

  final bool isDesktopOrTablet;

  @override
  Widget build(BuildContext context) {
    final optionList = <({IconData icon, String label})>[
      (icon: Icons.shopping_cart_outlined, label: 'MARKET'),
      (icon: Icons.share_outlined, label: 'SHARE'),
      (icon: Icons.info_outline, label: 'GUIDE'),
    ];

    return Padding(
      padding: .symmetric(horizontal: isDesktopOrTablet ? 48 : 24),
      child: Row(
        spacing: 16,
        children: <Widget>[
          for (final item in optionList)
            Expanded(
              child: InkWell(
                borderRadius: .circular(16),
                child: Container(
                  padding: const .symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    borderRadius: .circular(16),
                    border: .all(color: Colors.grey[700]!),
                  ),
                  child: Column(
                    spacing: 8,
                    children: <Widget>[
                      Icon(item.icon, color: Colors.grey[500]),
                      Text(
                        item.label,
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey[500],
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

final class _RegionalReleasesSection extends StatelessWidget {
  const _RegionalReleasesSection({required this.releaseDate});

  final ReleaseDateModel releaseDate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const .symmetric(horizontal: 24),
      child: Column(
        spacing: 12,
        crossAxisAlignment: .start,
        children: <Widget>[
          const Padding(
            padding: .only(bottom: 4),
            child: _SectionTitle(title: 'REGIONAL RELEASES'),
          ),
          Row(
            spacing: 12,
            children: <Widget>[
              Expanded(
                child: _ReleaseDateCard(
                  flag: '🇺🇸',
                  region: 'NORTH AMERICA',
                  date: releaseDate.northAm,
                ),
              ),
              Expanded(
                child: _ReleaseDateCard(
                  flag: '🇯🇵',
                  region: 'JAPAN',
                  date: releaseDate.japan,
                ),
              ),
            ],
          ),
          Row(
            spacing: 12,
            children: <Widget>[
              Expanded(
                child: _ReleaseDateCard(
                  flag: '🇪🇺',
                  region: 'EUROPE',
                  date: releaseDate.europe,
                ),
              ),
              Expanded(
                child: _ReleaseDateCard(
                  flag: '🇦🇺',
                  region: 'AUSTRALIA',
                  date: releaseDate.australia,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

final class _ReleaseDateCard extends StatelessWidget {
  const _ReleaseDateCard({
    required this.flag,
    required this.region,
    required this.date,
  });

  final String flag;
  final String region;
  final DateTime? date;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const .all(16),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: .circular(16),
        border: .all(color: Colors.grey[800]!),
      ),
      child: Column(
        spacing: 4,
        children: <Widget>[
          Padding(
            padding: const .only(bottom: 4),
            child: Text(flag, style: const TextStyle(fontSize: 24)),
          ),
          Text(
            region,
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey[500],
              letterSpacing: 1,
            ),
          ),
          Text(
            date != null ? DateFormat('yyyy-MM-dd').format(date!) : 'N/A',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: .bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

final class _SpecificationsSection extends StatelessWidget {
  const _SpecificationsSection({required this.item});

  final AmiiboModel item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const .symmetric(horizontal: 24),
      child: Column(
        spacing: 12,
        crossAxisAlignment: .start,
        children: <Widget>[
          const Padding(
            padding: .only(bottom: 4),
            child: _SectionTitle(title: 'SPECIFICATIONS'),
          ),
          _SpecificationRow(
            label: 'GAME SERIES',
            value: item.gameSeries ?? 'N/A',
          ),
          _SpecificationRow(label: 'AMIIBO SERIES', value: item.amiiboSeries),
          _SpecificationRow(label: 'TYPE', value: item.type),
          _SpecificationRow(label: 'CHARACTER', value: item.character),
        ],
      ),
    );
  }
}

final class _SpecificationRow extends StatelessWidget {
  const _SpecificationRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const .symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: .circular(12),
      ),
      child: Row(
        spacing: 16,
        mainAxisAlignment: .spaceBetween,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[500],
              letterSpacing: .5,
            ),
          ),
          Flexible(
            child: Text(
              value,
              textAlign: .end,
              overflow: .ellipsis,
              style: const TextStyle(fontSize: 14, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

final class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 12,
      children: <Widget>[
        SizedBox.fromSize(
          size: const Size(3, 16),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.pink[400],
              borderRadius: .circular(2),
            ),
          ),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            fontWeight: .bold,
            color: Colors.pink[400],
            letterSpacing: 1.5,
          ),
        ),
      ],
    );
  }
}
