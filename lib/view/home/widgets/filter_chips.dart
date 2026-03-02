import 'package:flutter/material.dart';
import 'package:flutter_amiibo_responsive/bloc/amiibo_series/amiibo_series_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

final class FilterChipsSection extends StatelessWidget {
  const FilterChipsSection({
    required this.onSelectAmiiboSeries,
    this.selectedAmiiboSeries,
    super.key,
  });

  final String? selectedAmiiboSeries;
  final ValueSetter<String?> onSelectAmiiboSeries;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<AmiiboSeriesCubit, AmiiboSeriesState>(
      builder: (_, state) => switch (state) {
        AmiiboSeriesStateSuccess(:final amiiboSeriesList) => Column(
          crossAxisAlignment: .start,
          children: <Widget>[
            if (amiiboSeriesList.isEmpty)
              const SizedBox.shrink()
            else ...[
              Padding(
                padding: const .symmetric(horizontal: 12, vertical: 8),
                child: Text(
                  'SERIES',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: .bold,
                    color: colorScheme.onSurfaceVariant,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              SizedBox(
                height: 40,
                child: ListView.separated(
                  scrollDirection: .horizontal,
                  itemCount: amiiboSeriesList.length + 1,
                  padding: const .symmetric(horizontal: 12),
                  separatorBuilder: (_, _) => const Gap(8),
                  itemBuilder: (_, index) {
                    if (index == 0) {
                      final isSelected = selectedAmiiboSeries == null;
                      return FilterChip(
                        selected: isSelected,
                        label: const Text('All'),
                        onSelected: (_) => onSelectAmiiboSeries(null),
                        selectedColor: colorScheme.primaryContainer,
                        checkmarkColor: colorScheme.primary,
                        labelStyle: TextStyle(
                          color: isSelected
                              ? colorScheme.onPrimaryContainer
                              : colorScheme.onSurfaceVariant,
                          fontWeight: isSelected ? .w600 : .w400,
                        ),
                      );
                    }

                    final series = amiiboSeriesList[index - 1];
                    final isSelected = selectedAmiiboSeries == series.name;

                    return FilterChip(
                      selected: isSelected,
                      label: Text(series.name),
                      onSelected: (_) => onSelectAmiiboSeries(series.name),
                      selectedColor: colorScheme.primaryContainer,
                      checkmarkColor: colorScheme.primary,
                      labelStyle: TextStyle(
                        color: isSelected
                            ? colorScheme.onPrimaryContainer
                            : colorScheme.onSurfaceVariant,
                        fontWeight: isSelected ? .w600 : .w400,
                      ),
                    );
                  },
                ),
              ),
            ],
          ],
        ),
        _ => const SizedBox.shrink(),
      },
    );
  }
}
