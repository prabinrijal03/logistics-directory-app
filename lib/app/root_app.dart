import 'package:flutter/material.dart';

import '../resources/route_manager.dart';

class RootApp extends StatelessWidget {
  const RootApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoute.initialRoute.path,
      onGenerateRoute: AppRoute.getRoute,
    );
  }
}
