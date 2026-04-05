part of '../detail_page.dart';

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
    final options = <({IconData icon, String label})>[
      (icon: Icons.shopping_cart_outlined, label: 'MARKET'),
      (icon: Icons.share_outlined, label: 'SHARE'),
      (icon: Icons.info_outline, label: 'GUIDE'),
    ];

    return Padding(
      padding: .symmetric(horizontal: isDesktopOrTablet ? 0 : 24),
      child: Row(
        children: <Widget>[
          for (var i = 0; i < options.length; i++) ...[
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
                      Icon(options[i].icon, color: Colors.grey[500]),
                      Text(
                        options[i].label,
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
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: .circular(16),
        border: .all(color: Colors.grey[800]!),
      ),
      child: Padding(
        padding: const .all(16),
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
            padding: EdgeInsets.only(bottom: 4),
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
              letterSpacing: .5,
              color: Colors.grey[500],
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
