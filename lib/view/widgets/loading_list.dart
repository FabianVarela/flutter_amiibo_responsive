import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class LoadingList extends StatelessWidget {
  const LoadingList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final fakeList = List.filled(20, 0);

    return GridView.extent(
      maxCrossAxisExtent: size.width >= 600 ? 300 : 200,
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
                minWidth: MediaQuery.of(context).size.width * 0.9,
              ),
            ),
          ),
      ],
    );
  }
}
