import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class UnknownPageUI extends StatelessWidget {
  const UnknownPageUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
            const SizedBox(height: 50),
            const Text(
              kIsWeb ? 'Oops!!! Page not found' : 'Oops!!! Screen not found',
              style: TextStyle(fontSize: 30),
            ),
          ],
        ),
      ),
    );
  }
}
