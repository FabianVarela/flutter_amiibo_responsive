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
          AmiiboItemStateSuccess(:final amiiboItem) => isDesktopOrTablet
              ? _DesktopLayout(item: amiiboItem)
              : _MobileLayout(item: amiiboItem),
          AmiiboItemStateError() => Stack(
              children: <Widget>[
                const Center(
                  child: Text(
                    'Error to get data',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
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

// Desktop/Tablet: Image left, content right
final class _DesktopLayout extends StatelessWidget {
  const _DesktopLayout({required this.item});

  final AmiiboModel item;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left: Image
        Expanded(
          flex: 2,
          child: Container(
            color: Colors.grey[900],
            child: Center(
              child: Hero(
                tag: '${item.head}_${item.tail}',
                child: Container(
                  margin: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: .3),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Image.network(
                      item.imageUrl,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        // Right: Content
        Expanded(
          flex: 3,
          child: Container(
            color: Colors.grey[900],
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SeriesBadge(series: item.amiiboSeries),
                  const Gap(16),
                  Text(
                    item.name,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const Gap(8),
                  Text(
                    '${item.amiiboSeries}  •  ${item.character.toUpperCase()}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[500],
                      letterSpacing: 1,
                    ),
                  ),
                  const Gap(24),
                  const _ActionButtons(isDesktopOrTablet: true),
                  const Gap(32),
                  if (item.releaseDate != null) ...[
                    _RegionalReleasesSection(releaseDate: item.releaseDate!),
                    const Gap(32),
                  ],
                  _SpecificationsSection(item: item),
                  const Gap(32),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Mobile: Vertical layout
final class _MobileLayout extends StatelessWidget {
  const _MobileLayout({required this.item});

  final AmiiboModel item;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: _MobileImageSection(item: item),
        ),
        SliverToBoxAdapter(
          child: _MobileInfoSection(item: item),
        ),
      ],
    );
  }
}

final class _MobileImageSection extends StatelessWidget {
  const _MobileImageSection({required this.item});

  final AmiiboModel item;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 420,
          width: double.infinity,
          child: ColoredBox(
            color: Colors.black,
            child: Center(
              child: Hero(
                tag: '${item.head}_${item.tail}',
                child: Container(
                  margin: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: .3),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Image.network(
                      item.imageUrl,
                      height: 350,
                      fit: BoxFit.cover,
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

final class _MobileInfoSection extends StatelessWidget {
  const _MobileInfoSection({required this.item});

  final AmiiboModel item;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            _SeriesBadge(series: item.amiiboSeries),
            const Gap(16),
            Text(
              item.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const Gap(8),
            Text(
              '${item.amiiboSeries}  •  ${item.character.toUpperCase()}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
                letterSpacing: 1,
              ),
            ),
            const Gap(24),
            const _ActionButtons(isDesktopOrTablet: false),
            const Gap(32),
            if (item.releaseDate != null) ...[
              _RegionalReleasesSection(releaseDate: item.releaseDate!),
              const Gap(32),
            ],
            _SpecificationsSection(item: item),
            const Gap(32),
          ],
        ),
      ),
    );
  }
}

// Shared widgets

final class _SeriesBadge extends StatelessWidget {
  const _SeriesBadge({required this.series});

  final String series;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.pink.withValues(alpha: .15),
        border: Border.all(color: Colors.pink.withValues(alpha: .3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.games, size: 16, color: Colors.pink[300]),
          const Gap(8),
          Text(
            '${series.toUpperCase()} SERIES',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
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
    final options = [
      (Icons.shopping_cart_outlined, 'MARKET'),
      (Icons.share_outlined, 'SHARE'),
      (Icons.info_outline, 'GUIDE'),
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isDesktopOrTablet ? 0 : 24),
      child: Row(
        children: [
          for (var i = 0; i < options.length; i++) ...[
            Expanded(
              child: InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey[700]!),
                  ),
                  child: Column(
                    children: [
                      Icon(options[i].$1, color: Colors.grey[500]),
                      const Gap(8),
                      Text(
                        options[i].$2,
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
            if (i < options.length - 1) const Gap(16),
          ],
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
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionTitle(title: 'REGIONAL RELEASES'),
          const Gap(16),
          Row(
            children: [
              Expanded(
                child: _ReleaseDateCard(
                  flag: '🇺🇸',
                  region: 'NORTH AMERICA',
                  date: releaseDate.northAm,
                ),
              ),
              const Gap(12),
              Expanded(
                child: _ReleaseDateCard(
                  flag: '🇯🇵',
                  region: 'JAPAN',
                  date: releaseDate.japan,
                ),
              ),
            ],
          ),
          const Gap(12),
          Row(
            children: [
              Expanded(
                child: _ReleaseDateCard(
                  flag: '🇪🇺',
                  region: 'EUROPE',
                  date: releaseDate.europe,
                ),
              ),
              const Gap(12),
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
    final formattedDate =
        date != null ? DateFormat('yyyy-MM-dd').format(date!) : 'N/A';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[800]!),
      ),
      child: Column(
        children: [
          Text(flag, style: const TextStyle(fontSize: 24)),
          const Gap(8),
          Text(
            region,
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey[500],
              letterSpacing: 1,
            ),
          ),
          const Gap(4),
          Text(
            formattedDate,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
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
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionTitle(title: 'SPECIFICATIONS'),
          const Gap(16),
          _SpecificationRow(
            label: 'GAME SERIES',
            value: item.gameSeries ?? 'N/A',
          ),
          const Gap(12),
          _SpecificationRow(label: 'AMIIBO SERIES', value: item.amiiboSeries),
          const Gap(12),
          _SpecificationRow(label: 'TYPE', value: item.type),
          const Gap(12),
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[500],
              letterSpacing: 0.5,
            ),
          ),
          const Gap(16),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              overflow: TextOverflow.ellipsis,
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
      children: [
        Container(
          width: 3,
          height: 16,
          decoration: BoxDecoration(
            color: Colors.pink[400],
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const Gap(12),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.pink[400],
            letterSpacing: 1.5,
          ),
        ),
      ],
    );
  }
}
