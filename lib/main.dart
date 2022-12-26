// This code is distributed under the MIT License.
// Copyright (c) 2019 Remi Rousselet.
// You can find the original at https://github.com/rrousselGit/provider.

// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'main_state.dart';

// This is a reimplementation of the default Flutter application
// using provider + [ChangeNotifier].
void main() {
  runApp(
    // Providers are above [MyApp] instead of inside it, so that
    // tests can use [MyApp] while mocking the providers
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MainState()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Provider example'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text('You have pushed the button this many times:'),

            // Extracted as a separate widget for performance
            // optimization. As a separate widget, it will rebuild
            // independently from [MyHomePage].
            //
            // This is totally optional (and rarely needed).
            // Similarly, we could also use [Consumer] or
            // [Selector].
            Count(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        key: const Key('increment_floatingActionButton'),

        // Calls `context.read` instead of `context.watch` so
        // that it does not rebuild when [Counter] changes.
        onPressed: () => context.read<MainState>().incrementCounter(),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class Count extends StatelessWidget {
  const Count({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var state = context.watch<MainState>();
    return Text(
      // Calls `context.watch` to make [Count] rebuild when
      // [Counter] changes.
      '${state.currentCount}',
      key: const Key('counterState'),
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}
