import 'package:flutter/material.dart';

class InitialScaffoldWidget extends StatelessWidget {
  const InitialScaffoldWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'EasyGPT Chat',
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('Initializing app. Please wait...'),
            SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }
}
