import 'package:flutter/material.dart';
import 'package:flutter_amiibo_responsive/utils/adaptive_contextual_layout.dart';
import 'package:gap/gap.dart';

final class UnknownPageUI extends StatelessWidget {
  const UnknownPageUI({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.primaryContainer,
        title: const Text('Not found', style: TextStyle(fontSize: 24)),
      ),
      body: SizedBox(
        width: size.width,
        child: Column(
          mainAxisAlignment: .center,
          children: <Widget>[
            SizedBox.fromSize(
              size: Size(size.width * .5, size.height * .5),
              child: Image.asset('assets/images/mario 404.png', fit: .contain),
            ),
            const Gap(30),
            Text(
              webSegments.contains(currentDevice)
                  ? 'Oops!!! Page not found'
                  : 'Oops!!! Screen not found',
              style: const TextStyle(fontSize: 30),
            ),
          ],
        ),
      ),
    );
  }
}
