import 'package:flutter/material.dart';

import '../commons/commons.dart';
import 'layers/main/main.dart';

@pragma("vm:entry-point")
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  instanceUrl();
  runApp(const App());
}
