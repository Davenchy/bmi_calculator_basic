import 'package:flutter/material.dart';

import 'app.dart';
import 'utils/bmi_memory.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await BMIMemory.initialize();
  runApp(const MyApp());
}
