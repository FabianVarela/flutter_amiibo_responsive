import 'package:flutter/material.dart';
import 'package:flutter_amiibo_responsive/utils/adaptive_contextual_layout.dart';
import 'package:gap/gap.dart';

class UnknownPageUI extends StatelessWidget {
  const UnknownPageUI({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: const Text(
          'Not found',
          style: TextStyle(fontSize: 24),
        ),
      ),
      body: SizedBox(
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/mario 404.png',
              fit: BoxFit.contain,
              height: size.height * 0.4,
              width: size.width * 0.4,
            ),
            const Gap(50),
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
