import 'package:flutter/material.dart';
import 'package:flutter_amiibo_responsive/model/amiibo_model.dart';

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
    return Card(
      clipBehavior: .antiAlias,
      shape: RoundedRectangleBorder(borderRadius: .circular(12)),
      child: InkWell(
        onTap: onSelectAmiibo,
        child: Stack(
          fit: .expand,
          children: <Widget>[
            Hero(
              tag: '${amiibo.head}_${amiibo.tail}',
              child: Image.network(amiibo.imageUrl, fit: .cover),
            ),
            Align(
              alignment: .topLeft,
              child: Padding(
                padding: const .only(top: 8, left: 8),
                child: _TypeBadge(type: amiibo.type),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: .bottomCenter,
                    end: .topCenter,
                    colors: [
                      Colors.black.withValues(alpha: .8),
                      Colors.black.withValues(alpha: 0),
                    ],
                  ),
                ),
                child: Padding(
                  padding: const .fromLTRB(12, 24, 12, 12),
                  child: Column(
                    spacing: 2,
                    crossAxisAlignment: .start,
                    children: <Widget>[
                      Text(
                        amiibo.name,
                        maxLines: 1,
                        overflow: .ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: .w600,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        amiibo.gameSeries ?? 'Unknown Series',
                        maxLines: 1,
                        overflow: .ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white.withValues(alpha: .8),
                        ),
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

class _TypeBadge extends StatelessWidget {
  const _TypeBadge({required this.type});

  final String type;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const .symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: .circular(4),
        color: switch (type.toLowerCase()) {
          'card' => Colors.red.shade700,
          'figure' => Colors.blue.shade700,
          'yarn' => Colors.purple.shade700,
          'band' => Colors.orange.shade700,
          _ => Colors.grey.shade700,
        },
      ),
      child: Text(
        type.toUpperCase(),
        style: const TextStyle(
          fontSize: 10,
          fontWeight: .bold,
          color: Colors.white,
          letterSpacing: .5,
        ),
      ),
    );
  }
}
