import 'package:flutter/widgets.dart';
import 'package:flutter_demonstration_app/core/app_locator.dart';
import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupLocator();
  runApp(const App());
}
