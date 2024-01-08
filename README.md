# pro_pretty_logging

The `pro_pretty_logging` library provides a grade solution for enhancing logging in your Dart applications. It offers robust customization options for log output, including colorful formatting, filtering, and improved readability. With `pro_pretty_logging`, you can take control of your logging experience.

## Installation

To use this library, add it to your project's dependencies in the `pubspec.yaml` file:

```yaml
dependencies:
  pro_pretty_logging: ^version
```

Then, run `flutter pub get` or `dart pub get` to install the library.

## Usage

Import the library and utilize the `prettyLogging()` function with the desired parameters in your code:

```dart
import 'package:pro_pretty_logging/pro_pretty_logging.dart';

void main() {
  prettyLogging(
    enable: kDebugMode,
    ignoredLoggers: ['GoRouter'],
    type: PrettyOutputType.log,
    level: Level.ALL,
  );
  
  // Continue with the rest of your application code
}
```

# License

This library is distributed under the MIT License. Detailed licensing information is available in the [LICENSE](LICENSE) file.
