import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '{{projectName.titleCase()}}',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('{{projectName.titleCase()}}'),
        ),
        body: const Center(
          child: Text('Hello World'),
        ),
      ),
    );
  }
}