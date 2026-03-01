import 'package:flutter/material.dart';
import 'package:flutter_amiibo_responsive/bloc/game_series/game_series_cubit.dart';
import 'package:flutter_amiibo_responsive/utils/enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class DrawerMenu extends StatelessWidget {
  const DrawerMenu({
    required this.onSelectType,
    required this.onSelectGameSeries,
    this.makePop = true,
    this.selectedType,
    this.selectedGameSeries,
    super.key,
  });

  final ValueSetter<String?> onSelectType;
  final ValueSetter<String?> onSelectGameSeries;
  final bool makePop;
  final String? selectedType;
  final String? selectedGameSeries;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ListView(
      padding: .zero,
      children: <Widget>[
        DrawerHeader(
          decoration: BoxDecoration(color: colorScheme.primaryContainer),
          child: Container(
            alignment: AlignmentDirectional.bottomStart,
            child: const Text('Amiibo App', style: TextStyle(fontSize: 24)),
          ),
        ),
        _GameSeriesSection(
          onSelect: onSelectGameSeries,
          makePop: makePop,
          selectedGameSeries: selectedGameSeries,
        ),
        _FormatTypeSection(
          onSelect: onSelectType,
          makePop: makePop,
          selectedType: selectedType,
        ),
      ],
    );
  }
}

class _GameSeriesSection extends StatelessWidget {
  const _GameSeriesSection({
    required this.onSelect,
    required this.makePop,
    this.selectedGameSeries,
  });

  final ValueSetter<String?> onSelect;
  final bool makePop;
  final String? selectedGameSeries;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<GameSeriesCubit, GameSeriesState>(
      builder: (_, state) {
        return ExpansionTile(
          title: Text(
            'GAME SERIES',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurfaceVariant,
              letterSpacing: 1.2,
            ),
          ),
          initiallyExpanded: true,
          children: [
            _GameSeriesItem(
              name: 'All',
              icon: Icons.apps,
              isSelected: selectedGameSeries == null,
              onSelect: () {
                onSelect(null);
                if (makePop) Navigator.of(context).pop();
              },
            ),
            if (state is GameSeriesStateLoading)
              const Padding(
                padding: EdgeInsets.all(16),
                child: Center(child: CircularProgressIndicator()),
              )
            else if (state is GameSeriesStateSuccess)
              ...state.gameSeriesList.map(
                (series) => _GameSeriesItem(
                  name: series.name,
                  icon: _getIconForSeries(series.name),
                  isSelected: selectedGameSeries == series.name,
                  onSelect: () {
                    onSelect(series.name);
                    if (makePop) Navigator.of(context).pop();
                  },
                ),
              )
            else if (state is GameSeriesStateError)
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text('Error loading series'),
              ),
          ],
        );
      },
    );
  }

  IconData _getIconForSeries(String name) {
    final lowerName = name.toLowerCase();
    if (lowerName.contains('smash')) return Icons.sports_mma;
    if (lowerName.contains('zelda')) return Icons.shield;
    if (lowerName.contains('mario')) return Icons.star;
    if (lowerName.contains('animal crossing')) return Icons.home;
    if (lowerName.contains('splatoon')) return Icons.water_drop;
    if (lowerName.contains('pokemon')) return Icons.catching_pokemon;
    if (lowerName.contains('kirby')) return Icons.circle;
    if (lowerName.contains('fire emblem')) return Icons.local_fire_department;
    if (lowerName.contains('metroid')) return Icons.rocket;
    return Icons.videogame_asset;
  }
}

class _GameSeriesItem extends StatelessWidget {
  const _GameSeriesItem({
    required this.name,
    required this.icon,
    required this.onSelect,
    this.isSelected = false,
  });

  final String name;
  final IconData icon;
  final VoidCallback onSelect;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ListTile(
      dense: true,
      selected: isSelected,
      selectedTileColor: colorScheme.primaryContainer.withValues(alpha: .3),
      onTap: onSelect,
      leading: Icon(
        icon,
        size: 20,
        color: isSelected ? colorScheme.primary : colorScheme.onSurfaceVariant,
      ),
      title: Text(
        name,
        style: TextStyle(
          fontSize: 14,
          fontWeight: isSelected ? .w600 : .w400,
          color: isSelected
              ? colorScheme.primary
              : colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}

class _FormatTypeSection extends StatelessWidget {
  const _FormatTypeSection({
    required this.onSelect,
    required this.makePop,
    this.selectedType,
  });

  final ValueSetter<String?> onSelect;
  final bool makePop;
  final String? selectedType;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ExpansionTile(
      title: Text(
        'FORMAT TYPE',
        style: TextStyle(
          fontSize: 12,
          fontWeight: .bold,
          color: colorScheme.onSurfaceVariant,
          letterSpacing: 1.2,
        ),
      ),
      initiallyExpanded: true,
      children: AmiiboType.values.map((type) {
        return ListTile(
          dense: true,
          selected: selectedType == type.value,
          selectedTileColor: colorScheme.primaryContainer.withValues(alpha: .3),
          onTap: () {
            onSelect(type.value);
            if (makePop) Navigator.of(context).pop();
          },
          leading: Icon(
            type.icon,
            size: 20,
            color: selectedType == type.value
                ? colorScheme.primary
                : colorScheme.onSurfaceVariant,
          ),
          title: Text(
            type.text,
            style: TextStyle(
              fontSize: 14,
              fontWeight: selectedType == type.value ? .w600 : .w400,
              color: selectedType == type.value
                  ? colorScheme.primary
                  : colorScheme.onSurfaceVariant,
            ),
          ),
        );
      }).toList(),
    );
  }
}
