import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pro_pretty_logging/pro_pretty_logging.dart';

void main() {
  prettyLogging(
    enable: kDebugMode,
    ignoredLoggers: ['GoRouter'],
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => const MaterialApp(
        home: MyHomePage(),
      );
}

final _logger = Logger('MyHomePage');

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                child: const Text('LogIn'),
                onPressed: () {
                  _logger
                    ..info('info example')
                    ..fine('fine example')
                    ..severe('severe example')
                    ..shout('shout example')
                    ..warning('warning example');
                },
              ),
            ],
          ),
        ),
      );
}
