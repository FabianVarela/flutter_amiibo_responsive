import 'package:flutter/material.dart';
import 'package:flutter_amiibo_responsive/model/amiibo_model.dart';
import 'package:gap/gap.dart';

final class AmiiboItem extends StatelessWidget {
  const AmiiboItem({
    required this.amiibo,
    required this.onSelectAmiibo,
    super.key,
  });

  final AmiiboModel amiibo;
  final VoidCallback onSelectAmiibo;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Card(
      clipBehavior: .antiAlias,
      shape: RoundedRectangleBorder(borderRadius: .circular(6)),
      child: InkWell(
        onTap: onSelectAmiibo,
        child: Stack(
          fit: .expand,
          children: <Widget>[
            Hero(
              tag: '${amiibo.head}_${amiibo.tail}',
              child: Image.network(amiibo.imageUrl, fit: .cover),
            ),
            Positioned(
              bottom: 0,
              width: MediaQuery.sizeOf(context).width,
              child: ColoredBox(
                color: colorScheme.surfaceContainerHighest.withValues(
                  alpha: .6,
                ),
                child: Padding(
                  padding: const .all(8),
                  child: Column(
                    crossAxisAlignment: .start,
                    children: <Widget>[
                      Text(amiibo.name, style: const TextStyle(fontSize: 16)),
                      const Gap(2),
                      Text(
                        amiibo.gameSeries ?? 'Sin serie',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
