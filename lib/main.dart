import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:logistics_directory_app/firebase_options.dart';

import 'app/root_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const RootApp();
  }
}
