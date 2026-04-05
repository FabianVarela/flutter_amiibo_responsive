part of '../detail_page.dart';

final class _DesktopLayout extends StatelessWidget {
  const _DesktopLayout({required this.item});

  final AmiiboModel item;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: .start,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Container(
            color: Colors.grey[900],
            child: Center(
              child: Hero(
                tag: '${item.head}_${item.tail}',
                child: Container(
                  margin: const .all(32),
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
                    child: Image.network(item.imageUrl, fit: .contain),
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            color: Colors.grey[900],
            child: SingleChildScrollView(
              padding: const .all(32),
              child: Column(
                crossAxisAlignment: .start,
                children: <Widget>[
                  _SeriesBadge(series: item.amiiboSeries),
                  const Gap(16),
                  Text(
                    item.name,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: .bold,
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

final class _MobileLayout extends StatelessWidget {
  const _MobileLayout({required this.item});

  final AmiiboModel item;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: _MobileImageSection(item: item)),
        SliverToBoxAdapter(child: _MobileInfoSection(item: item)),
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
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                        color: Colors.black.withValues(alpha: .3),
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

final class _MobileInfoSection extends StatelessWidget {
  const _MobileInfoSection({required this.item});

  final AmiiboModel item;

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
