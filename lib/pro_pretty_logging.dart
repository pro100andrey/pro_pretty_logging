import 'dart:developer';

import 'package:logging/logging.dart';

export 'package:logging/logging.dart';

/// The type of output to use when pretty logging is enabled.
enum PrettyOutputType {
  /// Use the `print` function to output logs.
  print,

  /// Use the `log` function to output logs.
  log,
}

/// Configures and enables pretty logging in your Dart application.
///
/// Use this function to set up colorful and customizable log output for better
/// readability.
///
/// - [enable]: Set to `true` to enable pretty logging. Default is `false`.
///
/// - [ignoredLoggers]: A list of logger names that should be ignored when
/// logging. Default is `null`.
///
/// Example:
/// ```dart
/// import 'package:pro_pretty_logging/pro_pretty_logging.dart';
///
/// void main() {
///   prettyLogging(
///     enable: kDebugMode,
///     ignoredLoggers: ['GoRouter'],
///     type: PrettyOutputType.log,
///     level: Level.ALL,
///   );
///
///   // Continue with the rest of your application code
/// }
/// ```
void prettyLogging({
  bool enable = false,
  List<String>? ignoredLoggers,
  PrettyOutputType type = PrettyOutputType.log,
  Level level = Level.ALL,
}) {
  Logger.root.level = enable ? level : Level.OFF;

  if (!enable || level == Level.OFF) {
    return;
  }

  hierarchicalLoggingEnabled = true;

  Logger.root.onRecord.listen((rec) {
    if (!enable) {
      return;
    }

    if (ignoredLoggers?.toSet().contains(rec.loggerName) ?? false) {
      return;
    }

    const endColor = '\x1b[0m';
    const whiteColor = '\x1b[37m';
    const grayColor = '\x1b[90m';
    const infoColor = '\x1b[94m';
    const warningColor = '\x1b[93m';
    const severeColor = '\x1b[103m\x1b[31m';
    const shoutColor = '\x1b[41m\x1b[93m';
    const levelColor = '\x1b[93m';

    var startColor = grayColor;

    switch (rec.level) {
      case Level.INFO:
        startColor = infoColor;

      case Level.WARNING:
        startColor = warningColor;

      case Level.SEVERE:
        startColor = severeColor;

      case Level.SHOUT:
        startColor = shoutColor;
    }

    final fullMessage = '$whiteColor${rec.time}$endColor '
        '$levelColor${rec.level.name}$endColor '
        '$startColor${rec.message}$endColor';

    switch (type) {
      case PrettyOutputType.log:
        log(
          fullMessage,
          time: rec.time,
          name: rec.loggerName,
          sequenceNumber: rec.sequenceNumber,
          zone: rec.zone,
          level: rec.level.value,
          error: rec.error,
          stackTrace: rec.stackTrace,
        );
      case PrettyOutputType.print:
        // ignore: avoid_print
        print(fullMessage);
        return;
    }
  });
}
