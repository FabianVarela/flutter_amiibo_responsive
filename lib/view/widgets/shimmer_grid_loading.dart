import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

final class ShimmerGridLoading extends StatelessWidget {
  const ShimmerGridLoading({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final fakeList = List.filled(20, 0);

    return GridView.extent(
      maxCrossAxisExtent: width >= 600 ? 300 : 200,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      padding: const EdgeInsets.all(8),
      childAspectRatio: 1 / 1.2,
      children: <Widget>[
        for (var i = 0; i < fakeList.length; i++)
          Shimmer(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(8),
              ),
              constraints: BoxConstraints(
                minHeight: 200,
                minWidth: width * 0.9,
              ),
            ),
          ),
      ],
    );
  }
}
