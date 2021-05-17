import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';

import 'package:quiz/pages/home.dart';

void main() async {
  // Load configuration
  WidgetsFlutterBinding.ensureInitialized();
  await GlobalConfiguration().loadFromAsset('app_settings');

  runApp(Application());
}

class Application extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz',
      home: HomePage(),
    );
  }
}
